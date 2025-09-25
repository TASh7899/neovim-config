-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false, -- load early so other plugins that depend on it can require it safely
    config = function()
      -- Guard require so startup won't break if something is still not ready
      local ok, tsconfigs = pcall(require, "nvim-treesitter.configs")
      if not ok or not tsconfigs then
        vim.notify("nvim-treesitter: module not available yet", vim.log.levels.WARN)
        return
      end

      tsconfigs.setup({
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

        auto_install = false,

        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 50 * 1024 -- 50 KB
            if lang == "typescript" or lang == "javascript" then
              local ok_stat, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok_stat and stats and stats.size > max_filesize then
                return true
              end
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>",
            node_incremental = "<Enter>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },
      })
    end,
  },
}
