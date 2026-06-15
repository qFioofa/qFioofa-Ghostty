# qFioofa-Ghostty

Personal Ghostty terminal config.

# Why Ghostty

- Fast terminal immulater written in `zig`
- Build in fonts
- Custom shader support
    - Cursor animation

# Install

```bash
git clone git@github.com:qFioofa/qFioofa-Ghostty.git
cd ./qFioofa-Ghostty
bash scripts/deploy.sh -b
```

The deploy script copies `./src` into `~/.config/ghostty`. Flags:

| Flag | Description |
| --- | --- |
| `-b`, `--backup` | Back up an existing config to `~/.config/ghostty.backup` first |
| `-r`, `--remove` | Delete the existing config before installing |
| `-h`, `--help` | Show usage |

If a config already exists, you must pass `-b` or `-r` (the script refuses to overwrite silently).

# Clean

Delete config

```bash
rm -rf ~/.config/ghostty/
```

# What's configured

- **Font** — JetBrainsMono Nerd Font @ 14, ligatures off (`-dlig`)
- **Theme** — `yugen-ash` (bundled in `src/themes/`)
- **Cursor** — steady block with a custom animation shader (`src/shaders/cursor.glsl`)
- **Splits** — inactive splits dimmed; navigate with the `Ctrl+a` prefix:

  | Keybind | Action |
  | --- | --- |
  | `Ctrl+a` then `h` | Focus split left |
  | `Ctrl+a` then `l` | Focus split right |
  | `Ctrl+a` then `k` | Focus split up |
  | `Ctrl+a` then `j` | Focus split down |

- **Quality of life** — copy-on-select, hide mouse while typing, paste protection,
  shell integration (cursor / sudo / title), clickable URLs, and saved window state

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
