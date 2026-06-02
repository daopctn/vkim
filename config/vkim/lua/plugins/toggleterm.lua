return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local shell
    if vim.g.vkim_is_windows then
      shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    end

    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "curved" },
      shade_terminals = false,
      shell = shell, -- nil on Linux/macOS → toggleterm uses $SHELL default
    })
  end,
}
