return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
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
		end,
	},
	{
		"uloco/bluloco.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("bluloco").setup({
				style = "light", -- "auto" | "dark" | "light"
			})

			local function set_theme()
				if vim.o.background == "light" then
					vim.cmd.colorscheme("bluloco")
				else
					vim.cmd.colorscheme("catppuccin-frappe")
				end
			end

			set_theme()
			vim.api.nvim_create_autocmd("OptionSet", {
				pattern = "background",
				callback = set_theme,
			})
		end,
	},
}
