vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.o.background == "dark" then
      vim.cmd("colorscheme astrodark")
    else
      vim.cmd("colorscheme astrolight")
    end
  end,
})

-- Set initial theme
if vim.o.background == "dark" then
  vim.cmd("colorscheme nightfox")
else
  vim.cmd("colorscheme dayfox")
end
