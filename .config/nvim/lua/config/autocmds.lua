-- LazyVim が起動時に自動で読み込む autocmd 設定。

-- git のコミットメッセージ編集時は自動整形を切る。
-- textwidth=0 で折り返しを無効化し、formatoptions から t（本文の自動折返し）と
-- c（コメントの自動折返し）を外す。コミットメッセージを意図せず改行させないため。
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 0
    vim.opt_local.formatoptions:remove({ "t", "c" })
  end,
})
