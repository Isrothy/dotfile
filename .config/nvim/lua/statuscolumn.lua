local function mk_hl(group, sym)
	return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_signs_from_group(bufnum, lnum, group)
	local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
		group = group,
		lnum = lnum,
	})
	if cur_sign_tbl == nil then
		return nil
	end
	local cur_signs = cur_sign_tbl[1]
	if cur_signs == nil then
		return nil
	end
	cur_signs = cur_signs.signs
	return cur_signs
end

local function make_sign_col(name)
	local sign_defined = vim.fn.sign_getdefined(name)[1]
	local sign_text = sign_defined.text
	local texthl = sign_defined.texthl or "NONE"
	return mk_hl(texthl, sign_text)
end

_G.get_statuscol_gitsign = function(bufnum, lnum)
	local cur_signs = get_signs_from_group(bufnum, lnum, "gitsigns_vimfn_signs_")
	if cur_signs == nil then
		return "  "
	end
	local selected = cur_signs[1]
	if selected == nil then
		return "  "
	end
	return make_sign_col(selected.name)
end

_G.get_my_signcol = function(bufnum, lnum)
	local cur_signs = get_signs_from_group(bufnum, lnum, "*")
	if cur_signs == nil then
		return "%2.2\\  "
		-- return "  "
	end
	local selected = nil
	for _, sign in pairs(cur_signs) do
		if not vim.startswith(sign.name, "GitSigns") then
			selected = sign
			break
		end
	end
	if selected == nil then
		return "%2.2\\  "
		-- return "  "
	end
	return make_sign_col(selected.name)
end

_G.get_statuscol = function()
	local str_table = {}

	local parts = {
		["fold"] = [[%{% foldlevel(v:lnum) ? '%C' : '' %}]],
		["gitsigns"] = "%{%v:virtnum == 0 ? (v:lua.get_statuscol_gitsign(bufnr(), v:lnum)) : ' '%}",
		-- ["num"] = "%{v:virtnum == 0 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . ' ' : v:lnum) : ''}",
		["num"] = "%{v:virtnum == 0 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}",
		["sep"] = "%=",
		["signcol"] = "%{%v:virtnum == 0 ? (v:lua.get_my_signcol(bufnr(), v:lnum)) : '  '%}",
		-- ["signcol"] = "%s",
		["space"] = " ",
	}
	local order = {
		"signcol",
		"sep",
		"num",
		-- "fold"
		"gitsigns",
		-- "space",
	}
	for _, val in ipairs(order) do
		table.insert(str_table, parts[val])
	end
	return table.concat(str_table)
end

-- vim.o.foldcolumn = "1"
vim.opt.signcolumn = "yes:1"
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.numberwidth = 4

vim.o.statuscolumn = "%!v:lua.get_statuscol()"
