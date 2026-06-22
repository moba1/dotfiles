-- LazyVim が起動時に自動で読み込むオプション設定。
-- vim.g / vim.opt の既定はここに集約する。

-- 不可視文字の可視化
vim.opt.list = true
vim.opt.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }

-- 行末・行頭で h / l やカーソルキーを押したとき前後行へ折り返す
vim.opt.whichwrap = "h,l,<,>,[,],~"

-- 対応する括弧を一瞬ハイライトする
vim.opt.showmatch = true

-- システムクリップボードと連携する
vim.opt.clipboard:append({ "unnamedplus" })

-- WSL ではクリップボード連携を win32yank に委ねる。
-- WSL の Linux 側からは Windows のクリップボードへ直接書けないため、
-- Windows 側バイナリ win32yank.exe を経由する。
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --crlf",
      ["*"] = "win32yank.exe -o --crlf",
    },
    cache_enable = 0,
  }
end
