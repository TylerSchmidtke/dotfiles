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
$env.XDG_CONFIG_HOME = $"($nu.home-path)/.config"
$env.PATH = ($env.PATH | append "/usr/local/bin" | append "/opt/homebrew/bin" | append $"($nu.home-path)/go")

# Editor
$env.config.buffer_editor = "nvim"

# Dotfiles
alias dot = /usr/bin/git --git-dir=$"($nu.home-path)/.cfg/" --work-tree=$"($nu.home-path)"

# Overrides
alias nu-open = open
alias open = ^open

# pyenv
$env.PYENV_ROOT = "~/.pyenv" | path expand
if (( $"($env.PYENV_ROOT)/bin" | path type ) == "dir") {
  $env.PATH = $env.PATH | prepend $"($env.PYENV_ROOT)/bin"
}
$env.PATH = $env.PATH | prepend $"(pyenv root)/shims"

# Themes
def --env day [] {
  source $"($nu.home-path)/.config/nushell/themes/github-light-colorblind.nu"
}
def --env night [] {
  source $"($nu.home-path)/.config/nushell/themes/github-dark-colorblind.nu"
}



# Local Machine
source ~/.config/nushell/local.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
