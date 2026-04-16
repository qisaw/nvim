vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit", },
  { src = "https://github.com/nvim-lua/plenary.nvim", },
  { src = "https://github.com/lewis6991/gitsigns.nvim", },
  { src = "https://github.com/sindrets/diffview.nvim", },
  { src = "https://github.com/FabijanZulj/blame.nvim", },
})

require("blame").setup({})

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Neogit" })
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: Open" })
vim.keymap.set("n", "<leader>dV", "<cmd>DiffviewClose<cr>", { desc = "Diffview: Close" })
