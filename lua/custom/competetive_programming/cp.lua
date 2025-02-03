vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "TermEnter", "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "silent! checktime",
})

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "TermEnter", "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "silent! checktime",
})

local function setup_problem()
	-- Prompt the user for the problem number/name
	local problem_name = vim.fn.input("Enter problem number: ")
	local folder_path = vim.fn.getcwd() .. "/" .. problem_name

	-- Create folder if it doesn't exist
	if vim.fn.isdirectory(folder_path) == 0 then
		vim.fn.mkdir(folder_path)
	end

	-- Define file paths with full paths
	local mainfile = folder_path .. "/main.cpp"
	local infile = folder_path .. "/test.in"
	local outfile = folder_path .. "/test.out"

	-- Create main.cpp if it doesn't exist
	local file = io.open(mainfile, "r")
	if file then
		file:close()
	else
		file = io.open(mainfile, "w")
		if file then
			file:close()
		else
			print("Error creating main file!")
			return
		end
	end

	-- Create test.in if it doesn't exist
	file = io.open(infile, "r")
	if not file then
		file = io.open(infile, "w")
		if file then
			file:close()
		end
	else
		file:close()
	end

	-- Create test.out if it doesn't exist
	file = io.open(outfile, "r")
	if not file then
		file = io.open(outfile, "w")
		if file then
			file:close()
		end
	else
		file:close()
	end

	-- Change to the problem directory
	vim.cmd("cd " .. folder_path)

	-- Open main.cpp in the current window
	vim.cmd("edit " .. mainfile)

	-- Open a new tab
	vim.cmd("tabnew")

	-- Split the window layout
	vim.cmd("vsplit") -- Open a vertical split for terminal on the left
	vim.cmd("wincmd h") -- Focus the left window
	vim.cmd("terminal") -- Start terminal in the left split

	-- Get the terminal's channel ID
	local term_chan = vim.b.terminal_job_id

	-- Send compile and run commands
	if term_chan then
		-- Use relative paths since we're already in the correct directory
		vim.fn.chansend(term_chan, "g++ -o solution main.cpp && solution < test.in > test.out\n")
	else
		print("Terminal not found!")
	end

	vim.cmd("wincmd l") -- Focus the right window
	vim.cmd("edit " .. infile) -- Open test.in in the right window
	vim.cmd("split") -- Split horizontally for the output file
	vim.cmd("edit " .. outfile) -- Open test.out
end

vim.keymap.set(
	"n",
	"<leader>cp",
	setup_problem,
	{ desc = "Set up problem with terminal command", noremap = true, silent = true }
)

vim.keymap.set(
	"n",
	"<leader>cp",
	setup_problem,
	{ desc = "Set up problem with terminal command", noremap = true, silent = true }
)
