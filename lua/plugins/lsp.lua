return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").clangd.setup({})
      require("lspconfig").tsserver.setup({})
      require("lspconfig").jdtls.setup({})
      require("lspconfig").cssls.setup({})
      require("lspconfig").html.setup({})
      require("lspconfig").pyright.setup({})
    end,
  },
}
