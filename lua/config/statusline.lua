local function git_branch()
	-- provided by gitsigns when attached
	local head = vim.b.gitsigns_head
	return head and (" " .. head) or ""
end

local function diag_counts()
	local levels = vim.diagnostic.severity
	local errors = #vim.diagnostic.get(0, { severity = levels.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = levels.WARN })
	local infoMsgs = #vim.diagnostic.get(0, { severity = levels.INFO })
	local hints = #vim.diagnostic.get(0, { severity = levels.HINT })

	local icons = { error = "", warning = "", info = "", hint = "󰌵" } -- swap sets here

	local parts = {}
	if errors > 0 then
		parts[#parts + 1] = ("%s %d"):format(icons.error, errors)
	end
	if warnings > 0 then
		parts[#parts + 1] = ("%s %d"):format(icons.warning, warnings)
	end
	if infoMsgs > 0 then
		parts[#parts + 1] = ("%s %d"):format(icons.info, infoMsgs)
	end
	if hints > 0 then
		parts[#parts + 1] = ("%s %d"):format(icons.hint, hints)
	end
	return table.concat(parts, " ")
end

local function filename()
	local f = vim.fn.expand("%:t")
	return (f == "" and "[No Name]") or f
end

_G.Statusline = function()
	local left = table.concat({
		" ",
		git_branch(),
		git_branch() ~= "" and "  " or "",
		filename(),
	})

	local d = diag_counts()
	local right = table.concat({
		d,
		d ~= "" and "  " or "",
		"%l:%c",
		" ",
		"%p%%",
		" ",
	})

	return left .. "%=" .. right
end

vim.o.statusline = "%!v:lua.Statusline()"

-- Force refresh when diagnostics change (otherwise it may only update on cursor move)
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})
