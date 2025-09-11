return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
      })

      -- C++ configuration using GDB
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      dap.configurations.cpp = {
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Attach (GDB)",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = '${workspaceFolder}'
        },
      }

      -- Use same config for C
      dap.configurations.c = dap.configurations.cpp

      -- Automatically open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Key mappings
      vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP Continue" })
      vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "DAP Step Over" })
      vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "DAP Step Into" })
      vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "DAP Step Out" })
      vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
      vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end, { desc = "DAP Set Breakpoint" })
      vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "DAP Open REPL" })
      vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "DAP Run Last" })
      vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end, { desc = "DAP Hover" })
      vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end, { desc = "DAP Preview" })
      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end, { desc = "DAP Frames" })
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end, { desc = "DAP Scopes" })
      vim.keymap.set('n', '<Leader>du', function() dapui.toggle() end, { desc = "DAP UI Toggle" })
    end,
  },
}