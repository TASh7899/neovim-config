return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "Saghen/blink.cmp",
  },
  config = function()
    local util = require("lspconfig.util") -- ✅ Required for tailwindcss root_dir

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and (client.name == "vtsls" or client.name == "eslint") then
          client.server_capabilities.documentFormattingProvider = false
        end

        if client and client.supports_method and client.supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = false,
      virtual_text = false,
      signs = false,
    })

    local cap = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities(cap)
    capabilities.textDocument.semanticTokens = nil

    local servers = {
      html = {},
      cssls = {},
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "none" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = false },
            },
          },
        },
      },
      emmet_ls = {},
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
      pyright = {},
      clangd = {},
      jdtls = {},
      marksman = {},

      tailwindcss = {
        root_dir = util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.ts",
          "package.json",
          ".git"
        ),
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        init_options = {
          userLanguages = {
            javascript = "javascript",
            javascriptreact = "javascriptreact",
            typescript = "typescript",
            typescriptreact = "typescriptreact",
          },
        },
        settings = {
          tailwindCSS = {
            validate = true,
            includeLanguages = {
              javascript = "javascript",
              javascriptreact = "javascriptreact",
              typescript = "typescript",
              typescriptreact = "typescriptreact",
            },
          },
        },
      },
    }

    local ensure_installed = {}
    for name, config in pairs(servers) do
      if config ~= false then
        table.insert(ensure_installed, name)
      end
    end

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.flags = {
            debounce_text_changes = 300,
          }
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
