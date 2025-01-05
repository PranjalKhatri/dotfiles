vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "TermEnter", "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "silent! checktime",
})
local function setup_problem()
	-- Prompt the user for the filename
	local filename = vim.fn.input("Enter problem number: ")
	-- Check if the file exists
	local mainfile = filename .. ".cpp"
	local infile = filename .. ".in"
	local outfile = filename .. ".out"
	local file = io.open(filename .. ".cpp", "r")
	if file then
		file:close() -- File exists, close it
	else
		-- If the file doesn't exist, create it
		file = io.open(mainfile, "w")
		if file then
			file:close()
		else
			print("Error creating file!")
			return
		end
	end
	vim.cmd("edit " .. mainfile)
	-- Open a new tab
	vim.cmd("tabnew")

	-- Split the window layout
	vim.cmd("vsplit") -- Open a vertical split for terminal on the left
	vim.cmd("wincmd h") -- Focus the right window
	vim.cmd("terminal") -- Start terminal in the left split
	-- Get the terminal's channel ID
	local term_chan = vim.b.terminal_job_id

	-- Send a command to the terminal (using the terminal's channel)
	if term_chan then
		vim.fn.chansend(
			term_chan,
			"g++ -o " .. filename .. " " .. mainfile .. " && " .. filename .. " < " .. infile .. " > " .. outfile
		)
	else
		print("Terminal not found!")
	end
	vim.cmd("wincmd l") -- Focus the right window
	vim.cmd("edit " .. infile) -- Open the created file in the right window
	vim.cmd("split") -- Split horizontally for the output file
	-- Set the right window to the output file
	-- vim.cmd("wincmd j") -- Move to the bottom-right window
	vim.cmd("edit " .. outfile) -- Open the output file
end

vim.keymap.set(
	"n",
	"<leader>cp",
	setup_problem,
	{ desc = "Set up problem with terminal command", noremap = true, silent = true }
)
