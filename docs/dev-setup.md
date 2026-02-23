# 開発環境セットアップガイド

このドキュメントでは、`ai-driven-dev-patterns` リポジトリを使って開発を始めるために必要なツールのインストール手順・設定手順を説明します。

---

## 前提OS

- **Linux**（Ubuntu 22.04 以降推奨）
- **macOS**（Ventura 13.0 以降推奨）

Windows は WSL2 上の Ubuntu で動作確認しています。ネイティブ Windows 環境は非推奨です。

---

## 必須ツール一覧

以下のツールが全て揃っている必要があります。

| ツール | 用途 | 最低バージョン | インストールコマンド（例） |
|--------|------|--------------|--------------------------|
| bash | シェルスクリプト実行 | 4.0 | OS標準（macOS は `brew install bash`） |
| git | バージョン管理 | 2.0 | `sudo apt install git` / `brew install git` |
| Node.js | openspec CLI / npm の実行基盤 | 18.0 | 下記参照 |
| npm | Node.js パッケージ管理（openspec インストール用） | 8.0 | Node.js に同梱 |
| claude（Claude Code CLI） | AIエージェントの起動・操作 | 任意 | 下記参照 |
| tmux | 複数エージェントを並列起動する際に使用 | 2.0 | `sudo apt install tmux` / `brew install tmux` |

---

## 推奨ツール一覧

必須ではありませんが、スクリプトや補助機能で利用されるため導入を推奨します。

| ツール | 用途 | 最低バージョン | インストールコマンド（例） |
|--------|------|--------------|--------------------------|
| curl | HTTP通信（スクリプト内での利用） | 7.0 | `sudo apt install curl` / `brew install curl` |
| jq | JSON処理（スクリプト内での利用） | 1.6 | `sudo apt install jq` / `brew install jq` |
| python3 | スクリプト補助 | 3.8 | `sudo apt install python3` / `brew install python3` |

---

## インストール手順

### 1. bash

**Linux**: 通常プリインストール済み。バージョン確認: `bash --version`

**macOS**: システム標準は古い bash 3.x のため、Homebrew で最新版を導入します。

```bash
brew install bash
# /opt/homebrew/bin/bash を PATH の先頭に追加（~/.zshrc または ~/.bash_profile）
export PATH="/opt/homebrew/bin:$PATH"
```

---

### 2. git

**Linux（Ubuntu/Debian）**:

```bash
sudo apt update
sudo apt install git
git --version
```

**macOS**:

```bash
brew install git
git --version
```

---

### 3. Node.js / npm

公式の nvm（Node Version Manager）を使って最新 LTS を導入することを推奨します。

```bash
# nvm のインストール
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# シェルを再起動後、Node.js LTS をインストール
nvm install --lts
nvm use --lts

# 確認
node --version   # v22.x.x 以上であること
npm --version    # 10.x.x 以上であること
```

---

### 4. Claude Code CLI（claude コマンド）

Anthropic が提供する Claude Code CLI をインストールします。

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

初回起動時に Anthropic アカウントへのログインが求められます。指示に従い認証を完了してください。

---

### 5. tmux

**Linux（Ubuntu/Debian）**:

```bash
sudo apt update
sudo apt install tmux
tmux -V
```

**macOS**:

```bash
brew install tmux
tmux -V
```

---

### 6. openspec CLI（推奨）

OpenSpec を使った仕様駆動開発を行う場合は、以下のコマンドでインストールします。

```bash
npm install -g @fission-ai/openspec
openspec --version

# プロジェクトで OpenSpec を初期化（初回のみ）
openspec init --tools claude
```

---

### 7. curl / jq / python3

**Linux（Ubuntu/Debian）**:

```bash
sudo apt update
sudo apt install curl jq python3
```

**macOS**:

```bash
brew install curl jq python3
```

---

## セットアップ後の確認

インストールが完了したら、以下のスクリプトを実行して全ツールが正しくセットアップされているか確認します。

```bash
bash scripts/setup.sh
```

全ツールが揃っていれば以下のメッセージが表示されます。

```
✅ セットアップ確認 OK
```

不足しているツールがある場合は `ERROR: <ツール名> が見つかりません` と表示されるので、対応するインストール手順を参照して導入してください。

---

## トラブルシューティング

### `claude: command not found`

Claude Code CLI がインストールされていないか、PATH が通っていません。

```bash
# グローバルインストール先を確認
npm bin -g
# 出力されたパスを PATH に追加（例: /home/user/.nvm/versions/node/v22.x.x/bin）
export PATH="$(npm bin -g):$PATH"
```

---

### `openspec: command not found`

openspec がグローバルインストールされていません。

```bash
npm install -g @fission-ai/openspec
```

---

### `tmux: command not found`

tmux が未インストールです。前述のインストール手順を参照してください。
`launch_team.sh` による複数エージェント起動には tmux が必須です。

---

### `node` / `npm` のバージョンが古い

nvm 管理下にある場合:

```bash
nvm install --lts
nvm use --lts
```

nvm 未使用の場合は公式サイト（https://nodejs.org/）から最新 LTS をダウンロードしてください。

---

### macOS で bash バージョンが 3.x のまま

`/usr/bin/bash` ではなく `/opt/homebrew/bin/bash` が使われるよう PATH を設定してください。

```bash
which bash  # /opt/homebrew/bin/bash であること
bash --version  # GNU bash, version 5.x 以上であること
```

---

## 更新履歴

| 日付 | 内容 | 更新者 |
|------|------|--------|
| 2026-02-23 | 初版作成 | L2-worker（dev-setup-knowledge フェーズ1） |
