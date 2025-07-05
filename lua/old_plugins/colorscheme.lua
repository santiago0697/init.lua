return { 
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      custom_highlights = function(colors)
        return {
            -- CursorLineNr = { fg = colors.blue },
            LineNr = { fg = colors.yellow },
        }
      end
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
