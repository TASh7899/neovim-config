return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
  opts = function(_, opts)
    local luasnip = require("luasnip")

    opts.snippet = {
      expand = function(args)
        if not args.body or args.body:match("^%s*$") then
          vim.notify("⚠️ Skipping empty snippet from Blink", vim.log.levels.WARN)
          return
        end
        luasnip.lsp_expand(args.body)
      end,
    }

    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }

    return opts
  end,
}
