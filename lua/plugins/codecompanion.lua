vim.pack.add({
  -- deps
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- codecompanion + extensions
  { src = "https://github.com/olimorris/codecompanion.nvim" },
  { src = "https://github.com/ravitemer/mcphub.nvim" },
  { src = "https://github.com/ravitemer/codecompanion-history.nvim" },

  -- cpm for code-companion only
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
})

local cmp = require("cmp")
local select = { behavior = cmp.SelectBehavior.Select }

local function select_next_or_fallback(fallback)
  if cmp.visible() then
    cmp.select_next_item(select)
    return
  else
    fallback()
  end
end

local function select_prev_or_fallback(fallback)
  if cmp.visible() then
    cmp.select_prev_item(select)
    return
  else
    fallback()
  end
end

-- Disable cmp everywhere by default so your normal buffers keep using
-- Neovim 0.12 native completion.
cmp.setup({
  enabled = function()
    local filetype = vim.bo.filetype
    return filetype == "codecompanion" or filetype == "codecompanion_input"
  end,
})

-- Enable cmp only inside CodeCompanion chat buffers.
local codecompanion_cmp = {
  enabled = true,
  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(select_next_or_fallback, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(select_prev_or_fallback, { "i", "s" }),
    ["<C-n>"] = cmp.mapping(select_next_or_fallback, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(select_prev_or_fallback, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "codecompanion" },
    { name = "path" },
    { name = "buffer" },
  }),
}

for _, filetype in ipairs({ "codecompanion", "codecompanion_input" }) do
  cmp.setup.filetype(filetype, codecompanion_cmp)
end

require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "codex",
      opts = { completion_provider = "cmp" },
    },
    inline = {
      adapter = {
        name = "openai",
        model = "gpt-5.4",
      },
      opts = { completion_provider = "cmp" },
    },
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true
      }
    },
    history = {
      enabled = true,
      opts = {
        auto_generate_title = true,
        title_generation_opts = {
          adapter = {
            name = "openai",
            model = "gpt-5-mini",
          },
        },
        picker = "fzf-lua",
      },
    },
  },
})
