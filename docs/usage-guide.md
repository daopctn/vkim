# vkim Usage Guide

**Neovim version:** v0.11.6 (LuaJIT 2.1)  
**Leader key:** `Space`  
**Local leader:** `\`

---

## Dashboard (alpha.nvim / snacks.nvim)

Shown on launch when no file is opened.

| Key | Action |
|-----|--------|
| `f` | Find file (Telescope) |
| `r` | Recent files |
| `w` | Find word (live grep) |
| `s` | Grep string under cursor |
| `l` | Open Lazy plugin manager |
| `d` | Open help docs |

---

## File Explorer — neo-tree.nvim

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree (left panel, width 30) |
| `a` | Add file/directory (inside neo-tree) |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `Enter` | Open file |
| `q` | Close neo-tree |

---

## Fuzzy Finder — telescope.nvim

| Key | Action |
|-----|--------|
| `<C-p>` | Find files |
| `<leader>fg` | Live grep (search text in all files) |
| `<leader>f/` | Fuzzy find in current buffer |

**Inside Telescope picker:**

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Move down/up |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<Esc>` | Close |

---

## LSP (nvim-lspconfig + Mason)

Supported languages: Lua, Python, C/C++, Rust, TypeScript/JS, Bash, JSON, YAML.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find all references |
| `K` | Hover documentation |
| `gl` | Show diagnostic (floating window) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>ca` | Code action |
| `<leader>gf` | Format file |
| `<leader>gf` (visual) | Format selection |

**Format on save** is enabled for all configured languages.

**Manage LSP servers:** `:Mason` — install/uninstall language servers, formatters, linters.

---

## Completion — nvim-cmp + LuaSnip

Triggers automatically in insert mode.

| Key | Action |
|-----|--------|
| `<Tab>` | Select next item / expand or jump snippet |
| `<S-Tab>` | Select previous item / jump back in snippet |
| `<CR>` | Confirm selection |
| `<C-Space>` | Force open completion menu |
| `<C-e>` | Abort / close menu |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

Sources (in order): LSP → snippets → file paths → buffer text.

---

## Git Signs — gitsigns.nvim

Signs in gutter: `▎` add/change (green/blue), `` delete (red).

| Key | Action |
|-----|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hR` | Reset entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Blame current line |
| `<leader>hB` | Blame current line (full commit message) |
| `<leader>hd` | Diff this file |
| `<leader>hq` | Close diff window |

---

## Git Commands — vim-fugitive

| Command | Action |
|---------|--------|
| `:Git` / `:G` | Open git status window |
| `:Gdiffsplit` | Diff current file against HEAD |
| `:Gread` | Revert to HEAD |
| `:Gwrite` | Stage current file |
| `:Gclog` | File commit history in quickfix |

**Inside `:Git` status window:**

| Key | Action |
|-----|--------|
| `s` | Stage file |
| `u` | Unstage file |
| `cc` | Commit |
| `dd` | Diff file |
| `q` | Close |

---

## Terminal — toggleterm.nvim

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |

Terminal opens as floating window with curved border. Press `<C-\>` again to hide, same session persists.

---

## Treesitter

Syntax highlighting and code understanding for all configured languages. No manual keybindings — works automatically on file open.

---

## UI — noice.nvim

Command line appears as centered popup. Notifications appear top-right (nvim-notify). No keybindings needed.

---

## Statusline — lualine.nvim

Sections displayed:

| Section | Content |
|---------|---------|
| Left | Mode, macro recording indicator (`recording @x`) |
| Left-center | Git branch, diff stats, diagnostics count |
| Center | Filename |
| Right | Active LSP clients, encoding, file format, filetype |
| Far right | Scroll percentage, line:col |

---

## Plugin Manager — lazy.nvim

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Install missing + update + clean |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy restore` | Restore versions from `lazy-lock.json` |

---

## Quickfix / Help / Man windows

| Key | Action |
|-----|--------|
| `q` | Close window (works in quickfix, help, man pages) |

---

## Formatters & Linters (none-ls.nvim)

| Language | Formatter | Linter |
|----------|-----------|--------|
| C/C++ | clang-format (Google style, indent 4) | cppcheck, cpplint |
| Python | black (line 100), isort | flake8 (line 100) |
| CMake | cmake_format | cmake_lint |
| XML | xmllint | — |

All installed via Mason. Format on save runs automatically on `BufWritePre`.

> **Windows note:** `xmllint`, `cmake_format`, and `cmake_lint` are skipped on Windows if the executables are not found — no crash, just silently omitted.

---

## Platform Notes

### macOS

- **Terminal:** Ghostty is recommended. Config installs to `~/.config/ghostty/config` via `install-macos.sh`.
- **Font:** Run `install-macos.sh` to copy fonts to `~/Library/Fonts/`, or drag `.ttf` files there manually.
- **Starship prompt:** Config installs to `~/.config/starship.toml`. Install starship: `curl -sS https://starship.rs/install.sh | sh`
- **Quarantine:** If macOS blocks the nvim binary, clear it: `xattr -d com.apple.quarantine ./bin/*/bin/nvim`
- **Clipboard:** Auto-detected via `pbcopy`/`pbpaste` — no config needed.

### Windows

- **Terminal:** [Windows Terminal](https://aka.ms/terminal) recommended. Run `setup-windows-terminal.ps1` once to add a vkim profile with correct font.
- **Font:** Open `fonts\` folder → select all `.ttf` → right-click → **Install** (user install, no admin).
- **Shell:** vkim auto-detects `pwsh` (PowerShell 7) first, falls back to `powershell` (PowerShell 5). Install PowerShell 7 for best experience: https://aka.ms/powershell
- **Mason prerequisites:**
  - Python tools (black, isort, flake8): requires `python` + `pip` in PATH
  - TypeScript LSP (ts_ls): requires `node` + `npm` in PATH
  - Rust analyzer: requires `rustup` / cargo in PATH
- **Path length:** Extract vkim to a short path (e.g. `C:\vkim\`). Mason installs deep plugin trees that can hit Windows' 260-char limit.
- **Clipboard:** Auto-detected — Neovim uses Windows clipboard natively, no config needed.
