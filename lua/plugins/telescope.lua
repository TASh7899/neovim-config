return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
      "jvgrootveld/telescope-zoxide",
    },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-r>"] = actions.delete_buffer,
            },
            n = {
              ["<C-r>"] = actions.delete_buffer,
            },
          },
        },
        extensions = {
          fzf = {},
        },

        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--glob",
              "!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}",
              "--path-separator",
              "/",
            },
          },
        },
      })

      vim.keymap.set(
        "n",
        "<leader>jk",
        "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
        {}
      )
      -- Load extensions safely
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "zoxide")

      -- Keymaps
      vim.keymap.set("n", "<space>ff", builtin.find_files)
      vim.keymap.set("n", "<space>fc", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end)
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>z", "<cmd>Telescope zoxide list<CR>", { desc = "Zoxide directories" })
      vim.keymap.set("n", "<leader>fv", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>di", builtin.diagnostics, {})
    end,
  },
}
