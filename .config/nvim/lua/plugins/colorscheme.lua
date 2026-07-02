-- Active colorscheme + system-aware light/dark switching.
-- Detects the OS appearance and applies the matching oksolar variant. AstroUI
-- owns applying `colorscheme`, so setting it here avoids a startup flash.

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = function(_, opts)
    -- Detect the OS light/dark preference and return the oksolar variant to use.
    local function system_colorscheme()
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

      return is_dark and "oksolar_dark" or "oksolar_light"
    end

    -- Pick the initial colorscheme from the current system appearance.
    opts.colorscheme = system_colorscheme()

    -- :RefreshTheme re-detects the system appearance and re-applies the theme.
    vim.api.nvim_create_user_command(
      "RefreshTheme",
      function() vim.cmd.colorscheme(system_colorscheme()) end,
      { desc = "Set colorscheme from system light/dark mode" }
    )
  end,
}
