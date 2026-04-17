---@type LazySpec
return {
  {
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "nvim-treesitter/nvim-treesitter" },
    cond = function()
      return vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 1
    end,
    config = function()
      require("godotdev").setup({
        autostart_editor_server = true,
      })
    end,
  },
}
