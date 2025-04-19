vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
local function create_floating_window(opts)
  local ui = vim.api.nvim_list_uis()[1]
  local width = opts and opts.width or math.floor(ui.width * 0.8)
  local height = opts and opts.height or math.floor(ui.height * 0.8)

  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
  else
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>ftt", toggle_terminal)
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { nowait = true, silent = true })
