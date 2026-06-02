# vkim

A portable Neovim distribution for C/C++/Python/Rust/TypeScript/Bash developers. Self-contained AppImage with opinionated config, terminal configs, and LSP support out of the box.

**[Full Usage Guide →](docs/usage-guide.md)** — all keybindings, plugin usage, LSP, completion, git.

## Quick Start

```bash
chmod +x Vkim-x86_64.AppImage
./Vkim-x86_64.AppImage
```

That's it. First launch auto-provisions everything:
- Neovim config copied to `./config/vkim/`
- Fonts unzipped to `./fonts/`
- Terminal configs (ghostty, btop, terminator, clangd) copied to `./config/`
- Plugins installed via lazy.nvim
- LSP servers installed via Mason

All data lives next to the AppImage — nothing written to `~/.config`.

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

**Plugins not loading**: Delete `./data/vkim/lazy/` next to the AppImage and relaunch.

**LSP not working**: Run `:Mason` inside Neovim to install language servers manually.

**Icons missing**: Fonts auto-install to `./fonts/` on first run — verify terminal supports true color.

**Format on save not working**: Check `./config/vkim/lua/plugins/none-ls.lua`.

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
