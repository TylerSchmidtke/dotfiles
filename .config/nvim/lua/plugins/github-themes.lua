-- Alternate colorscheme, kept installed for occasional use. The active theme
-- (oksolar) and system-based light/dark switching now live in colorscheme.lua.
-- Lazy-loaded; lazy.nvim auto-loads it when you `:colorscheme github_*`.
return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  lazy = true,
  config = function()
    require("github-theme").setup {
      -- ...
    }
  end,
}
