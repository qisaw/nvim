vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/antosha417/nvim-lsp-file-operations"
})

require('neo-tree').setup({
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
      visible = false, -- this option will force the visibility of hidden files :contentReference[oaicite:1]{index=1}
      hide_by_name = { "node_modules", "dist" },
      hide_dotfiles = false,
      hide_hidden = false,
      hide_gitignored = false,
      hide_ignored = false,
    },

    cwd_target = {
      sidebar = "tab", -- left/right sidebar uses tab-local cwd :contentReference[oaicite:4]{index=4}
      current = "window", -- position=current uses window-local cwd :contentReference[oaicite:5]{index=5}
    },
  },
})

require("lsp-file-operations").setup()

vim.keymap.set("n", "<C-o>", function()
  vim.cmd.Neotree("toggle")
end, { desc = "Neo-tree: Toggle", })


