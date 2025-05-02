return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },

  opts = {
    servers = {
      ts_ls = {},
      html = {},
      cssls = {},
      vtsls = {},
      tailwindcss = {},
      emmet_ls = {},
      eslint = {},
      jsonls = {},
      yamlls = {},
      prismals = {},
      graphql = {},
      dockerls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
      pyright = {}, -- Python
      clangd = {}, -- C, C++
      jdtls = {}, -- Java
      marksman = {},
    },
  },

  config = function(_, opts)
    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(opts.servers),
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local blink_cmp = require("blink.cmp")

    mason_lspconfig.setup_handlers({
      function(server_name)
        local server_opts = opts.servers[server_name] or {}
        server_opts.capabilities = blink_cmp.get_lsp_capabilities(server_opts.capabilities)
        lspconfig[server_name].setup(server_opts)
      end,
    })
  end,
}
