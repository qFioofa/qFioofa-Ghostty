# qFioofa-Ghostty

Personal Ghostty terminal config.

# Why Ghostty

- Fast terminal immulater written in `zig`
- Build in fonts
- Custom shader support
    - Cursor animation

# Install

With `git clone`

```bash
git clone git@github.com:qFioofa/qFioofa-Ghostty.git
cd ./qFioofa-Ghostty
bash deploy_config -r
```

One command

```bash

```

# Clean

Delete config

```bash
rm -rf ~/.config/ghostty/
```

# Extra

Reload Ghostty config live in the terminal

```bash
Ctrl+Shift+,
```

# Nix

Ships a `flake.nix` exposing a Home Manager module (`homeManagerModules.default`).
It symlinks `./src` to `~/.config/ghostty` via `xdg.configFile`, so the config can
be managed declaratively instead of running `deploy_config`.

```nix
# flake inputs
qFioofa-ghostty.url = "github:qFioofa/qFioofa-Ghostty";

# home configuration
imports = [ qFioofa-ghostty.homeManagerModules.default ];
```
