return {
	{
		"stevearc/overseer.nvim",
		opts = {
			-- strategy = {
			-- 	"toggleterm",
			-- 	direction = "vertical",
			-- 	close_on_exit = false,
			-- 	quit_on_exit = false,
			-- }
		},
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = "RunCode",
		enabled = true,
		keys = {
			{ "<leader>cr", ":RunCode<cr>" },
		},
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			mode = "toggleterm",
			startinsert = true,
			filetype = {
				c = "cd $dir && clang $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
				cpp = "cd $dir && clang++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
				dart = "dart",
				go = "go run",
				haskell = "runhaskell",
				lua = "luajit",
				java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
				javascript = "node",
				["objective-c"] = "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
				python = "python3 -u",
				r = "Rscript",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
				swift = "swift",
				typescript = "ts-node",

				zsh = "$dir/$fileName",
				bash = "$dir/$fileName",
				shell = "$dir/$fileName",
			},
		},
	},
}
