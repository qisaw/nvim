vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local treesitter = require("nvim-treesitter")

treesitter.install({
	-- Neovim
	"lua",
	"vim",
	"vimdoc",

	-- Web / Next.js
	"typescript",
	"tsx",
	"javascript",
	"json",
	"yaml",
	"html",
	"css",

	-- DevOps / infra
	"dockerfile",
	"terraform",
	"hcl",

	-- DB / tools
	"prisma",

	-- For AI tools
	"markdown",
	"markdown_inline",
})

local grp = vim.api.nvim_create_augroup("TSMain", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = grp,
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if lang and vim.treesitter.query.get(lang, "highlights") then
			vim.treesitter.start(ev.buf, lang)
		end
		-- indent via Treesitter indentexpr (if indent queries exist)
		-- if lang and vim.treesitter.query.get(lang, "indents") then
		-- 	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- end
		if lang and vim.treesitter.query.get(lang, "folds") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win].foldmethod = "expr"
			vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[win].foldenable = true -- enable folding by default
			vim.wo[win].foldlevel = 99 -- open all folds by default
		end
	end,
})
