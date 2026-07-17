# Machine Bootstrap

This directory contains idempotent setup scripts for rebuilding a machine from
scratch while keeping the existing bare-git dotfiles workflow.

It intentionally does not switch to Nix Home Manager, chezmoi, yadm, or stow.
Those are all viable, but this repo already works as a bare git repo at
`$HOME/.cfg`, and plain scripts keep the setup easy to inspect and extend.

## Fresh Install

Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/TylerSchmidtke/dotfiles/main/bootstrap/linux.sh | bash
```

macOS:

```sh
curl -fsSL https://raw.githubusercontent.com/TylerSchmidtke/dotfiles/main/bootstrap/macos.sh | bash
```

If local files would be overwritten during dotfile checkout, the script stops.
On an intentionally fresh machine, rerun with:

```sh
curl -fsSL https://raw.githubusercontent.com/TylerSchmidtke/dotfiles/main/bootstrap/linux.sh | DOTFILES_FORCE=1 bash
```

or:

```sh
curl -fsSL https://raw.githubusercontent.com/TylerSchmidtke/dotfiles/main/bootstrap/macos.sh | DOTFILES_FORCE=1 bash
```

## What It Does

The scripts install the tools implied by the current configs:

- Nushell, Starship, fnm, Rust, Go, uv, and .NET tooling.
- Helix plus LSP/debug tooling for Rust, Go, C#, GDScript, Python, Bash, TOML,
  JSON, YAML, Markdown, and prose linting with Harper.
- Terminal tools including yazi, mdterm, gitui, lazygit, bat, zellij, k9s,
  kubectl, helm, gh, ripgrep, fd, fzf, zoxide, and Ghostty terminfo support.
- Dotfiles checkout into `$HOME` from the bare repo at `$HOME/.cfg`.
- Nushell local files, submodules, bat theme cache, Rust components, Go tools,
  uv tools, .NET global tools, and an fnm-managed LTS Node runtime.

## Extending

- Add package-manager packages in `bootstrap/lib/bootstrap.sh`.
- Add language-native installers in `install_language_tools`.
- Keep secrets out of this repo. Use local ignored files like
  `~/.config/nushell/local.nu` for machine-specific values.
