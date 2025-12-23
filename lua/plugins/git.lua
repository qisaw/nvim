return {
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit" },
		},
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		cmd = { "DiffviewOpen", "DiffviewClose" },
		keys = {
			{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
			{ "<leader>dV", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
		},
		opts = {},
	},
}
