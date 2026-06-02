return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
        map("n", "<leader>hB", function() gs.blame_line({ full = true }) end, "Blame line (full)")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
      end,
    })

    -- Global keymap to close diff split from any window
    vim.keymap.set("n", "<leader>hq", function()
      vim.cmd("diffoff!")
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(w)
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("^gitsigns://") then
          vim.api.nvim_win_close(w, true)
          return
        end
      end
    end, { desc = "Close diff" })

    -- Theme colors: green=add, blue=change, red=delete
    vim.api.nvim_set_hl(0, "GitSignsAdd",          { fg = "#87a882" })
    vim.api.nvim_set_hl(0, "GitSignsChange",        { fg = "#4a9eff" })
    vim.api.nvim_set_hl(0, "GitSignsDelete",        { fg = "#bf6a5e" })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete",     { fg = "#bf6a5e" })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete",  { fg = "#4a9eff" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked",     { fg = "#87a882" })
  end,
}
