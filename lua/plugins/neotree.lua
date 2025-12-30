return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false, -- neo-tree will lazily load itself

		keys = {
			{ "<C-o>", "<Cmd>Neotree toggle<CR>", desc = "Neo-tree: Toggle" },
		},

		opts = {
			window = {
				mappings = {
					["e"] = "noop",
					["k"] = "toggle_auto_expand_width",
				},
			},
			filesystem = {
				components = {
					name = function(config, node, state)
						local comps = require("neo-tree.sources.common.components")
						local item = comps.name(config, node, state)
						if node:get_depth() == 1 then
							local root = state.path or ""
							local child = vim.fs.basename(root)
							local parent = vim.fs.basename(vim.fs.dirname(root))
							item.text = parent ~= "" and (parent .. "/" .. child) or child
						end
						return item
					end,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				use_libuv_file_watcher = true,
				bind_to_cwd = true, -- sync Neo-tree root <-> vim cwd :contentReference[oaicite:3]{index=3}
				filtered_items = {
					visible = true, -- this option will force the visibility of hidden files :contentReference[oaicite:1]{index=1}
				},

				cwd_target = {
					sidebar = "tab", -- left/right sidebar uses tab-local cwd :contentReference[oaicite:4]{index=4}
					current = "window", -- position=current uses window-local cwd :contentReference[oaicite:5]{index=5}
				},
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
