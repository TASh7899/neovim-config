-- ~/.config/nvim/colors/pinkyellow_vivid.lua
local c = {
  bg = "#000000",
  bg_alt = "#101010",
  fg = "#f0f0f0",
  pink = "#ffc8dd",
  yellow = "#ffe8a3",
  red = "#f29cae",
  gray = "#888888",
  cursor = "#ff4d6d",
  highlight = "#1a1a1a",
  status_text = "#000000",
  black = "#000000",
}

local function highlight(group, fg, bg, style)
  local cmd = "hi " .. group
  if fg then
    cmd = cmd .. " guifg=" .. fg
  end
  if bg then
    cmd = cmd .. " guibg=" .. bg
  end
  if style then
    cmd = cmd .. " gui=" .. style
  end
  vim.cmd(cmd)
end

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "pinkyellow_vivid"

-- Core UI
highlight("Normal", c.fg, c.bg)
highlight("Cursor", c.bg, c.cursor)
highlight("CursorLine", nil, c.bg_alt)
highlight("CursorLineNr", c.yellow, nil, "bold")
highlight("LineNr", c.gray)
highlight("Visual", nil, c.highlight)
highlight("Search", c.bg, c.yellow)
highlight("IncSearch", c.bg, c.pink)
highlight("MatchParen", c.yellow, c.bg_alt, "bold")

-- Menus and UI elements
highlight("Pmenu", c.fg, c.bg_alt)
highlight("PmenuSel", c.status_text, c.pink)
highlight("PmenuSbar", nil, c.bg_alt)
highlight("PmenuThumb", nil, "#404040")
highlight("SignColumn", nil, c.bg)
highlight("Folded", c.yellow, c.bg_alt, "italic")

-- Syntax
highlight("Comment", c.gray, nil, "italic")
highlight("Constant", c.yellow)
highlight("String", c.yellow)
highlight("Character", c.red)
highlight("Number", c.red)
highlight("Boolean", c.pink)
highlight("Identifier", c.fg)
highlight("Function", c.pink)
highlight("Statement", c.pink)
highlight("Keyword", c.pink)
highlight("Operator", c.pink)
highlight("PreProc", c.pink)
highlight("Type", c.yellow)
highlight("Special", c.red)
highlight("Underlined", c.yellow, nil, "underline")
highlight("Todo", c.yellow, nil, "bold")
highlight("Error", c.red, nil, "bold")

-- Treesitter highlights
highlight("@comment", c.gray, nil, "italic")
highlight("@keyword", c.pink)
highlight("@function", c.pink)
highlight("@string", c.yellow)
highlight("@variable", c.fg)
highlight("@type", c.yellow)
highlight("@constant", c.red)
highlight("@number", c.red)
highlight("@field", c.fg)
highlight("@property", c.fg)
highlight("@parameter", c.fg)
highlight("@operator", c.pink)

-- Diagnostics
highlight("DiagnosticError", c.red)
highlight("DiagnosticWarn", c.yellow)
highlight("DiagnosticInfo", c.pink)
highlight("DiagnosticHint", c.gray)
highlight("DiagnosticUnderlineError", nil, nil, "underline")
highlight("DiagnosticUnderlineWarn", nil, nil, "underline")

-- Git / Diff
highlight("DiffAdd", c.yellow, c.bg_alt)
highlight("DiffChange", c.pink, c.bg_alt)
highlight("DiffDelete", c.red, c.bg_alt)
highlight("GitSignsAdd", c.yellow)
highlight("GitSignsChange", c.pink)
highlight("GitSignsDelete", c.red)

pcall(function()
  require("lualine").setup({
    options = {
      theme = {
        -- NORMAL mode
        normal = {
          a = { fg = "#000000", bg = "#ff99cc", gui = "bold" },
          b = { fg = "#000000", bg = "#ff99cc" },
          c = { fg = "#000000", bg = "#ff99cc" },
        },

        -- INSERT mode
        insert = {
          a = { fg = "#000000", bg = "#ffe176", gui = "bold" },
          b = { fg = "#000000", bg = "#ffe176" },
          c = { fg = "#000000", bg = "#ffe176" },
        },

        -- VISUAL mode
        visual = {
          a = { fg = "#000000", bg = "#f08080", gui = "bold" },
          b = { fg = "#000000", bg = "#f08080" },
          c = { fg = "#000000", bg = "#f08080" },
        },

        -- REPLACE mode
        replace = {
          a = { fg = "#000000", bg = "#ffb3c1", gui = "bold" },
          b = { fg = "#000000", bg = "#ffb3c1" },
          c = { fg = "#000000", bg = "#ffb3c1" },
        },

        -- COMMAND mode
        command = {
          a = { fg = "#000000", bg = "#bbdbb4", gui = "bold" },
          b = { fg = "#000000", bg = "#bbdbb4" },
          c = { fg = "#000000", bg = "#bbdbb4" },
        },

        -- INACTIVE windows
        inactive = {
          a = { fg = "#888888", bg = "#101010" },
          b = { fg = "#888888", bg = "#101010" },
          c = { fg = "#888888", bg = "#101010" },
        },
      },
    },
  })
end)
