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
  append $"($nu.home-dir)/.opencode/bin" |
  append $"($nu.home-dir)/.dotnet/tools"
)

# Editor
$env.config.buffer_editor = "nvim"

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

# Themes — switch nushell + helix + starship together.
# Palette/theme names match across all three (oksolar_dark/light/sky).
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
}
def --env day [] {
  source $"($nu.home-dir)/.config/nushell/themes/oksolar-light.nu"
  set-theme oksolar_light
}
def --env night [] {
  source $"($nu.home-dir)/.config/nushell/themes/oksolar-dark.nu"
  set-theme oksolar_dark
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

# Local Machine
source ~/.config/nushell/local.nu

# Functions - written to vendor/autoload, available on next shell launch
mkdir ~/.config/nushell/functions
mkdir ($nu.data-dir | path join "vendor/autoload")
glob ~/.config/nushell/functions/*.nu | each { |f| $"source ($f)\n" } | str join | save -f ($nu.data-dir | path join "vendor/autoload/functions.nu")

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source $"($nu.home-dir)/.cargo/env.nu"
