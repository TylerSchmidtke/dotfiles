return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("github-theme").setup {
      -- ...
    }

    -- Function to detect and set colorscheme
    local function set_colorscheme_from_system()
      local is_dark = false

      if vim.fn.has("mac") == 1 then
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        is_dark = result:match("Dark") ~= nil
      else
        -- KDE Plasma: read ColorScheme from kdeglobals
        local handle = io.popen("kreadconfig6 --group General --key ColorScheme --file kdeglobals 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        is_dark = result:lower():match("dark") ~= nil
      end

      if is_dark then
        vim.cmd "colorscheme github_dark_colorblind"
      else
        vim.cmd "colorscheme github_light_colorblind"
      end
    end

    -- Set initial colorscheme
    set_colorscheme_from_system()

    -- Create command to manually refresh
    vim.api.nvim_create_user_command("RefreshTheme", set_colorscheme_from_system, {})
  end,
}
