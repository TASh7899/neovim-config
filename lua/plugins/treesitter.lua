-- treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "cpp",
          "css",
          "javascript",
          "java",
          "python",
          "typescript",
          "tsx",
          "html",
          "json",
        },

        auto_install = true,

        highlight = {
          enable = true,

          disable = function(lang, buf)
            local max_filesize = 50 * 1024
            if lang == "typescript" or lang == "javascript" then
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>", -- set to `false` to disable one of the mappings
            node_incremental = "<Enter>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },
      })
    end,
  },
}
