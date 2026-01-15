return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"ts_ls",
				"eslint",
				"lua_ls",
				"terraformls",
				"dockerls",
				"docker_compose_language_service",
				"prismals",
			},
			automatic_installation = true,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettierd",
				"stylua",
			},
			auto_update = false,
			run_on_start = true,
		},
	},

	-- Provides server configs (even if you DON'T call require("lspconfig") anymore)
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Capabilities for nvim-cmp (optional but recommended)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp.default_capabilities(capabilities)
			end

			-- LSP keymaps (recommended: do it on LspAttach now)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				end,
			})

			-- Configure servers (new API)
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("eslint", {
				capabilities = capabilities,
				settings = {
					eslint = {
						-- Critical for monorepos / nested apps (e.g. apps/web):
						workingDirectory = { mode = "auto" },
						-- If you're on ESLint v9 flat config, turn this on:
						useFlatConfig = true,
					},
				},
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.list_extend(vim.api.nvim_get_runtime_file("", true), {
								vim.fn.stdpath("config") .. "/lua/types",
							}),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Terraform
			vim.lsp.config("terraformls", { capabilities = capabilities })

			-- Dockerfile
			vim.lsp.config("dockerls", { capabilities = capabilities })

			-- Docker Compose
			vim.lsp.config("docker_compose_language_service", { capabilities = capabilities })

			-- Prisma
			vim.lsp.config("prismals", { capabilities = capabilities })

			-- Enable them
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("terraformls")
			vim.lsp.enable("dockerls")
			vim.lsp.enable("docker_compose_language_service")
			vim.lsp.enable("prismals")
			vim.lsp.enable("eslint")
		end,
	},
}
