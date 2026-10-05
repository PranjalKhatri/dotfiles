return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Sleek minimalist ASCII header
		-- dashboard.section.header.val = {
		-- 	[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
		-- 	[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
		-- 	[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
		-- 	[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
		-- 	[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
		-- 	[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚══╝╚═╝     ╚═╝ ]],
		-- }
		-- dashboard.section.header.val = {
		-- 	"───────────────────────────────────────────",
		-- 	"	 	  ██████╗  ██████╗ ██████╗ ",
		-- 	"	 	  ██╔══██╗██╔═══██╗██╔══██╗",
		-- 	"	 	  ██████╔╝██║   ██║██████╔╝",
		-- 	"	 	  ██╔═══╝ ██║   ██║██╔═══╝ ",
		-- 	"	 	  ██║     ╚██████╔╝██║     ",
		-- 	"	 	  ╚═╝      ╚═════╝ ╚═╝     ",
		-- 	"	     > int main() { return 0; }",
		-- 	"───────────────────────────────────────────",
		-- }

		dashboard.section.header.opts = dashboard.section.header.opts or {}
		dashboard.section.header.opts.hl = "Function"

		-- NEO [Market Wicks] POP [Market Wicks] VIM + C++ Logo
		dashboard.section.header.val = {
			"─────────────────────────────────────────────────────────────────────────────────────────────────────────────",
			" ███╗   ██╗███████╗ ██████╗      ╎█╎    ╎    ██████╗  ██████╗ ██████╗       ╎    ╎█╎   ██╗   ██╗██╗███╗   ███╗",
			" ████╗  ██║██╔════╝██╔═══██╗     │█│   ╎█╎   ██╔══██╗██╔═══██╗██╔══██╗     ╎█╎   │█│   ██║   ██║██║████╗ ████║",
			" ██╔██╗ ██║█████╗  ██║   ██║     │█│   │█│   ██████╔╝██║   ██║██████╔╝     │█│   │█│   ██║   ██║██║██╔████╔██║",
			" ██║╚██╗██║██╔══╝  ██║   ██║      ╵    │█│   ██╔═══╝ ██║   ██║██╔═══╝      │█│    ╵    ╚██╗ ██╔╝██║██║╚██╔╝██║",
			" ██║ ╚████║███████╗╚██████╔╝           ╎█╎   ██║     ╚██████╔╝██║          ╎█╎          ╚████╔╝ ██║██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝             ╵    ╚═╝      ╚═════╝ ╚═╝           ╵            ╚═══╝  ╚═╝╚═╝     ╚═╝",
			"",
			"                                          ██████╗    ██╗  ██╗",
			"                                         ██╔════╝  ██████████╗",
			"                                         ██║       ╚═██╔══██╔╝",
			"                                         ╚██████╗    ██║  ██║",
			"                                          ╚═════╝    ╚═╝  ╚═╝",
			"─────────────────────────────────────────────────────────────────────────────────────────────────────────────",
		}
		-- Clean, icon-driven quick action buttons
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰱼  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "󰦛  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "󰊱  Find Word", ":Telescope live_grep<CR>"),
			dashboard.button("n", "󰝒  New File", ":ene <BAR> startinsert<CR>"),
			dashboard.button("s", "󱔗  Restore Session", ":SessionLoad<CR>"),
			dashboard.button("c", "󰒓  Configuration", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "󰗼  Quit Neovim", ":qa<CR>"),
		}

		-- Dynamic footer showing lazy.nvim plugin stats if available
		local footer_text = "Neovim"
		local status_ok, lazy_stats = pcall(require, "lazy")
		lazy_stats = lazy_stats.stats()
		if status_ok and lazy_stats then
			footer_text =
				string.format("  Loaded %d plugins in %dms", lazy_stats.count, math.floor(lazy_stats.startuptime))
		end
		dashboard.section.footer.val = footer_text

		-- Safely assign highlight options without indexing a boolean
		dashboard.section.header.opts = dashboard.section.header.opts or {}
		dashboard.section.header.opts.hl = "Constant"

		dashboard.section.buttons.opts = dashboard.section.buttons.opts or {}
		dashboard.section.buttons.opts.hl = "Function"

		dashboard.section.footer.opts = dashboard.section.footer.opts or {}
		dashboard.section.footer.opts.hl = "Comment"

		local mru_section = {
			type = "group",

			val = function()
				local buttons = {}

				for i, file in ipairs(vim.v.oldfiles) do
					if i > 4 then
						break
					end

					local filename = vim.fn.fnamemodify(file, ":t")
					local icon, icon_hl = require("nvim-web-devicons").get_icon(filename, nil, {
						default = true,
					})

					icon = icon or "󰈙"

					table.insert(buttons, {
						type = "button",
						val = string.format("%d  %s  %s", i - 1, icon, filename),
						on_press = function()
							vim.cmd("edit " .. vim.fn.fnameescape(file))
						end,
						opts = {
							position = "center",
							hl = icon_hl or "Normal",
							shortcut = "",
							width = 40,
							cursor = 1,
							align_shortcut = "right",
						},
					})
				end

				return buttons
			end,

			opts = {
				spacing = 1,
			},
		}
		local section_subtitle = {
			type = "text",
			val = ">_ pop::quant_dev < trading_systems >",
			opts = {
				position = "center",
				hl = "Keyword", -- Gives the subtitle a contrasting color (usually Green/Purple)
			},
		}
		-- Frame layout matching your style preferences
		dashboard.config.layout = {
			{ type = "padding", val = 1 },
			dashboard.section.header,
			{ type = "padding", val = 1 },
			section_subtitle,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			-- mru_section,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.config)
		-- Layout padding to center everything nicely
		-- dashboard.config.layout = {
		-- 	{ type = "padding", val = 2 },
		-- 	dashboard.section.header,
		-- 	{ type = "padding", val = 2 },
		-- 	dashboard.section.buttons,
		-- 	{ type = "padding", val = 1 },
		-- 	dashboard.section.footer,
		-- }
		--
		-- alpha.setup(dashboard.config)
	end,
}
