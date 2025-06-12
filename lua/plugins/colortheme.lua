return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		transparent = false,
		styles = {
			sidebars = "dark",
			floats = "dark",
		},
		on_colors = function(colors)
			colors.bg = "#000000"
			colors.bg_dark = "#000000"
			colors.bg_float = "#000000"
			colors.bg_sidebar = "#000000"
			colors.bg_statusline = "#000000"
		end,
	},
	init = function()
		vim.cmd.colorscheme("tokyonight-night")
		vim.cmd.hi("Comment gui=none")
		vim.cmd.hi("Normal guibg=#000000")
		vim.cmd.hi("NormalFloat guibg=#000000")
		vim.cmd.hi("NormalNC guibg=#000000")
	end,
}
