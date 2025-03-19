require("core.options")
require("core.keymaps")
require("custom.competetive_programming.cp")
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.autocompletion"),
	require("plugins.lsp"),
	require("plugins.autoformat"),
	require("plugins.gitsigns"),
	require("plugins.misc"),
	require("plugins.alpha"),
	require("plugins.render-markdown"),
	require("custom.competetive_programming.competiest"),
})
require("lsp_signature").setup()
