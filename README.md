# vkim

A portable Neovim distribution for C/C++/Python/Rust/TypeScript/Bash developers. Self-contained AppImage with opinionated config, terminal configs, and LSP support out of the box.

## Quick Start

### Launch Neovim

Link the config and run:

```bash
ln -sf /path/to/vkim/config/vkim ~/.config/vkim
NVIM_APPNAME=vkim ./Vkim-x86_64.AppImage
```

Or use XDG_CONFIG_HOME directly:

```bash
XDG_CONFIG_HOME=/path/to/vkim/config NVIM_APPNAME=vkim ./Vkim-x86_64.AppImage
```

First launch auto-installs plugins (lazy.nvim) and LSP servers (Mason).

### Setup Terminal Configs

Copy desired configs to your home:

```bash
# Ghostty terminal (recommended) — includes manga-mono theme
cp config/ghostty/config ~/.config/ghostty/config
cp -r config/ghostty/themes ~/.config/ghostty/themes
cp config/ghostty/terminal-background.jpeg ~/.config/ghostty/

# Starship prompt
cp config/starship.toml ~/.config/starship.toml

# btop resource monitor
cp config/btop/btop.conf ~/.config/btop/btop.conf

# Terminator terminal
cp config/terminator/config ~/.config/terminator/config
```

Requires **CaskaydiaCove Nerd Font** for icons in ghostty and lualine. Install via your package manager or download from [Nerd Fonts](https://www.nerdfonts.com/).

## Languages & LSP Support

Configured via Mason — installs on demand:

| Language     | LSP          | Formatter      | Linter           |
|--------------|--------------|----------------|------------------|
| C/C++        | clangd       | clang-format   | cppcheck, cpplint|
| Python       | pyright      | black, isort   | flake8           |
| Rust         | rust_analyzer| rustfmt        | clippy           |
| TypeScript   | ts_ls        | prettier       | eslint           |
| JavaScript   | ts_ls        | prettier       | eslint           |
| Lua          | lua_ls       | stylua         | —                |
| Bash         | bashls       | shfmt          | shellcheck       |
| JSON/YAML    | —            | —              | —                |

Format on save enabled. CMake and XML linting via none-ls.

## Key Mappings

| Mapping   | Action                                      |
|-----------|---------------------------------------------|
| `gd`      | Go to definition                            |
| `gD`      | Go to declaration                           |
| `K`       | Hover documentation                         |
| `gi`      | Go to implementation                        |
| `gr`      | Find references                             |
| `gl`      | Diagnostic (floating window)                |
| `[d`/`]d` | Previous/next diagnostic                    |
| `<leader>ca` | Code action                              |
| `<leader>gf` | Format file or selection                  |

## Plugin Stack

| Plugin           | Purpose                    |
|------------------|----------------------------|
| lazy.nvim        | Plugin manager             |
| telescope.nvim   | Fuzzy finder              |
| neo-tree.nvim    | File explorer             |
| nvim-cmp         | Completion engine         |
| nvim-lspconfig   | LSP configuration         |
| mason.nvim       | LSP/formatter installer   |
| none-ls.nvim     | Formatter/linter runner   |
| treesitter       | Syntax highlighting       |
| lualine.nvim     | Statusline                |
| noice.nvim       | UI message improvements   |
| toggleterm.nvim  | Integrated terminal       |
| vim-fugitive     | Git commands              |
| gitsigns.nvim    | Git signs in gutter       |
| dracula          | Colorscheme               |
| alpha.nvim       | Dashboard                 |
| smear_cursor     | Smooth cursor animation   |
| indent-blankline | Indentation guides        |

## File Structure

```
config/
├── vkim/                    # Neovim config
│   ├── init.lua            # Entry point, lazy bootstrap
│   ├── lazy-lock.json      # Plugin lock file
│   ├── after/plugin/       # Post-plugin setup
│   └── lua/plugins/        # Plugin specs (23 files)
├── ghostty/                # Ghostty terminal
├── btop/                   # btop monitor
├── terminator/             # Terminator terminal
├── clangd/                 # clangd config
└── starship.toml          # Starship prompt
```

## Customization

### Neovim Config

Edit `config/vkim/init.lua` for core options (timeout, indent, search behavior).

Each plugin has its own spec file in `lua/plugins/`. Modify or add plugins there.

### C/C++ Style

Edit `config/clangd/.clangd` or create per-project `.clangd` files. Current default: Google style, 4-space indent.

### Theme

Set colorscheme in `lua/plugins/dracula.lua` or `lua/plugins/manga-mono.lua`. Edit highlight overrides in `after/plugin/highlights.lua`.

## Troubleshooting

**Plugins not loading**: Delete `~/.local/share/nvim/lazy/` and relaunch to reinstall.

**LSP not working**: Run `:Mason` in Neovim to install language servers.

**Icons missing**: Install CaskaydiaCove Nerd Font and verify `TERM` supports true color.

**Format on save not working**: Check none-ls config in `lua/plugins/none-ls.lua`.

## Requirements

- Linux x86_64 or AppImage-capable system
- 100MB free disk space (AppImage + plugins)
- Ghostty (optional): macOS 13.5+ / Linux with Wayland or X11
- CaskaydiaCove Nerd Font (for icons)

## License

MIT (see LICENSE file)

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason Registry](https://mason-registry.dev/)
