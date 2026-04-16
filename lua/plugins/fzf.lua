vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- optional
})
require("fzf-lua").setup({})

local signs = {
	[vim.diagnostic.severity.ERROR] = "",
	[vim.diagnostic.severity.WARN] = "",
	[vim.diagnostic.severity.INFO] = "",
	[vim.diagnostic.severity.HINT] = "",
}

local function project_root()
	local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
	return (vim.v.shell_error == 0 and root ~= "") and root or vim.uv.cwd()
end

vim.keymap.set("n", "<C-a>", function()
	require("fzf-lua").files()
end, { desc = "FzfLua: Files" })

vim.keymap.set("n", "<C-p>", function()
	require("fzf-lua").git_files()
end, { desc = "FzfLua: Git files" })

vim.keymap.set("n", "<C-f>", function()
	require("fzf-lua").live_grep()
end, { desc = "FzfLua: Live grep" })

vim.keymap.set("n", "<C-b>", function()
	require("fzf-lua").buffers()
end, { desc = "FzfLua: Buffers" })

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>fd", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Diagnostics (buffer)" })

vim.keymap.set("n", "<leader>fD", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Diagnostics (workspace)" })

vim.keymap.set("n", "gd", function()
	require("fzf-lua").lsp_definitions()
end, { desc = "LSP: Definitions (fzf)" })

vim.keymap.set("n", "gt", function()
	require("fzf-lua").lsp_typedefs()
end, { desc = "LSP: Type Definitions (fzf)" })

vim.keymap.set("n", "gr", function()
	require("fzf-lua").lsp_references()
end, { desc = "LSP: References (fzf)" })

vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").grep_cword()
end, { desc = "Grep word" })

vim.keymap.set("n", "<C-u>", function()
	require("fzf-lua").live_grep({ cwd = project_root() })
end, { desc = "FzfLua: Live grep project root" })

vim.diagnostic.config({
	signs = { text = signs },
	underline = true,
	virtual_text = {
		spacing = 2,
		prefix = "●",
	},
	severity_sort = true,
	float = { border = "rounded" },
})
