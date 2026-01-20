return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
	root_markers = { "go.mod", "go.work", ".git" },
	settings = {
		gopls = {
			gofumpt = true,

			-- ❌ no lint duplication
			staticcheck = false,

			analyses = {
				nilness = true,
				unreachable = true,
				unusedwrite = true,
				lostcancel = true,
				loopclosure = true,
				ifaceassert = true,
				atomicalign = true,
				printf = true,
				shadow = true,
			},

			usePlaceholders = true,
			completeUnimported = true,
			semanticTokens = true,
		},
	},
}
