return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          -- include = { "hidden" }
        }
      }
    }
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer.open()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>pv",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "File Explorer",
    }
  },
  init = function ()

  end
}
