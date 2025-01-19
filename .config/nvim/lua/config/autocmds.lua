-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(_)
    vim.bo.formatexpr = ""
    vim.bo.formatprg = "jq"
    print("It's a json file")
  end,
})
