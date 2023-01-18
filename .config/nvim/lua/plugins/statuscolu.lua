return {
	"luukvbaal/statuscol.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("statuscol").setup({
			separator = " ", -- separator between line number and buffer text ("│" or extra " " padding)
			-- Builtin line number string options for ScLn() segment
			thousands = false, -- or line number thousands separator string ("." / ",")
			relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
			-- Custom line number string options for ScLn() segment
			lnumfunc = nil, -- custom function called by ScLn(), should return a string
			reeval = true, -- whether or not the string returned by lnumfunc should be reevaluated
			-- Builtin 'statuscolumn' options
			setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
			order = "FSNs", -- order of the fold, sign, line number and separator segments
			-- Click actions
		})
		-- vim.opt.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T%=%{v:lua.ScLn()}%T "
	end,
}
