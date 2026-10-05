return {
	"Civitasv/cmake-tools.nvim",
	-- Lazy load when a CMakeLists.txt file is opened or when calling a CMake command
	event = "BufReadPost CMakeLists.txt",
	cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeDebug" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "mfussenegger/nvim-dap", -- Optional but highly recommended for debugging
	},
	config = function()
		require("cmake-tools").setup({
			cmake_command = "cmake",
			-- Always create the build directory in the project root
			cmake_build_directory = "build",

			-- Crucial for C/C++ development: generates compile_commands.json for clangd
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },

			cmake_soft_link_compile_commands = true, -- Symlink compile_commands.json to root

			cmake_runner = {
				name = "terminal",
				opts = {
					name = "CMake Runner",
					position = "bottom",
					size = 15,
					type = "split",
					quit_on_exit = false, -- Keeps the terminal open to read output
				},
			},
		})
	end,
	keys = {
		-- Core Workflow
		{ "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "CMake Generate" },
		{ "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "CMake Build" },
		{ "<leader>cr", "<cmd>CMakeRun<CR>", desc = "CMake Run Target" },
		{ "<leader>cd", "<cmd>CMakeDebug<CR>", desc = "CMake Debug Target" },

		-- Configuration Selection
		{ "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", desc = "CMake Select Build Target" },
		{ "<leader>cl", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "CMake Select Launch Target" },
		{ "<leader>cT", "<cmd>CMakeSelectBuildType<CR>", desc = "CMake Select Build Type (Debug/Release)" },

		-- Utilities
		{ "<leader>cx", "<cmd>CMakeClean<CR>", desc = "CMake Clean" },

		{ "<leader>cc", "<cmd>CMakeCloseRunner<CR>", desc = "CMake Close Runner" },
		{ "<leader>ce", "<cmd>CMakeCloseExecutor<CR>", desc = "CMake Close Executor" },

		-- Stops a running process
		{ "<leader>cs", "<cmd>CMakeStopRunner<CR>", desc = "CMake Stop Runner" },
	},
}
