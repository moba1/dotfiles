-- LSP configuration
vim.keymap.set('n', '<C-S-h>', '<cmd>:lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<C-S-f>', '<cmd>:lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', '<C-S-r>', '<cmd>:lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<C-S-d>', '<cmd>:lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<C-S-e>', '<cmd>:lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<C-S-i>', '<cmd>:lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<C-S-t>', '<cmd>:lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<C-S-n>', '<cmd>:lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<C-S-c>', '<cmd>:lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<C-S-o>', '<cmd>:lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<C-S-]>', '<cmd>:lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<C-S-[>', '<cmd>:lua vim.diagnostic.goto_prev()<CR>')
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities
}

-- autocompletion configuration
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- UI configuration
vim.cmd[[colorscheme nord]]
require'lualine'.setup()

-- filer configuration
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')

-- aerial configuration
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
