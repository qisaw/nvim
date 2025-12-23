local opt = vim.opt

opt.smartindent = true
opt.backupcopy = "yes"

-- tabs / indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- wrapping
opt.wrap = false

-- search case
opt.ignorecase = true
opt.smartcase = true

-- matching parens/brackets
opt.showmatch = true

-- spacing
opt.linespace = 0

-- line numbers
opt.relativenumber = true
opt.number = true

-- scroll
opt.scrolloff = 3

-- clipboard (matches: set clipboard+=unnamed)
opt.clipboard:append("unnamedplus")

-- shell
opt.shell = "/bin/bash"

-- spelling (matches: set nospell)
opt.spell = false

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.vim/undo")

opt.undolevels = 1000
opt.undoreload = 10000
