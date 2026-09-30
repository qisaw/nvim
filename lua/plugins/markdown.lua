vim.pack.add({
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/3rd/image.nvim" },
	{ src = "https://github.com/3rd/diagram.nvim" },
})

require("render-markdown").setup({
	file_types = { "markdown", "codecompanion" },
})

require("image").setup({
	backend = "kitty",
	processor = "magick_cli",
})

local markdown_integration = require("diagram.integrations.markdown")
markdown_integration.filetypes = { "markdown", "codecompanion" }

require("diagram").setup({
	integrations = {
		markdown_integration,
	},
	events = {
		-- Avoid invoking mmdc for every streamed token.
		render_buffer = { "BufWinEnter" },
		clear_buffer = { "BufLeave" },
	},
	renderer_options = {
		mermaid = {
			theme = "dark",
			scale = 2,
		},
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "CodeCompanionChatDone",
	callback = function(args)
		if vim.bo[args.buf].filetype ~= "codecompanion" then
			return
		end

		local win = vim.fn.bufwinid(args.buf)
		if win ~= -1 then
			vim.api.nvim_win_call(win, function()
				require("diagram").render()
			end)
		end
	end,
})
