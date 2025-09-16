-- plugin setup
require('config.lazy')

-- load local config
local config_file = vim.fn.stdpath("config") .. "/local.lua"
if vim.fn.filereadable(config_file) == 1 then
  dofile(config_file)
end

-- UI configuration
vim.opt.list = true
vim.opt.listchars = { tab='»-', trail='-', eol='↲', extends='»', precedes='«', nbsp='%' }
vim.opt.whichwrap = 'h,l,<,>,[,],~'
vim.opt.showmatch = true

-- clipboard configuration
vim.opt.clipboard:append({ "unnamedplus" })
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf"
    },
    paste = {
      ["+"] = "win32yank.exe -o --crlf",
      ["*"] = "win32yank.exe -o --crlf"
    },
    cache_enable = 0,
  }
end
