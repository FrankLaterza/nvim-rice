-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shell = "/usr/bin/zsh"

if vim.env.SSH_TTY then
  opt.clipboard:append("unnamedplus")
  -- OSC 52 can write to the terminal clipboard but most terminals refuse to
  -- read it back, so keep a local copy of everything written and return that
  -- on paste. Covers direct setreg() callers (e.g. snacks explorer yank/paste),
  -- which bypass the unnamed register.
  local osc52 = require("vim.ui.clipboard.osc52")
  local stash = { ["+"] = { {} }, ["*"] = { {} } }
  local function copy(reg)
    local osc_copy = osc52.copy(reg)
    return function(lines, regtype)
      stash[reg] = { lines, regtype }
      osc_copy(lines)
    end
  end
  local function paste(reg)
    return function()
      return stash[reg]
    end
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = copy("+"),
      ["*"] = copy("*"),
    },
    paste = {
      ["+"] = paste("+"),
      ["*"] = paste("*"),
    },
  }
end
