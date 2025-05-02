-- Keymap to open Oil file explorer with '-'
vim.api.nvim_set_keymap("n", "-", ":Oil --float<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<space>xx", ":RunCode<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-r>", ":redo<CR>", { noremap = true })

vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "opens diagnostics" })
