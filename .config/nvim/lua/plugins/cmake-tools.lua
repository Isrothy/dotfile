local M = {
	"Civitasv/cmake-tools.nvim",
	ft = { "cmake", "cpp", "c" },
	enabled = true,
}

M.config = function()
	require("cmake-tools").setup({
		cmake_command = "cmake",
		cmake_build_directory = "",
		cmake_build_directory_prefix = "cmake_build_", -- when cmake_build_directory is "", this option will be activated
		cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
		cmake_build_options = {},
		cmake_console_size = 10, -- cmake output window height
		cmake_show_console = "always", -- "always", "only_on_error"
		cmake_dap_configuration = nil, -- dap configuration, optional
		cmake_dap_open_command = nil, -- optional
		cmake_variants_message = {
			short = { show = true },
			long = { show = true, max_length = 40 },
		},
	})
end
return M
