return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			-- Automatically set received problems to "main.cpp"
			received_problems_path = "$(CWD)/main.cpp",

			-- Test cases configuration
			testcases_directory = "$(CWD)",
			testcases_auto_detect_storage = true,
			testcases_use_single_file = false, -- Use separate input/output files
			testcases_input_file_format = "test.in",
			testcases_output_file_format = "expected.out",

			-- Compilation and Run commands
			compile_directory = "$(CWD)", -- Where to compile
			compile_command = {
				cpp = { exec = "g++", args = { "-Wall", "main.cpp", "-o", "main" } }, -- Main executable
			},
			run_command = {
				cpp = { exec = "./main" },
			},
		})
	end,
}
