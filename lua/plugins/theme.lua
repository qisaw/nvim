return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				integrations = {
					cmp = true,
					gitsigns = true,
					neotree = true,
					treesitter = true,
					mason = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
