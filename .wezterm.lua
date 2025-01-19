-- Pull in the wezterm API
local os = require("os")
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local session_manager = require("wezterm-session-manager/session-manager")

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

local move_around = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/.local/bin/wezterm.nvim.navigator"
			.. " "
			.. direction_nvim
	)
	if result then
		window:perform_action(act({ SendString = "\x17" .. direction_nvim }), pane)
	else
		window:perform_action(act({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

wezterm.on("toggle-colorscheme", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.color_scheme then
		overrides.color_scheme = "catppuccin-latte"
	else
		overrides.color_scheme = nil
	end
	window:set_config_overrides(overrides)
end)

-- For example, changing the color scheme:
config = {
	color_scheme = "catppuccin-macchiato",
	font = wezterm.font("JetBrains Mono"),
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	hide_mouse_cursor_when_typing = true,
	native_macos_fullscreen_mode = true,
	window_decorations = "RESIZE",
	audible_bell = "Disabled",

	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = "#575757",
		},
	},
	unix_domains = {
		{
			name = "unix",
		},
	},

	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act({ PasteFrom = "Clipboard" }),
		},
	},
	leader = { key = "a", mods = "CMD", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "e",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-colorscheme"),
		},
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		-- splitting
		{
			mods = "LEADER",
			key = "-",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "=",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "m",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			mods = "LEADER",
			key = "Space",
			action = wezterm.action.RotatePanes("Clockwise"),
		},
		-- show the pane selection mode, but have it swap the active and selected panes
		{
			mods = "LEADER",
			key = "0",
			action = wezterm.action.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		{
			key = ",",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = act.ShowTabNavigator,
		},
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "&",
			mods = "LEADER|SHIFT",
			action = act.CloseCurrentTab({ confirm = true }),
		},
		-- ALT + (h,j,k,l) to move between panes
		{
			key = "h",
			mods = "ALT",
			action = act({ EmitEvent = "move-left" }),
		},
		{
			key = "j",
			mods = "ALT",
			action = act({ EmitEvent = "move-down" }),
		},
		{
			key = "k",
			mods = "ALT",
			action = act({ EmitEvent = "move-up" }),
		},
		{
			key = "l",
			mods = "ALT",
			action = act({ EmitEvent = "move-right" }),
		},
		{
			key = ";",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Prev"),
		},
		{
			key = "o",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Next"),
		},
		-- Attach to muxer
		{
			key = "a",
			mods = "LEADER",
			action = act.AttachDomain("unix"),
		},

		-- Detach from muxer
		{
			key = "d",
			mods = "LEADER",
			action = act.DetachDomain({ DomainName = "unix" }),
		},
		-- Rename current session; analagous to command in tmux
		{
			key = "$",
			mods = "LEADER|SHIFT",
			action = act.PromptInputLine({
				description = "Enter new name for session",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						mux.rename_workspace(window:mux_window():get_workspace(), line)
					end
				end),
			}),
		},
		-- Show list of workspaces
		{
			key = "s",
			mods = "LEADER",
			action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
		},
		-- Session manager bindings
		{
			key = "s",
			mods = "LEADER|SHIFT",
			action = act({ EmitEvent = "save_session" }),
		},
		{
			key = "L",
			mods = "LEADER|SHIFT",
			action = act({ EmitEvent = "load_session" }),
		},
		{
			key = "R",
			mods = "LEADER|SHIFT",
			action = act({ EmitEvent = "restore_session" }),
		},
		{
			key = "H",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "J",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
		{
			key = "L",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
	},
}

-- and finally, return the configuration to wezterm
return config
