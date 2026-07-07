# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
$env.config.show_banner = false


# Path
$env.XDG_CONFIG_HOME = $"($nu.home-dir)/.config"
$env.PATH = (
  $env.PATH |
  append "/usr/local/bin" |
  append "/opt/homebrew/bin" |
  append $"($nu.home-dir)/go/bin" |
  append $"($nu.home-dir)/.local/bin" |
  append $"/opt/homebrew/opt/llvm/bin" |
  append $"($nu.home-dir)/.opencode/bin" |
  append $"($nu.home-dir)/.dotnet/tools"
)

# Editor
$env.config.buffer_editor = "hx"
$env.EDITOR = "hx"

# Lazygit: merge base config + the switchable OKSolar theme (active.yml symlink,
# re-pointed by `set-theme`). Diff colors still come from the terminal palette.
$env.LG_CONFIG_FILE = ([
  ($nu.home-dir | path join ".config/lazygit/config.yml")
  ($nu.home-dir | path join ".config/lazygit/themes/active.yml")
] | str join ",")

# Dotfiles
alias dot = /usr/bin/git --git-dir=$"($nu.home-dir)/.cfg/" --work-tree=$"($nu.home-dir)"

# Overrides
alias mopen = ^open

# Themes — switch nushell + helix + starship + lazygit + aerc + gitui + tuicr together.
# Palette/theme names match across all of them (e.g. github_dark_colorblind).
def set-theme [name: string] {
  # Helix: rewrite `theme = "..."`, then live-reload open editors (SIGUSR1)
  let hx_cfg = ($nu.home-dir | path join ".config/helix/config.toml")
  open --raw $hx_cfg
  | str replace --regex '(?m)^theme = ".*"' $'theme = "($name)"'
  | save --force $hx_cfg
  try { pkill -USR1 -x hx }
  # Starship: rewrite `palette = "..."` (re-read on next prompt automatically)
  let ss_cfg = ($nu.home-dir | path join ".config/starship.toml")
  open --raw $ss_cfg
  | str replace --regex '(?m)^palette = ".*"' $'palette = "($name)"'
  | save --force $ss_cfg
  # Lazygit: re-point the active theme symlink (picked up on next `lazygit` launch)
  let lg_theme = ($nu.home-dir | path join $".config/lazygit/themes/($name)_colorblind.yml")
  let lg_active = ($nu.home-dir | path join ".config/lazygit/themes/active.yml")
  if ($lg_theme | path exists) { ^ln -sf $lg_theme $lg_active }
  # gitui: re-point the active theme.ron symlink (picked up on next `gitui` launch)
  let gitui_theme = ($nu.home-dir | path join $".config/gitui/($name).ron")
  let gitui_active = ($nu.home-dir | path join ".config/gitui/theme.ron")
  if ($gitui_theme | path exists) { ^ln -sf $gitui_theme $gitui_active }
  # aerc: rewrite `styleset-name=...` (aerc reads it on next launch)
  let aerc_cfg = ($nu.home-dir | path join ".config/aerc/aerc.conf")
  let aerc_styleset = ($nu.home-dir | path join $".config/aerc/stylesets/($name)")
  if ($aerc_styleset | path exists) and ($aerc_cfg | path exists) {
    open --raw $aerc_cfg
    | str replace --regex '(?m)^#?styleset-name=.*' $'styleset-name=($name)'
    | save --force $aerc_cfg
  }
  # tuicr: rewrite `theme = "..."` in config.toml (tuicr reads it on next launch)
  let tuicr_cfg = ($nu.home-dir | path join ".config/tuicr/config.toml")
  let tuicr_theme = ($nu.home-dir | path join $".config/tuicr/themes/($name).toml")
  if ($tuicr_theme | path exists) and ($tuicr_cfg | path exists) {
    open --raw $tuicr_cfg
    | str replace --regex '(?m)^theme = ".*"' $'theme = "($name)"'
    | save --force $tuicr_cfg
  }
}
def --env day [] {
  source $"($nu.home-dir)/.config/nushell/themes/github-light-colorblind.nu"
  set-theme github_light_colorblind
}
def --env night [] {
  source $"($nu.home-dir)/.config/nushell/themes/github-dark-colorblind.nu"
  set-theme github_dark_colorblind
}

# Ghostty
def ghostty-xterm-ssh [string] {
  infocmp -x xterm-ghostty | ssh $string -- tic -x -
}

# Aliases
alias ssh-no-key = ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no
alias gha-watch = gh pr checks --watch
alias gha-failed-logs = gh run view --log-failed


# fnm
if not (which fnm | is-empty) {
    ^fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
    $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD? | append {
            condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
            code: {|| ^fnm use --silent-if-unchanged}
        }
    )
}



# Rustup
if ($"($nu.home-dir)/.cargo/env.nu" | path exists) {
    source $"($nu.home-dir)/.cargo/env.nu"
}

# Default venv
#if ($"($nu.home-dir)/.venv/bin/activate.nu" | path exists) {
#    overlay use $"($nu.home-dir)/.venv/bin/activate.nu"
#}

# Easy pause and resume
$env.config.keybindings ++= [
  {
    name: "unfreeze",
    modifier: control,
    keycode: "char_z",
    event: {
      send: executehostcommand,
      cmd: "job unfreeze"
    },
    mode: emacs
  }
]

# Yazi file management
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}

# Local Machine
source ~/.config/nushell/local.nu

# Functions - written to vendor/autoload, available on next shell launch
mkdir ~/.config/nushell/functions
mkdir ($nu.data-dir | path join "vendor/autoload")
glob ~/.config/nushell/functions/*.nu | each { |f| $"source ($f)\n" } | str join | save -f ($nu.data-dir | path join "vendor/autoload/functions.nu")

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source $"($nu.home-dir)/.cargo/env.nu"
