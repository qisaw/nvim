vim.g.mapleader = ","

local map = vim.keymap.set
local opts = { noremap = true }

---------------------------------------------------------------------------
-- Weird keyboard layout remaps
---------------------------------------------------------------------------

-- Normal mode
map("n", "l", "o", opts)
map("n", "o", "l", opts)
map("n", "L", "O", opts)
map("n", "O", "L", opts)

map("n", "j", "n", opts)
map("n", "n", "j", opts)
map("n", "J", "N", opts)
map("n", "N", "J", opts)

-- Next/prev for the last / or ? search (works with Flash search integration too)
map("n", "q", "n", { noremap = true, silent = true, desc = "Next search match" })
map("n", "Q", "N", { noremap = true, silent = true, desc = "Prev search match" })

map("n", "k", "e", opts)
map("n", "e", "k", opts)
map("n", "K", "E", opts)
map("n", "E", "<nop>", opts)

map("n", "h", "y", opts)
map("n", "y", "h", opts)
map("n", "H", "Y", opts)
map("n", "Y", "H", opts)

-- Operator-pending mode
map("o", "h", "y", opts)

-- Visual mode
map("v", "l", "o", opts)
map("v", "o", "l", opts)
map("v", "L", "O", opts)
map("v", "O", "L", opts)

map("v", "j", "n", opts)
map("v", "n", "j", opts)
map("v", "J", "N", opts)
map("v", "N", "J", opts)

map("v", "k", "e", opts)
map("v", "e", "k", opts)
map("v", "K", "E", opts)
map("v", "E", "<nop>", opts)

map("v", "h", "y", opts)
map("v", "y", "h", opts)
map("v", "H", "Y", opts)
map("v", "Y", "H", opts)

---------------------------------------------------------------------------
-- Leader mappings
---------------------------------------------------------------------------

-- <leader>cd → cd to current file's directory and show pwd
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { noremap = true, silent = true })

-- <leader><space> → previous buffer
map("n", "<leader><space>", ":b#<CR>", { noremap = true, silent = true })

---------------------------------------------------------------------------
-- Insert / Terminal / Misc
---------------------------------------------------------------------------

-- In terminal: <leader><leader>q → exit to normal mode
map("t", "<leader><leader>q", [[<C-\><C-n>]], { noremap = true })

-- %f to copy current file path to clipboard
map("n", "%f", ":let @+=@%<CR>", { noremap = true, silent = true })
