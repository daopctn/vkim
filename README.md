# vkim

A portable Neovim distribution for C/C++/Python/Rust/TypeScript/Bash developers. Opinionated config, terminal configs, and LSP support out of the box. All data lives next to the launcher — nothing written to system config dirs.

**[Full Usage Guide →](docs/usage-guide.md)** — all keybindings, plugin usage, LSP, completion, git.

## Quick Start

### Linux (x86_64)

```bash
chmod +x Vkim-x86_64.AppImage
./Vkim-x86_64.AppImage
```

### macOS (arm64 / x86_64)

```bash
tar -xzf vkim-macos-arm64.tar.gz   # or vkim-macos-x86_64.tar.gz
cd vkim-macos-arm64
./vkim.sh
```

> **First run:** macOS may block the binary. Go to **System Settings → Privacy & Security → Open Anyway**, or run:
> ```bash
> xattr -d com.apple.quarantine ./bin/*/bin/nvim
> ```

### Windows (x64)

1. Extract `vkim-windows-x64.zip` to a short path — e.g. `C:\vkim\`
2. Double-click `vkim.exe`

> **First run:** Windows SmartScreen may warn — click **More info → Run anyway**. The binary is unsigned.
> **Font icons:** Open the `fonts\` folder, select all `.ttf` files, right-click → **Install**.
> **Windows Terminal profile:** Run `setup-windows-terminal.ps1` once to add a vkim profile.

First launch on all platforms auto-provisions everything:
- Plugins installed via lazy.nvim
- LSP servers installed via Mason

All data lives next to the launcher — nothing written to `~/.config` or `%APPDATA%`.

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

**Plugins not loading**: Delete `./data/vkim/lazy/` next to the launcher and relaunch.

**LSP not working**: Run `:Mason` inside Neovim to install language servers manually.

**Icons missing**: Install fonts from the `fonts/` folder, then configure your terminal to use `CaskaydiaCove Nerd Font Mono`.

**Format on save not working**: Check `./config/vkim/lua/plugins/none-ls.lua`.

**macOS: "cannot be opened because it is from an unidentified developer"**
Go to **System Settings → Privacy & Security → Open Anyway**, or clear quarantine:
```bash
xattr -d com.apple.quarantine ./bin/*/bin/nvim
```

**Windows: SmartScreen blocks vkim.exe**
Click **More info → Run anyway**. The binary is unsigned open-source software.

**Windows: Mason install fails with path errors**
Extract to a short path like `C:\vkim\`. Windows has a 260-char path limit by default.
To enable long paths (requires admin):
```
reg add HKLM\SYSTEM\CurrentControlSet\Control\FileSystem /v LongPathsEnabled /t REG_DWORD /d 1
```

**Windows: PowerShell execution policy blocks setup-windows-terminal.ps1**
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## Requirements

| Platform | Requirements |
|----------|-------------|
| Linux    | x86_64, FUSE 2 (AppImage), true-color terminal |
| macOS    | 13+ (Ventura), arm64 or x86_64, true-color terminal |
| Windows  | Windows 10/11 x64, Windows Terminal recommended — extract to short path e.g. `C:\vkim\` |

All platforms: ~100MB disk space (binary + plugins). CaskaydiaCove Nerd Font included in `fonts/`.

## License

MIT (see LICENSE file)

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason Registry](https://mason-registry.dev/)
