-- LazyVim が起動時に自動で読み込むキーマップ設定。
-- 個別プラグインのキーは各プラグインの spec 側（keys = {...}）に置き、
-- ここには横断的な設定と which-key のグループ見出しだけを置く。

-- which-key のグループ見出し。<leader> は既定でスペースキー。
-- Space → a を押した時のメニューに「AI (Amazon Q)」と表示する。
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>a", group = "AI (Amazon Q)" },
  })
end
