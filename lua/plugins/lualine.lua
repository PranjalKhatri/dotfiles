return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			-- Rounded bubble/pill separators
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "starter" },
				winbar = { "dashboard", "alpha", "starter", "toggleterm" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			-- Single persistent statusline across all splits
			globalstatus = true,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},

		-- BOTTOM STATUSLINE
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
			},
			lualine_b = {
				{ "branch", icon = "" },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
			},
			lualine_x = {
				{ "filetype", icon_only = false },
			},
			lualine_y = { "progress" },
			lualine_z = {
				{ "location", separator = { left = "", right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},

		-- TOP BUFFERLINE (Replaces the ugly default Neovim tabline)
		tabline = {
			lualine_a = {
				{
					"tabs",
					mode = 2, -- Shows tab number + file name
					separator = { left = "", right = "" },
				},
			},
			-- lualine_a = {
			-- {

			-- "buffers",
			-- separator = { left = "", right = "" },
			-- show_modified_status = true,
			-- mode = 2, -- Shows buffer number + name
			-- max_length = vim.o.columns * 0.8,
			-- filetype_names = {
			-- 	TelescopePrompt = "Telescope",
			-- 	toggleterm = "Terminal",
			-- },
			-- symbols = {
			-- 	modified = " ●",
			-- 	alternate_file = "",
			-- 	directory = "",
			-- },
			-- },
			-- },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{ "tabs", separator = { left = "", right = "" } },
			},
		},

		-- PER-WINDOW WINBAR (Shows relative filepath cleanly at the top of each window)
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					path = 1, -- Relative path (e.g. lua/config/options.lua)
					symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "toggleterm", "lazy", "fzf" },
	},
}
