vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
--NEOVIDE SETTINGS
if vim.g.neovide == true then
	-- vim.cmd 'set guifont=Hack\ NF:h10'
	-- vim.o.guifont='Consolas:h10'
	-- vim.o.guifont='FiraCode NF:h14'
	-- vim.o.guifont = "Operator Mono,FiraCode NF:h14"
	vim.o.guifont = "FiraCode Nerd Font Mono:h14"
	vim.g.neovide_floating_corner_radius = 0.4
	-- vim.o.guifont = "JetBrainsMono Nerd Font MONO:h15"
	vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
	vim.g.neovide_transparency = 0.96
	vim.g.neovide_title_background_color = "#212536"
	vim.g.neovide_title_text_color = "Pink"
	vim.g.neovide_cursor_vfx_mode = "railgun"
end

local min_font_size = 6
local max_font_size = 25

-- Adjust Neovide font size
local function adjust_font_size(amount)
	local guifont = vim.o.guifont
	-- Extract size from :hNN format
	local size = tonumber(guifont:match(":h(%d+)"))
	if not size then
		vim.notify("Could not detect font size in guifont", vim.log.levels.ERROR)
		return
	end

	local new_size = size + amount
	if new_size < min_font_size or new_size > max_font_size then
		return
	end

	-- Replace old size with new size
	local new_font = guifont:gsub(":h%d+", ":h" .. new_size)
	vim.o.guifont = new_font
end

-- Commands
vim.api.nvim_create_user_command("LargerFont", function()
	adjust_font_size(1)
end, {})

vim.api.nvim_create_user_command("SmallerFont", function()
	adjust_font_size(-1)
end, {})

-- Optional keymaps
vim.keymap.set("n", "<C-=>", "<cmd>LargerFont<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", "<cmd>SmallerFont<CR>", { noremap = true, silent = true })
-- set true if you have nerd font in terminal
vim.g.have_nerd_font = true
-- [[ Setting options ]]
-- :help vim.opt
-- :help vim.option-list
-- enable line numbering
vim.opt.number = true
-- enable relative line numbering
vim.opt.relativenumber = true
-- Enable mouse mode (useful for resizing windows)
vim.opt.mouse = "a"
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
-- Enable break indent
vim.opt.breakindent = true
-- show the break with the given string
-- vim.opt.showbreak = '>> '
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions live, as you type!
-- show the preview of commands like substitution
vim.opt.inccommand = "split"
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.autoindent = true -- maintain indent from previous line {default : true}
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
