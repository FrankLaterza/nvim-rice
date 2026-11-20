local nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil
return {
  { "mason-org/mason.nvim", enabled = not nixos },
  { "mason-org/mason-lspconfig.nvim", enabled = not nixos },
}
