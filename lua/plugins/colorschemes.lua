return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			float = {
				transparent = true,
				solid = false,
			},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.yellow },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
