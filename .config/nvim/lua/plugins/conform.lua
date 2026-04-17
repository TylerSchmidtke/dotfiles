---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      sql = { "sql_formatter" },
      mysql = { "sql_formatter" },
    },
  },
  keys = {
    {
      "<Leader>lf",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      desc = "Format buffer",
      ft = { "sql", "mysql" },
    },
  },
}
