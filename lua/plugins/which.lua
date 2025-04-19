return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    timeout = true, -- ensure which-key timeout is active
    timeoutlen = 300, -- reduce delay after <leader>
    preset = "helix",
    plugins = {
      marks = false,
      operators = false,
      windows = false,
      nav = false,
    },
    win = {
      padding = { 0, 1 },
      title = false,
      border = "none",
    },
    icons = {
      breadcrumb = ">>=",
      separator = ":: ",
      group = " ++ ",
      keys = {},
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
