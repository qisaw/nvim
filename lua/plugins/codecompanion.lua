vim.pack.add({
	-- deps
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- codecompanion + extensions
	{ src = "https://github.com/olimorris/codecompanion.nvim" },
	{ src = "https://github.com/ravitemer/mcphub.nvim" },
	{ src = "https://github.com/ravitemer/codecompanion-history.nvim" },

	-- using nvim-cpm completion for code-companion only as
	-- built in completion is not supported by codecompanion yet
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
})

local cmp = require("cmp")
local select = { behavior = cmp.SelectBehavior.Select }

local function select_next_or_complete()
	if cmp.visible() then
		cmp.select_next_item(select)
		return
	end

	cmp.complete()
end

local function select_prev_or_complete()
	if cmp.visible() then
		cmp.select_prev_item(select)
		return
	end

	cmp.complete()
end

-- Disable cmp everywhere by default so your normal buffers keep using
-- Neovim 0.12 native completion.
cmp.setup({
	enabled = function()
		local filetype = vim.bo.filetype
		return filetype == "codecompanion" or filetype == "codecompanion_input"
	end,
	sources = {
		{ name = "path" },
		{ name = "buffer" },
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "codecompanion", "codecompanion_input" },
	callback = function(args)
		cmp.setup.buffer({
			enabled = true,
			completion = {
				autocomplete = { cmp.TriggerEvent.TextChanged },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(select_next_or_complete, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(select_prev_or_complete, { "i", "s" }),
				["<C-n>"] = cmp.mapping(select_next_or_complete, { "i", "s" }),
				["<C-p>"] = cmp.mapping(select_prev_or_complete, { "i", "s" }),
			}),
		}, args.buf)
	end,
})

require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "codex",
			opts = { completion_provider = "cmp" },
		},
		inline = {
			adapter = {
				name = "openai",
				model = "gpt-5.5",
			},
			opts = { completion_provider = "cmp" },
		},
	},
	extensions = {
		mcphub = {
			callback = "mcphub.extensions.codecompanion",
			opts = {
				make_vars = true,
				make_slash_commands = true,
				show_result_in_chat = true,
			},
		},
		history = {
			enabled = true,
			opts = {
				auto_generate_title = true,
				title_generation_opts = {
					adapter = {
						name = "openai",
						model = "gpt-5-mini",
					},
				},
				picker = "fzf-lua",
			},
		},
	},
})
