local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- moving cursors between windows
map("n", "<leader>n", "<C-w><C-j>", opts)
map("n", "<leader>e", "<C-w><C-k>", opts)
map("n", "<leader>o", "<C-w><C-l>", opts)
map("n", "<leader>y", "<C-w><C-h>", opts)

-- resizing windows
map("n", "<leader>+", "<C-w>+", opts)
map("n", "<leader>-", "<C-w>-", opts)
map("n", "<leader><", "<C-w><", opts)
map("n", "<leader>>", "<C-w>>", opts)
