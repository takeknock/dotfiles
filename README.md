# Dotfiles

個人用の開発環境設定ファイル（dotfiles）リポジトリです。

## 概要

このリポジトリには、各種開発ツールやアプリケーションの設定ファイルが含まれています。主にmacOS環境でPythonとGoの開発を行うための設定が中心となっています。

## 含まれる設定ファイル

### シェル設定
- **`.bashrc`** - Bash設定ファイル
  - MacPorts、MySQL、Xcodeデベロッパーツールのパス設定
  - カスタムエイリアス
- **`.zshrc`** - Zsh設定ファイル
  - Gitブランチ表示プロンプト
  - Claude CLI用エイリアス（`yolo`）
  - npm globalパス設定

### エディタ設定

#### Vim
- **`.vimrc`** - Vim設定ファイル
- **`.vim/`** ディレクトリ
  - `dein/` - dein.vimプラグインマネージャー設定
  - `ftplugin/python.vim` - Python専用設定
  - `userconfig/plugins.toml` - 基本プラグイン設定
  - `userconfig/plugins_lazy.toml` - 遅延読み込みプラグイン設定

主なVimプラグイン：
- Unite.vim（ファイル・バッファナビゲーション）
- Neomru.vim（最近使用したファイル）
- Jedi-vim（Python自動補完）
- Vim-go（Go言語サポート）
- Neosnippet（スニペット機能）

#### Emacs
- **`.emacs.d/`** - Emacs設定ディレクトリ
  - `init.el` - メイン設定ファイル
  - 各種elispパッケージとライブラリ
  - auto-complete設定
  - yasnippet設定

## ユーティリティスクリプト

- **`makesymbolic.sh`** - dotfilesからホームディレクトリへのシンボリックリンクを作成するスクリプト

## セットアップ

```bash
# リポジトリをクローン
git clone [repository-url] ~/dotfiles

# シンボリックリンクを作成
cd ~/dotfiles
./makesymbolic.sh
```

## 特徴

- 日本語環境対応（Emacs）
- Python開発環境（Jedi-vim、Python実行ショートカット）
- Go開発環境（vim-go）
- Git連携（ブランチ表示プロンプト）
- VimとEmacsの両対応
- macOS向け設定（MacPorts対応）

## 最近の更新

- Zsh設定ファイルの追加
- Python用Vim設定の改善（jedi-vim）
- 各種プラグインの更新と最適化

## ライセンス

個人使用を目的としたリポジトリです。