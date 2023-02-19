local gitsigns_bar = {
	GitSignsAdd = "│",
	GitSignsChange = "│",
	GitSignsDelete = "_",
	GitSignsTopdelete = "‾",
	GitSignsChangedelete = "~",
	GitSignsUntracked = "┆",
}

local gitsigns_hl_pool = {
	GitSignsAdd = "GitSignsAdd",
	GitSignsChange = "GitSignsChange",
	GitSignsChangedelete = "GitSignsChangedelete",
	GitSignsDelete = "GitSignsDelete",
	GitSignsTopdelete = "GitSignsTopdelete",
	GitSignsUntracked = "GitSignsUntracked",
}

local diag_signs_icons = {
	DiagnosticSignError = "",
	DiagnosticSignWarn = "",
	DiagnosticSignInfo = "",
	DiagnosticSignHint = "",
	DiagnosticSignOk = "",
}
local marks_signs_icons = function(marks_nm)
	return string.sub(marks_nm, 7, 7)
end

local function get_sign_name(cur_sign)
	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign.signs

	if cur_sign == nil then
		return nil
	end
	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	return cur_sign["name"]
end

local function mk_hl(group, sym)
	return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_name_from_group(bufnum, lnum, group)
	local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
		group = group,
		lnum = lnum,
	})

	return get_sign_name(cur_sign_tbl)
end

_G.get_statuscol_gitsign = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "gitsigns_vimfn_signs_")

	if cur_sign_nm ~= nil then
		return mk_hl(gitsigns_hl_pool[cur_sign_nm], gitsigns_bar[cur_sign_nm])
	else
		return " "
	end
end

_G.get_statuscol_diag = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

	if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
		return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
	else
		return " "
	end
end

_G.get_statuscol_marks = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "MarkSigns")

	if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "Marks_") then
		return mk_hl("MarksignHl", marks_signs_icons(cur_sign_nm))
	else
		return " "
	end
end

_G.get_statuscol_lightbulb = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")
	if cur_sign_nm ~= nil and cur_sign_nm == "LightBulbSign" then
		return mk_hl("NONE", "💡")
	else
		return " "
	end
end

_G.get_my_signcol = function(bufnum, lnum)
	local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
		group = "*",
		lnum = lnum,
	})
	if cur_sign_tbl == nil then
		return " "
	end
	local cur_signs = cur_sign_tbl[1]
	if cur_signs == nil then
		return " "
	end
	cur_signs = cur_signs.signs
	if cur_signs == nil then
		return " "
	end
	-- vim.api.nvim_echo({ { vim.inspect(cur_signs), "Normal" } }, true, {})
	local selected = nil
	for _, sign in ipairs(cur_signs) do
		-- if not vim.startswith(sign.name, "GitSigns") and not vim.startswith(sign.name, "DiagnosticSign") then
		if not vim.startswith(sign.name, "GitSigns") then
			selected = sign
			break
		end
	end
	if selected == nil then
		return " "
	end
	local sign_defined = vim.fn.sign_getdefined(selected.name)[1]
	local sign_text = sign_defined.text
	local texthl = sign_defined.texthl or "NONE"
	return mk_hl(texthl, sign_text)
end

_G.get_statuscol = function()
	local str_table = {}

	local parts = {
		["lightbulb"] = "%{%v:lua.get_statuscol_lightbulb(bufnr(), v:lnum)%}",
		["marks"] = "%{%v:lua.get_statuscol_marks(bufnr(), v:lnum)%}",
		["diagnostics"] = "%{%v:lua.get_statuscol_diag(bufnr(), v:lnum)%}",
		["fold"] = "%C",
		["gitsigns"] = "%{%v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
		["num"] = "%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}",
		["sep"] = "%=",
		-- ["signcol"] = "%s",
		["signcol"] = "%{%v:lua.get_my_signcol(bufnr(), v:lnum)%}",
		["space"] = " ",
	}
	local order = {
		"signcol",
		"sep",
		"num",
		"space",
		"gitsigns",
	}

	for _, val in ipairs(order) do
		table.insert(str_table, parts[val])
	end

	return table.concat(str_table)
end
vim.o.statuscolumn = "%!v:lua.get_statuscol()"
vim.opt.numberwidth = 5
-- vim.opt.statuscolumn = "%s%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%="
