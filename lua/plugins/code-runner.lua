return {
  "CRAG666/code_runner.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("code_runner").setup({
      mode = "float", -- floating terminal
      startinsert = true, -- auto enter insert mode
      float = {
        border = "rounded",
        height = 0.5,
        width = 0.6,
        x = 0.5,
        y = 0.5,
        row = 0.3,
        col = 0.3,
      },
      filetype = {
        python = 'cd "$dir" && python3 "$fileName" && read "?Press any key to exit..." </dev/tty',
        c = 'cd "$dir" && gcc "$fileName" -o "$fileNameWithoutExt" && "./$fileNameWithoutExt" && read "?Press any key to exit..." </dev/tty',
        cpp = [[
cd "$dir" &&
g++ -g "$fileName" -o "$fileNameWithoutExt" &&
("./$fileNameWithoutExt" || (echo -e "\n[❌ Segfault or crash detected. Launching gdb...]\n" &&
gdb -q -ex "set pagination off" -ex run -ex backtrace -ex quit "./$fileNameWithoutExt")) &&
read "?Press any key to exit..." </dev/tty
        ]],
        javascript = 'cd "$dir" && node "$fileName" && read "?Press any key to exit..." </dev/tty',
        java = 'cd "$dir" && javac "$fileName" && java "$fileNameWithoutExt" && read "?Press any key to exit..." </dev/tty',
        rust = 'cd "$dir" && rustc "$fileName" && "./$fileNameWithoutExt" && read "?Press any key to exit..." </dev/tty',
        go = 'cd "$dir" && go run "$fileName" && read "?Press any key to exit..." </dev/tty',
        sh = 'cd "$dir" && bash "$fileName" && read "?Press any key to exit..." </dev/tty',
        lua = 'cd "$dir" && lua "$fileName" && read "?Press any key to exit..." </dev/tty',
        html = 'xdg-open "$file"',
      },
      project = {},
    })
  end,
}
