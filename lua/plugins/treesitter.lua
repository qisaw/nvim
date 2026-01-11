return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		cmd = { "TSInstall", "TSUpdate" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },

			-- install parsers you actually use
			ensure_installed = {
				-- Neovim
				"lua",
				"vim",
				"vimdoc",

				-- Web / Next.js
				"typescript",
				"tsx",
				"javascript",
				"json",
				"jsonc",
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
				"yaml",
				"markdown",
				"markdown_inline",
			},

			auto_install = true, -- installs missing parsers when you open a filetype
		},
		init = function()
			require("nvim-treesitter").install({
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
				"yaml",
				"markdown",
				"markdown_inline",
			})

			-- start TS when a buffer’s filetype has highlight queries
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
						vim.wo[win].foldenable = true -- disable folding by default
						vim.wo[win].foldlevel = 99 -- open all folds by default
					end
				end,
			})
		end,
	},
}
