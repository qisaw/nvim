vim.g.copilot_no_tab_map = true

vim.pack.add ({ { src = "https://github.com/github/copilot.vim", name="copilot" } })

vim.keymap.set("i", "<C-O>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
