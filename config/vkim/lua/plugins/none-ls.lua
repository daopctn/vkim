return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local is_windows = vim.g.vkim_is_windows

      local function exe(name) return vim.fn.executable(name) == 1 end

      -- Sources are guarded with exe() for graceful degradation before Mason installs them
      local sources = {}

      if exe("clang-format") then
        table.insert(sources, null_ls.builtins.formatting.clang_format.with({
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
          extra_args = { "--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100}" },
        }))
      end
      if exe("cppcheck") then
        table.insert(sources, null_ls.builtins.diagnostics.cppcheck.with({
          extra_args = { "--enable=warning,style,performance,portability", "--language=c++" },
        }))
      end
      if exe("cpplint") then
        table.insert(sources, require("none-ls.diagnostics.cpplint"))
      end
      if exe("black") then
        table.insert(sources, null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "100" } }))
      end
      if exe("isort") then
        table.insert(sources, null_ls.builtins.formatting.isort)
      end
      if exe("flake8") then
        table.insert(sources, require("none-ls.diagnostics.flake8").with({ extra_args = { "--max-line-length", "100" } }))
      end

      -- CMake tools: skip on Windows (cmake-format/cmake-lint not reliably available)
      if not is_windows then
        if exe("cmake-format") then
          table.insert(sources, null_ls.builtins.formatting.cmake_format)
        end
        if exe("cmake-lint") then
          table.insert(sources, null_ls.builtins.diagnostics.cmake_lint)
        end
        -- xmllint: Linux/macOS only (ROS launch files)
        if exe("xmllint") then
          table.insert(sources, null_ls.builtins.formatting.xmllint)
        end
      end

      null_ls.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
              end,
            })
          end
        end,
      })

      vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, { desc = "Format file" })
      vim.keymap.set('v', '<leader>gf', function()
        vim.lsp.buf.format({ range = {} })
      end, { desc = "Format selection" })
    end,
  },
}
