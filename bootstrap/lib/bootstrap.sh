# shellcheck shell=bash

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/TylerSchmidtke/dotfiles.git}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"
DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.cfg}"
DOTFILES_FORCE="${DOTFILES_FORCE:-0}"
DOTFILES_USE_HTTPS_FOR_GITHUB="${DOTFILES_USE_HTTPS_FOR_GITHUB:-1}"
SET_LOGIN_SHELL="${SET_LOGIN_SHELL:-0}"

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'warning: %s\n' "$*" >&2
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

has() {
  command -v "$1" >/dev/null 2>&1
}

as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif has sudo; then
    sudo "$@"
  else
    die "need root privileges for: $*"
  fi
}

run_optional() {
  if ! "$@"; then
    warn "failed: $*"
  fi
}

dot() {
  git --git-dir="${DOTFILES_DIR}" --work-tree="${HOME}" -C "${HOME}" "$@"
}

install_each() {
  local installer="$1"
  shift

  local package
  for package in "$@"; do
    log "install ${package}"
    run_optional "${installer}" "${package}"
  done
}

ensure_git() {
  has git || die "git is required before checking out dotfiles"
}

checkout_dotfiles() {
  ensure_git

  if [ ! -d "${DOTFILES_DIR}" ]; then
    log "clone dotfiles into ${DOTFILES_DIR}"
    git clone --bare --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"
  else
    log "update existing dotfiles repo"
    run_optional dot fetch origin "${DOTFILES_BRANCH}"
  fi

  dot config --local status.showUntrackedFiles no
  if [ "${DOTFILES_USE_HTTPS_FOR_GITHUB}" = "1" ]; then
    dot config --local url.https://github.com/.insteadOf git@github.com:
  fi

  log "check out dotfiles"
  if dot checkout "${DOTFILES_BRANCH}"; then
    :
  elif [ "${DOTFILES_FORCE}" = "1" ]; then
    warn "forcing dotfile checkout; local conflicting files may be overwritten"
    dot checkout -f "${DOTFILES_BRANCH}"
  else
    die "dotfile checkout had conflicts; rerun with DOTFILES_FORCE=1 on a fresh machine"
  fi

  if dot rev-parse --verify --quiet "origin/${DOTFILES_BRANCH}" >/dev/null; then
    log "fast-forward dotfiles"
    if [ "${DOTFILES_FORCE}" = "1" ]; then
      dot reset --hard "origin/${DOTFILES_BRANCH}"
    else
      run_optional dot merge --ff-only "origin/${DOTFILES_BRANCH}"
    fi
  fi

  log "update dotfile submodules"
  run_optional dot submodule sync --recursive
  run_optional dot submodule update --init --recursive
}

prepare_local_config_files() {
  log "prepare local config files"
  mkdir -p \
    "${HOME}/.cache/helix" \
    "${HOME}/.cargo" \
    "${HOME}/.config/nushell" \
    "${HOME}/.config/nushell/functions"

  touch "${HOME}/.config/nushell/local.nu"

  if [ ! -f "${HOME}/.cargo/env.nu" ]; then
    cat > "${HOME}/.cargo/env.nu" <<'EOF'
$env.PATH = ($env.PATH | prepend $"($nu.home-dir)/.cargo/bin")
EOF
  fi
}

install_rust_toolchain() {
  log "install Rust toolchain"
  if ! has rustup; then
    if has rustup-init; then
      rustup-init -y --no-modify-path
    else
      curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
    fi
  fi

  export PATH="${HOME}/.cargo/bin:${PATH}"
  run_optional rustup toolchain install stable --profile default
  run_optional rustup default stable
  run_optional rustup component add clippy rustfmt rust-src rust-analyzer
}

install_cargo_tool_if_missing() {
  local command_name="$1"
  shift

  has "${command_name}" && return 0
  if ! has cargo; then
    warn "cargo unavailable; skipping ${command_name}"
    return 0
  fi

  run_optional cargo install "$@"
}

install_go_tool_if_missing() {
  local command_name="$1"
  local package="$2"

  has "${command_name}" && return 0
  if ! has go; then
    warn "go unavailable; skipping ${command_name}"
    return 0
  fi

  mkdir -p "${HOME}/go/bin"
  run_optional env GOBIN="${HOME}/go/bin" go install "${package}"
}

install_uv_tool_if_missing() {
  local command_name="$1"
  local package="$2"

  if ! has uv; then
    warn "uv unavailable; skipping ${package}"
    return 0
  fi

  if has "${command_name}"; then
    run_optional uv tool upgrade "${package}"
  else
    run_optional uv tool install "${package}"
  fi
}

install_dotnet_tool_if_missing() {
  local command_name="$1"
  local package="$2"

  if ! has dotnet; then
    warn "dotnet unavailable; skipping ${package}"
    return 0
  fi

  if has "${command_name}"; then
    run_optional dotnet tool update --global "${package}"
  else
    run_optional dotnet tool install --global "${package}"
  fi
}

install_npm_language_servers() {
  if ! has npm; then
    warn "npm unavailable; skipping npm language servers"
    return 0
  fi

  if has bash-language-server && has yaml-language-server && has vscode-json-language-server; then
    return 0
  fi

  log "install npm language servers"
  run_optional npm install -g bash-language-server yaml-language-server vscode-langservers-extracted
}

install_fnm_node() {
  has fnm || return 0

  log "install fnm LTS Node"
  # shellcheck disable=SC1090
  eval "$(fnm env --shell bash)"
  run_optional fnm install --lts
  run_optional fnm default lts-latest
}

install_language_tools() {
  install_rust_toolchain

  log "install language-native tools"
  install_cargo_tool_if_missing harper-ls harper-ls --locked
  if ! has mdterm && has cargo; then
    if ! cargo install mdterm --locked; then
      run_optional cargo install --git https://github.com/bahdotsh/mdterm --locked
    fi
  fi
  install_cargo_tool_if_missing taplo taplo-cli --locked

  install_go_tool_if_missing gopls golang.org/x/tools/gopls@latest
  install_go_tool_if_missing dlv github.com/go-delve/delve/cmd/dlv@latest
  install_go_tool_if_missing gofumpt mvdan.cc/gofumpt@latest

  install_uv_tool_if_missing ty ty
  install_uv_tool_if_missing gdformat gdtoolkit

  install_dotnet_tool_if_missing csharp-ls csharp-ls
  install_npm_language_servers
  install_fnm_node
}

setup_bat_cache() {
  if has bat; then
    run_optional bat cache --build
  elif has batcat; then
    run_optional batcat cache --build
  fi
}

setup_ghostty_terminfo() {
  has infocmp || return 0
  has tic || return 0

  if infocmp -x xterm-ghostty >/dev/null 2>&1; then
    return 0
  fi

  log "install xterm-ghostty terminfo if available"
  if [ -d /Applications/Ghostty.app/Contents/Resources/terminfo ]; then
    run_optional sh -c 'TERMINFO=/Applications/Ghostty.app/Contents/Resources/terminfo infocmp -x xterm-ghostty | tic -x -'
  elif [ -d /usr/share/ghostty/terminfo ]; then
    run_optional sh -c 'TERMINFO=/usr/share/ghostty/terminfo infocmp -x xterm-ghostty | tic -x -'
  else
    warn "xterm-ghostty terminfo not found; install Ghostty or ghostty-terminfo if your package manager provides it"
  fi
}

setup_login_shell() {
  [ "${SET_LOGIN_SHELL}" = "1" ] || return 0
  has nu || return 0

  local nu_path
  nu_path="$(command -v nu)"

  log "set Nushell as login shell"
  if ! grep -qxF "${nu_path}" /etc/shells 2>/dev/null; then
    printf '%s\n' "${nu_path}" | as_root tee -a /etc/shells >/dev/null
  fi
  run_optional chsh -s "${nu_path}" "${USER:-$(id -un)}"
}

finalize_common_setup() {
  prepare_local_config_files
  install_language_tools
  setup_bat_cache
  setup_ghostty_terminfo
  setup_login_shell
}

pacman_install_one() {
  as_root pacman -S --noconfirm --needed --disable-download-timeout "$1"
}

install_arch_packages() {
  log "install Arch packages"
  run_optional as_root pacman -Sy --noconfirm --disable-download-timeout archlinux-keyring
  run_optional as_root pacman -Syu --noconfirm --needed --disable-download-timeout

  local packages=(
    7zip
    aerc
    base-devel
    bash
    bash-completion
    bash-language-server
    bat
    bind
    ca-certificates
    chafa
    curl
    dotnet-sdk
    eza
    fd
    ffmpeg
    file
    fnm
    fzf
    ghostty-terminfo
    git
    git-delta
    git-lfs
    github-cli
    gitui
    go
    harper
    helix
    helm
    imagemagick
    inetutils
    jq
    jujutsu
    k9s
    kubectl
    lazygit
    less
    lldb
    lua
    man-db
    markdown-oxide
    marksman
    ncurses
    neovim
    nodejs
    npm
    nushell
    openssh
    openssl
    pacman-contrib
    pkgconf
    poppler
    procps-ng
    python
    python-pip
    resvg
    ripgrep
    ruff
    rust-analyzer
    rustup
    shellcheck
    shfmt
    socat
    starship
    sudo
    taplo-cli
    tree
    unzip
    uv
    vscode-json-languageserver
    wget
    which
    wl-clipboard
    xclip
    xsel
    yaml-language-server
    yazi
    zellij
    zoxide
  )

  install_each pacman_install_one "${packages[@]}"
}

apt_install_one() {
  as_root apt-get install -y "$1"
}

install_apt_packages() {
  log "install apt packages"
  run_optional as_root apt-get update

  local packages=(
    bash
    bash-completion
    bat
    build-essential
    ca-certificates
    chafa
    curl
    dnsutils
    fd-find
    ffmpeg
    file
    fzf
    git
    git-lfs
    golang-go
    jq
    less
    lldb
    lua5.4
    nodejs
    npm
    openssh-client
    pkg-config
    poppler-utils
    procps
    python3
    python3-pip
    ripgrep
    shellcheck
    shfmt
    socat
    sudo
    tree
    unzip
    wget
    wl-clipboard
    xclip
    xsel
    zoxide
  )

  install_each apt_install_one "${packages[@]}"
}

dnf_install_one() {
  as_root dnf install -y "$1"
}

install_dnf_packages() {
  log "install dnf packages"
  run_optional as_root dnf groupinstall -y "Development Tools"

  local packages=(
    bash
    bash-completion
    bat
    ca-certificates
    chafa
    curl
    nushell
    fd-find
    ffmpeg
    file
    fzf
    git
    git-lfs
    golang
    jq
    less
    lldb
    lua
    nodejs
    npm
    openssh-clients
    pkgconf-pkg-config
    poppler-utils
    procps-ng
    python3
    python3-pip
    ripgrep
    ShellCheck
    shfmt
    socat
    sudo
    tree
    unzip
    wget
    wl-clipboard
    xclip
    xsel
    zoxide
  )

  install_each dnf_install_one "${packages[@]}"
}

install_linux_packages() {
  if has pacman; then
    install_arch_packages
  elif has apt-get; then
    install_apt_packages
    warn "apt support installs base dependencies only; install editor/terminal apps not packaged by apt manually or with your preferred package source"
  elif has dnf; then
    install_dnf_packages
    warn "dnf support installs base dependencies only; install editor/terminal apps not packaged by dnf manually or with your preferred package source"
  else
    warn "unsupported Linux package manager; skipping system package installation"
  fi
}

setup_homebrew_env() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

ensure_homebrew() {
  setup_homebrew_env
  if has brew; then
    return 0
  fi

  log "install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  setup_homebrew_env
  has brew || die "Homebrew install did not make brew available"
}

brew_install_one() {
  brew install "$1"
}

brew_cask_install_one() {
  brew install --cask "$1"
}

install_macos_packages() {
  ensure_homebrew

  log "install Homebrew formulae"
  run_optional brew update

  local packages=(
    aerc
    bash
    bash-language-server
    bat
    chafa
    coreutils
    curl
    dotnet-sdk
    eza
    fd
    ffmpeg
    fnm
    fzf
    gh
    git
    git-delta
    git-lfs
    gitui
    go
    harper
    helix
    helm
    imagemagick
    jq
    jj
    k9s
    kubectl
    lazygit
    llvm
    lua
    markdown-oxide
    marksman
    ncurses
    neovim
    node
    nushell
    openssl
    pkgconf
    poppler
    resvg
    ripgrep
    ruff
    rust-analyzer
    rustup-init
    shellcheck
    shfmt
    socat
    starship
    taplo
    tree
    unzip
    uv
    wget
    yaml-language-server
    yazi
    zellij
    zoxide
  )

  install_each brew_install_one "${packages[@]}"

  if [ "${BOOTSTRAP_INSTALL_MACOS_CASKS:-0}" = "1" ]; then
    local casks=(
      ghostty
      1password
    )
    install_each brew_cask_install_one "${casks[@]}"
  fi
}

print_next_steps() {
  cat <<EOF

Bootstrap complete.

Useful follow-ups:
  dot status
  hx --health rust
  hx --health go
  hx --health python
  hx --health markdown

Optional login shell change:
  SET_LOGIN_SHELL=1 ${BOOTSTRAP_ENTRYPOINT:-bootstrap/linux.sh}

EOF
}
