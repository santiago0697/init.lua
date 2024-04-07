return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      outline = {
        layout = 'float',
        close_after_jump = true
      },
      ui = {
        enable = false,
        code_action = ''
      },
      symbol_in_winbar = {
        enable = false
      },
      rename = {
        in_select = false
      }
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'     -- optional
  }
}
