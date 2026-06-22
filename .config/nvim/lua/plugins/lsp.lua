-- LSP 設定の独自差分のみ。
-- セットアップ本体（vim.lsp.config / enable の呼び出し）は LazyVim 組み込みに委ねる。
-- ここでは opts のマージだけ行い、config 関数は定義しない。
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- TypeScript 系サーバは使わないため無効化する。
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = { enabled = false },
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            completion = { callSnippet = "Replace" },
            doc = { privateName = { "^_" } },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
    },
  },
}
