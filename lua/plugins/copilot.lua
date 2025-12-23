return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("i", "<C-O>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
		end,
	},
}
