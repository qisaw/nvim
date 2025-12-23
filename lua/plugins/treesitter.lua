return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
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
			},

			auto_install = true, -- installs missing parsers when you open a filetype
		},
	},
}
