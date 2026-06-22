-- Amazon Q（AI チャット）。
-- キーマップは LazyVim の AI 系プレフィックス <leader>a 配下へ集約し、which-key に登録する。
-- プラグイン既定の `zq`（fold 系 z プレフィックスに紛れて分かりにくい）は使わない。
return {
  "amazonq",
  url = "https://github.com/awslabs/amazonq.nvim.git",
  cmd = "AmazonQ",
  -- <leader> は LazyVim 既定でスペースキー。以下コメントの「Space」は実際のスペースキーを指す。
  keys = {
    -- Space → a → q : チャットウィンドウを開く
    { "<leader>aq", "<cmd>AmazonQ<cr>", desc = "Amazon Q: チャットを開く" },
    -- Space → a → q（ビジュアル選択中）: 選択テキストをチャットの文脈に追加する
    { "<leader>aq", ":AmazonQ<cr>", mode = { "v", "x" }, desc = "Amazon Q: 選択を文脈に追加" },
    -- Space → a → e : 現在のファイルを説明させる
    { "<leader>ae", "<cmd>AmazonQ explain<cr>", desc = "Amazon Q: ファイルを説明" },
    -- Space → a → r（ビジュアル選択中）: 選択コードのリファクタリング案を出させる
    { "<leader>ar", ":AmazonQ refactor<cr>", mode = { "v", "x" }, desc = "Amazon Q: リファクタリング" },
  },
  opts = {
    ssoStartUrl = "https://d-90663dfa4e.awsapps.com/start",
  },
  config = function(_, opts)
    require("amazonq").setup(opts)
    -- setup が登録する既定の `zq`（fold 系 z プレフィックスと紛らわしい）を解除し、
    -- 操作系を <leader>a 配下へ一本化する。
    pcall(vim.keymap.del, "n", "zq")
    pcall(vim.keymap.del, "x", "zq")
  end,
}
