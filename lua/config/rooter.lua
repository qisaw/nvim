local function neotree_is_open()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "neo-tree" then
			return true
		end
	end
	return false
end

local function set_root()
	local buf = vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		return
	end

	-- don't run root detection when entering neo-tree itself
	if vim.bo[buf].filetype == "neo-tree" then
		return
	end

	if vim.bo[buf].filetype == "codecompanion" then
		return
	end

	local root = vim.fs.root(name, { "package.json", ".git", "pnpm-workspace.yaml" })
	if root and root ~= vim.fn.getcwd() then
		vim.cmd.tcd(root) -- tab-local cwd

		-- if Neo-tree is open, re-root it to the new cwd
		if neotree_is_open() then
			vim.cmd("Neotree action=show source=filesystem dir=" .. vim.fn.fnameescape(root))
			-- `dir=...` sets the Neo-tree root/cwd :contentReference[oaicite:6]{index=6}
		end
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = set_root,
})
