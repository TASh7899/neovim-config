-- lua/plugins/treesitter-object.lua
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSUpdate",
    config = function()
      -- Guard require so config won't error if treesitter isn't available yet
      local ok, tsconfigs = pcall(require, "nvim-treesitter.configs")
      if not ok or not tsconfigs then
        vim.notify("nvim-treesitter-textobjects: nvim-treesitter not ready", vim.log.levels.WARN)
        return
      end

      -- Configure only textobjects here (leave ensure_installed in the main treesitter file)
      tsconfigs.setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- jump forward to next textobj automatically

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },

            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },

            include_surrounding_whitespace = true,
          },

          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },

          move = {
            enable = true,
            set_jumps = true, -- record jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}
