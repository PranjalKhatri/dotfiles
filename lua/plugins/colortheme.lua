return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	-- add dracula
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("dracula")
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = true,
	-- 	opts = {
	-- 		style = "night",
	-- 		transparent = false,
	-- 		styles = {
	-- 			sidebars = "dark",
	-- 			floats = "dark",
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		vim.cmd.hi("Comment gui=none")
	-- 		-- vim.cmd.hi("Normal guibg=#000000")
	-- 		-- vim.cmd.hi("NormalFloat guibg=#000000")
	-- 		-- vim.cmd.hi("NormalNC guibg=#000000")
	-- 	end,
	-- },
}
