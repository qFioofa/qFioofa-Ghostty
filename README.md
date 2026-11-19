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

- **Font** — JetBrainsMono Nerd Font @ 14, ligatures off (`-calt`, `-liga`, `-dlig`)
- **Theme** — `yugen-ash` (bundled in `src/themes/`)
- **Cursor** — steady block with a custom animation shader (`src/shaders/cursor.glsl`)
- **Prefix** — `Ctrl+a` is a tmux-style prefix; inactive splits are dimmed.

  | Keybind | Action |
  | --- | --- |
  | `Ctrl+a` then `h` / `l` | Focus split left / right |
  | `Ctrl+a` then `k` / `j` | Focus split up / down |
  | `Ctrl+a` then `\|` / `-` | New split right / down |
  | `Ctrl+a` then arrows | Resize split |
  | `Ctrl+a` then `z` | Toggle split zoom |
  | `Ctrl+a` then `c` / `x` | New tab / close surface |
  | `Ctrl+a` then `n` / `p` | Next / previous tab |
  | `Ctrl+a` then `1`…`9` | Go to tab |
  | `Ctrl+a` then `s` | Search |
  | `Ctrl+a` then `r` | Reload config |
  | `Ctrl+a` then `Ctrl+a` | Send literal `Ctrl+A` |

  The Russian layout mirrors focus navigation with `р` / `д` / `л` / `о`.

- **Quality of life** — copy-on-select, clear selection on copy, hide mouse while
  typing, paste protection, shell integration (cursor / sudo / title), clickable
  URLs, 95% background opacity, +2px cell height, and saved window state

- **Cursor shader** — takes its colors from the active theme instead of hardcoded
  values

# Extra

Reload Ghostty config live in the terminal

```bash
Ctrl+Shift+,
```

The default `Ctrl+,` open-config binding is disabled.

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
