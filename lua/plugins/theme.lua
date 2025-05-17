return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 0,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 0,
    config = function()
      require("rose-pine").setup({
        disable_background = false,
      })
      -- No vim.cmd("colorscheme rose-pine") here
    end,
  },

  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 0,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 0,
    config = function()
      vim.cmd([[
      colorscheme rose-pine-moon

      " Pure black backgrounds for UI
      highlight Normal guibg=#000000
      highlight NormalNC guibg=#000000
      highlight SignColumn guibg=#000000
      highlight VertSplit guibg=#000000
      highlight StatusLine guibg=#000000
      highlight StatusLineNC guibg=#000000
      highlight TabLine guibg=#000000
      highlight TabLineFill guibg=#000000
      highlight TabLineSel guibg=#000000

      " Floating windows and menus
      highlight Pmenu guibg=#000000
      highlight PmenuSel guibg=#1a1a1a
      highlight FloatBorder guibg=#000000
      highlight NormalFloat guibg=#000000
      highlight TelescopeNormal guibg=#000000
      highlight TelescopeBorder guibg=#000000
      highlight TelescopePromptNormal guibg=#000000
      highlight TelescopePromptBorder guibg=#000000
      highlight TelescopeResultsNormal guibg=#000000
      highlight TelescopeResultsBorder guibg=#000000

      highlight CursorLine guibg=#1a0f23
      highlight CursorLineNr guifg=#f5c2e7 guibg=#1a0f23
      highlight Visual guibg=#251530 guifg=NONE

      highlight Search guibg=#3b1f38 guifg=#ffffff
      highlight IncSearch guibg=#5a2e57 guifg=#ffffff
      highlight MatchParen guibg=#2a1730 guifg=#f5c2e7

      highlight LspReferenceText guibg=#10071a guifg=NONE
      highlight LspReferenceRead guibg=#10071a guifg=NONE
      highlight LspReferenceWrite guibg=#10071a guifg=NONE

      highlight Illuminate guibg=#10071a guifg=NONE
      highlight IlluminateWord guibg=#10071a guifg=NONE
      ]])
    end,
  },
}
