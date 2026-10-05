return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		-- Lazy-load on key triggers
		keys = {
			{ [[<C-\>]], desc = "Toggle Terminal" },
			{ "<leader>tf", desc = "Terminal (Float)" },
			{ "<leader>th", desc = "Terminal (Horizontal)" },
			{ "<leader>tv", desc = "Terminal (Vertical)" },
			{ "<leader>ta", desc = "Toggle All Terminals" },
			{ "<leader>ts", mode = { "n", "v" }, desc = "Send to Terminal" },
		},
		opts = function()
			-- Automatically point directly to pwsh.exe / powershell.exe on Windows to avoid spawn argument errors
			local shell
			if vim.fn.has("win32") == 1 then
				vim.opt.shell = "pwsh.exe"
				vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
				vim.opt.shellquote = ""
				vim.opt.shellxquote = ""
				vim.opt.shellpipe = "| Out-File -Encoding UTF8"
				vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8"
			else
				shell = vim.o.shell
			end

			return {
				-- --- CORE SETTINGS ---
				open_mapping = [[<C-\>]],
				shell = shell,
				direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'

				-- Dynamic sizing based on the direction of the terminal
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,

				-- --- FLOAT SETTINGS ---
				float_opts = {
					border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
					winblend = 3, -- Transparency (0 is fully opaque)
					-- width = 80,
					-- height = 20,
				},

				-- --- DEFAULT FEATURES (Commented out) ---
				-- hide_numbers = true, -- Hide the number column in toggleterm buffers
				-- shade_filetypes = {}, -- Filetypes to shade
				-- shade_terminals = true, -- Dim terminal background
				-- shading_factor = 1, -- Percentage to lighten/darken terminal background (1 to 3)
				-- start_in_insert = true, -- Start terminal in insert mode
				-- insert_mappings = true, -- Apply open_mapping in insert mode
				-- terminal_mappings = true, -- Apply open_mapping in terminal mode
				-- persist_size = true, -- Remember previous terminal size
				-- persist_mode = true, -- Remember previous terminal mode (insert/normal)
				-- close_on_exit = true, -- Close window automatically when process exits
				-- auto_scroll = true, -- Automatically scroll to the bottom on terminal output

				-- --- WINBAR ---
				-- winbar = {
				--   enabled = false,
				--   name_formatter = function(term)
				--     return term.name
				--   end
				-- },
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)

			-- --- GLOBAL / NORMAL MODE SHORTCUTS ---
			local map = vim.keymap.set
			map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal (Float)" })
			map(
				"n",
				"<leader>th",
				"<cmd>ToggleTerm size=15 direction=horizontal<CR>",
				{ desc = "Terminal (Horizontal)" }
			)
			map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Terminal (Vertical)" })
			map("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle All Terminals" })
			map("n", "<leader>ts", "<cmd>ToggleTermSendCurrentLine 1<CR>", { desc = "Send Line to Terminal 1" })
			map(
				"v",
				"<leader>ts",
				"<cmd>ToggleTermSendVisualSelection 1<CR>",
				{ desc = "Send Selection to Terminal 1" }
			)

			-- --- TERMINAL BUFFER KEYMAPS ---
			function _G.set_terminal_keymaps()
				local opts_map = { buffer = 0 }

				-- Drop into normal mode inside the terminal
				map("t", "<esc>", [[<C-\><C-n>]], opts_map)
				-- map("t", "jk", [[<C-\><C-n>]], opts_map)

				-- Standard Vim window navigation (<C-w> followed by h/j/k/l/w)
				map("t", "<C-w>h", [[<Cmd>wincmd h<CR>]], opts_map)
				map("t", "<C-w>j", [[<Cmd>wincmd j<CR>]], opts_map)
				map("t", "<C-w>k", [[<Cmd>wincmd k<CR>]], opts_map)
				map("t", "<C-w>l", [[<Cmd>wincmd l<CR>]], opts_map)
				map("t", "<C-w>w", [[<Cmd>wincmd w<CR>]], opts_map)
				map("t", "<C-w>c", [[<Cmd>wincmd c<CR>]], opts_map)
			end

			-- Attach navigation maps only to toggleterm buffers
			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
		end,
	},
}
