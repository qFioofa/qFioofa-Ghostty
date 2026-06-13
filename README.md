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

Ships a `flake.nix` exposing a Home Manager module (`homeManagerModules.default`,
defined in `nix/hm-module.nix`). It symlinks `./src` to `~/.config/ghostty` via
`xdg.configFile`, so the config can be managed declaratively instead of running
`deploy.sh`.

```nix
# flake inputs
qfioofa-ghostty.url = "github:qFioofa/qFioofa-Ghostty";

# home configuration
imports = [ inputs.qfioofa-ghostty.homeManagerModules.default ];
programs.qfioofa-ghostty.enable = true;
```

Set `programs.qfioofa-ghostty.package = pkgs.ghostty;` to also install Ghostty
itself; leave it unset (the default) to manage only the config and get Ghostty
elsewhere. After changes, `home-manager switch` and reload Ghostty
(`Ctrl+Shift+,`).
