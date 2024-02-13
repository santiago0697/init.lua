return {
	'nvim-lualine/lualine.nvim',
	lazy = false,
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		options = {
			globalstatus = true,
			theme = 'nightfly'
			-- theme = 'palenight'
		},
		sections = {
			lualine_c = {
				{
					'filename',
					file_status = true,
					path = 1
				}
			},
		}
	}
}
