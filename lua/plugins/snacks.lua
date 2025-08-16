---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
          -- include = { "hidden" }
        }
      }
    },
    words = { enabled = true },
    lazygit = { enabled = true }
  },
  keys = {
    { "<leader>e",  function() Snacks.explorer.open() end,    desc = "File Explorer", },
    { "<leader>pv", function() Snacks.explorer.reveal() end,  desc = "Reveal current file in rxplorer", },
    { "<leader>,",  function() Snacks.picker.buffers() end,   desc = "Buffers" },
    { "<leader>/",  function() Snacks.picker.grep() end,      desc = "Grep" },
    { "<leader>ff", function() Snacks.picker.files() end,     desc = "Find Files" },
    { "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>q", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>aq", function() Snacks.bufdelete.all() end, desc = "Delete Buffer" },
    { "<leader>aq", function() Snacks.bufdelete.other() end, desc = "Delete Buffer" }
  },
  init = function()

  end
}
