local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================================================
-- Navigation / cursor
-- =========================================================

-- Go back
map("n", "<leader>\\", "``", opts)

-- Keep o / O in normal mode (fast, no mode thrash)
map("n", "o", "mzo<Esc>`z", opts)
map("n", "O", "mzO<Esc>`z", opts)

-- =========================================================
-- Move lines / blocks (Alt + j / k)
-- =========================================================

-- Normal mode
map("n", "<M-j>", ":move .+1<CR>==", opts)
map("n", "<M-k>", ":move .-2<CR>==", opts)

-- Visual mode
map("v", "<M-j>", ":move '>+1<CR>gv=gv", opts)
map("v", "<M-k>", ":move '<-2<CR>gv=gv", opts)

-- =========================================================
-- Insert helpers
-- =========================================================

-- Exit insert mode quickly
map("i", "jj", "<Esc>", opts)

-- =========================================================
-- Search
-- =========================================================

-- Next / previous with centering
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Clear highlight
map("n", "<leader>]", ":noh<CR>", opts)

-- =========================================================
-- Yank helpers
-- =========================================================

-- Yank till end of line
map("n", "Y", "y$", opts)

-- =========================================================
-- Window navigation
-- =========================================================

map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
map("n", "<C-Up>", "<C-w>+", opts)
map("n", "<C-Down>", "<C-w>-", opts)
map("n", "<C-Left>", "<C-w>>", opts)
map("n", "<C-Right>", "<C-w><", opts)

-- =========================================================
-- Split helpers
-- =========================================================

map("n", "<leader>sh", ":split<CR>", opts)
map("n", "<leader>sv", ":vsplit<CR>", opts)

-- =========================================================
-- File explorer / tools
-- =========================================================

-- Oil file explorer
map("n", "-", ":Oil --float<CR>", opts)

-- RunCode
map("n", "<leader>xx", ":RunCode<CR>", opts)

-- Redo
map("n", "<C-r>", ":redo<CR>", { noremap = true })

-- =========================================================
-- Diagnostics
-- =========================================================

map("n", "<leader>di", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostics in split (loclist)" })
