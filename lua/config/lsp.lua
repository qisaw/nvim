vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("terraformls")
vim.lsp.enable("docker_language_server")
vim.lsp.enable("prismals")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf })

			-- Map Tab and Shift-Tab for the completion menu
			vim.keymap.set("i", "<Tab>", function()
				return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
			end, { expr = true, buffer = ev.buf })

			vim.keymap.set("i", "<S-Tab>", function()
				return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
			end, { expr = true, buffer = ev.buf })

			vim.keymap.set("i", "<CR>", function()
				if vim.fn.pumvisible() == 1 then
					if vim.fn.complete_info().selected ~= -1 then
						return "<C-y>"
					else
						return "<C-e><CR>" -- cancel + newline
					end
				end
				return "<CR>"
			end, { expr = true, buffer = ev.buf })

			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end, { buffer = ev.buf })
		end
	end,
})
