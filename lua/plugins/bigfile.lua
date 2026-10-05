return {
	"LunarVim/bigfile.nvim",
	lazy = false, -- Critical: Must load instantly
	priority = 1000, -- Force it to load before other plugins
	config = function()
		require("bigfile").setup({
			filesize = 0.5, -- Lowered to 0.5 MiB (~500 KB) to catch 18k-line files
			pattern = { "*" },
			features = {
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			},
		})
	end,
}
