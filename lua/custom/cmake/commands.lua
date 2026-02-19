local function CmakeBuild(opts)
	-- default to Debug if no argument is provided
	local build_type = opts.args ~= "" and opts.args or "Debug"

	vim.system({
		"cmake",
		"-S",
		".",
		"-B",
		"build",
		"-G",
		"Ninja",
		"-DCMAKE_BUILD_TYPE=" .. build_type,
		"-DCMAKE_C_COMPILER=clang",
		"-DCMAKE_CXX_COMPILER=clang++",
	}, { text = true }, function(res)
		vim.schedule(function()
			if res.code == 0 then
				vim.notify("CMake configure successful (" .. build_type .. ")", vim.log.levels.INFO)
			else
				vim.notify(res.stderr, vim.log.levels.ERROR)
			end
		end)
	end)
end

-- Create user command with optional argument
vim.api.nvim_create_user_command("CmakeBuild", CmakeBuild, {
	nargs = "?", -- optional argument
	complete = function()
		return { "Debug", "Release" }
	end,
})
