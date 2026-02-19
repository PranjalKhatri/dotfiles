return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		-- UI lifecycle
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>du", function()
			require("dapui").close()
		end, { desc = "DAP: Close all UI windows" })
		-- Keymaps (with documentation)
		vim.keymap.set("n", "<leader>dc", dap.continue, {
			desc = "DAP: Continue / Start debugging",
		})

		vim.keymap.set("n", "<leader>dn", dap.step_over, {
			desc = "DAP: Step over (next line)",
		})

		vim.keymap.set("n", "<leader>di", dap.step_into, {
			desc = "DAP: Step into function",
		})

		vim.keymap.set("n", "<leader>df", dap.step_out, {
			desc = "DAP: Step out (finish function)",
		})

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {
			desc = "DAP: Toggle breakpoint",
		})

		vim.keymap.set("n", "<leader>db", dap.set_breakpoint, {
			desc = "DAP: Set breakpoint",
		})

		vim.keymap.set("n", "<leader>dlp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, {
			desc = "DAP: Set log point",
		})

		vim.keymap.set("n", "<leader>dr", dap.repl.open, {
			desc = "DAP: Open REPL",
		})

		vim.keymap.set("n", "<leader>dl", dap.run_last, {
			desc = "DAP: Run last configuration",
		})

		-- GDB adapter (native)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = {
				"--interpreter=dap",
				"--eval-command",
				"set print pretty on",
			},
		}

		-- C / C++ / Rust
		dap.configurations.cpp = {
			{
				name = "Debug (gdb)",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
	end,
}
