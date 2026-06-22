# moba1's dotfiles

## Usage
install [yadm](https://yadm.io/) & run:

```bash
yadm clone https://github.com/moba1/dotfiles
```

## Neovim

設定は [LazyVim](https://www.lazyvim.org/) をベースにしている。プラグインの版は
`~/.config/nvim/lazy-lock.json` で固定し、自動更新は無効化している。更新するときは
`:Lazy update` を手動で実行し、動作を確認したうえで `lazy-lock.json` をコミットする。

### Treesitter のセットアップ前提

`nvim-treesitter` は 2025 年に非互換な書き直しが行われ、`main` ブランチが新版となった
（`master` は Neovim 0.11 までの後方互換用にロックされている）。新版は構文解析器
（parser）を同梱せず、各マシンでローカルにビルドする方式へ変わった。このため新しい
マシンでは次のものが事前に必要になる。

- Neovim 0.12.0 以降
- `tree-sitter` CLI 0.26.1 以降（npm ではなくパッケージマネージャで導入する。例: `mise use -g tree-sitter`）
- C コンパイラ（parser のビルドに使う）
- `tar` と `curl`

これらが揃っていれば、LazyVim が parser のインストールと更新（`:TSUpdate`）を扱う。
`lazy-lock.json` で版を固定しているため、parser の再ビルドが必要になるのは
プラグインを更新したときだけで、日常の利用では発生しない。
