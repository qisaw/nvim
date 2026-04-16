vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })

require("catppuccin").setup({
	flavour = "frappe",
	background = {
		light = "latte",
		dark = "frappe",
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		neotree = true,
		treesitter = true,
		notify = true,
	},
})

vim.cmd([[colorscheme catppuccin]])
