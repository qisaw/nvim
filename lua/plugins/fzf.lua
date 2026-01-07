return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostics disable: missing-fields
	---@diagnostics enable: missing-fields
	opts = {},
	keys = {
		{
			"<C-a>",
			function()
				require("fzf-lua").files()
			end,
			desc = "FzfLua: Files",
		},
		{
			"<C-p>",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "FzfLua: Git files",
		},
		{
			"<C-f>",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "FzfLua: Live grep",
		},
		{
			"<C-b>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "FzfLua: Buffers",
		},
	},
	config = function()
		local signs = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		}

		local function project_root()
			local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
			return (vim.v.shell_error == 0 and root ~= "") and root or vim.loop.cwd()
		end

		-- error popup for line
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
		end, { desc = "Line diagnostics" })
		-- error popup for file
		vim.keymap.set("n", "<leader>fd", function()
			require("fzf-lua").diagnostics_document()
		end, { desc = "Diagnostics (buffer)" })
		-- error popup for workspace
		vim.keymap.set("n", "<leader>fD", function()
			require("fzf-lua").diagnostics_workspace()
		end, { desc = "Diagnostics (buffer)" })

		vim.keymap.set({ "n", "v", "i" }, "<leader>ca", function()
			require("fzf-lua").lsp_code_actions()
		end, { desc = "Code actions (fzf)" })

		vim.keymap.set("n", "gd", function()
			require("fzf-lua").lsp_definitions()
		end, { desc = "LSP: Definitions (fzf)" })

		vim.keymap.set("n", "gr", function()
			require("fzf-lua").lsp_references()
		end, { desc = "LSP: References (fzf)" })

		vim.keymap.set("n", "<leader>g", function()
			require("fzf-lua").grep_cword()
		end, { desc = "GREP Word" })

		vim.keymap.set("n", "<C-u>", function()
			require("fzf-lua").live_grep({ cwd = project_root() })
		end)

		vim.diagnostic.config({
			signs = { text = signs },
			underline = true,
			virtual_text = {
				spacing = 2,
				prefix = "●",
			},
			severity_sort = true,
			float = { border = "rounded" },
		})
	end,
}
