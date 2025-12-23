local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- moving cursors between windows
map("n", "<leader>n", "<C-w><C-j>", opts)
map("n", "<leader>e", "<C-w><C-k>", opts)
map("n", "<leader>o", "<C-w><C-l>", opts)
map("n", "<leader>y", "<C-w><C-h>", opts)

-- rotating windows
map("n", "<leader><leader>r", "<C-w><C-r>", opts)
map("n", "<leader><leader>R", "<C-w>R", opts)

-- resizing windows
map("n", "<leader>+", "<C-w>+", opts)
map("n", "<leader>-", "<C-w>-", opts)
map("n", "<leader><", "<C-w><", opts)
map("n", "<leader>>", "<C-w>>", opts)

-- creating new windows
map("n", "<leader><leader>s", "<C-w><C-s>", opts)
map("n", "<leader><leader>v", "<C-w><C-v>", opts)
map("n", "<leader><leader>y", "<C-w><C-n>", opts)

-- disable default window cycling
map("n", "<C-w><C-w>", "<nop>", opts)
