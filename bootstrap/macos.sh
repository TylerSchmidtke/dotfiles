#!/usr/bin/env bash
set -euo pipefail

DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"
BOOTSTRAP_ENTRYPOINT="${BOOTSTRAP_ENTRYPOINT:-bash bootstrap/macos.sh}"
BOOTSTRAP_RAW_BASE="${BOOTSTRAP_RAW_BASE:-https://raw.githubusercontent.com/TylerSchmidtke/dotfiles/${DOTFILES_BRANCH}/bootstrap}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P || pwd)"

if [ -f "${SCRIPT_DIR}/lib/bootstrap.sh" ]; then
  # shellcheck source=lib/bootstrap.sh
  source "${SCRIPT_DIR}/lib/bootstrap.sh"
else
  tmp_lib="$(mktemp "${TMPDIR:-/tmp}/dotfiles-bootstrap.XXXXXX")"
  curl -fsSL "${BOOTSTRAP_RAW_BASE}/lib/bootstrap.sh" -o "${tmp_lib}"
  # shellcheck source=/dev/null
  source "${tmp_lib}"
fi

[ "$(uname -s)" = "Darwin" ] || die "bootstrap/macos.sh must run on macOS"

if ! xcode-select -p >/dev/null 2>&1; then
  log "install Xcode command line tools"
  xcode-select --install
  warn "rerun this script after Xcode command line tools finish installing"
  exit 1
fi

install_macos_packages
checkout_dotfiles
finalize_common_setup
print_next_steps
