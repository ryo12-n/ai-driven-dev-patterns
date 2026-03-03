以下の内容を実現したいので、TODO整理して、人間タスク、クロードタスクを分けて、実施進めていきたい

前提を踏まえると、フェーズ2は **「WSL 上でメインリポ＋`--add-dir` で 2〜3 個を束ねる構成」**が一番きれいです。[1][2]

***

## 全体方針（フェーズ2 on WSL）

- 各プロジェクトは **完全に別 Git リポ** として維持
- WSL 上に `~/dev` などのフォルダを作り、そこに clone
- 「そのとき一緒に触りたい 2〜3 リポ」を `claude --add-dir` で 1 セッションにまとめる
- iPhone からは CodeSail でセッションにチャット指示、たまに Windows 側 VS Code（Remote-WSL）で手作業編集

***

## 手順 1：WSL ＋ 開発ディレクトリ

1. Windows で WSL（Ubuntu）を導入済みと仮定
2. WSL で：

```bash
mkdir -p ~/dev
cd ~/dev

git clone git@github.com:you/backend.git
git clone git@github.com:you/frontend.git
git clone git@github.com:you/shared-lib.git
```

これで、**各リポは独立 Git** のまま。[3][4]

***

## 手順 2：Claude Code CLI を WSL に入れる

```bash
# 例：公式インストーラー
curl -fsSL https://claude.ai/install.sh | bash
# もしくは
sudo npm install -g @anthropic-ai/claude-code
```

インストール後、`claude --version` が動けば OK です。[5][6]

***

## 手順 3：1セッションで 2〜3 リポを束ねる

### 3-1. 実行ディレクトリの決め方

- 「一番軸にしたいリポ」をカレントにする（例：backend）  
- そこに **軽めの CLAUDE.md** を置いて「他リポの役割」を説明しておくと、Claude が理解しやすいです。[2]

```bash
cd ~/dev/backend
```

`backend/CLAUDE.md`（例）：

```markdown
# Backend project

このプロジェクトは API サービスです。

- `../frontend` — フロントエンド（Next.js）
- `../shared-lib` — 共通ライブラリ（TypeScript）
これらを /add-dir でワークスペースに追加して一緒に扱います。
```

### 3-2. `--add-dir` でワークスペースを構成

```bash
cd ~/dev/backend

claude \
  --add-dir ../frontend \
  --add-dir ../shared-lib
```

これで「backend＋frontend＋shared-lib」が 1 セッション内で見えるようになります。[1][2]
必要に応じて `--add-dir` を減らして 2 リポ構成にもできます。

***

## 手順 4：CodeSail で iPhone から触る

1. **WSL 内** で CodeSail CLI をインストール：

```bash
npm install -g codesail
```

2. ペアリング：

```bash
cd ~/dev/backend   # どこでもよい
codesail pair
# → 端末に QR コード表示
```

3. iPhone で CodeSail アプリをインストールし、QR を読み取ってペアリング。[7]

以降の運用：

```bash
# (WSL 上で)
cd ~/dev/backend
claude --add-dir ../frontend --add-dir ../shared-lib

# (iPhone)
CodeSail アプリでセッションを開き、チャットで指示
```

***

## 手順 5：VS Code（たまに使う用）

- Windows に VS Code をインストール
- 「Remote - WSL」拡張を入れておく[8]
- 必要なときだけ、VS Code で `~/dev` を開いて手作業編集

Claude と人間で編集が混在しても、Git さえ守れば問題ありません。

***

## 運用時の「指示の出し方」の型

iPhone からは、次のように毎回 **コンテキストを明示するプロンプト**にすると安定します。

```text
このセッションでは、3つのディレクトリを同時に扱います。

- backend/ : API サーバー（FastAPI）
- frontend/ : Next.js フロントエンド
- shared-lib/ : 型定義・共通ロジック

shared-lib を変更したときは、backend と frontend の両方の影響を必ず確認し、
必要な修正とテストを行ってください。
```

1セッションで扱うリポは 2〜3 個なので、毎回この程度の説明で十分です。[9][2]

***

## 壁打ちポイント（確認したいこと）

ここからもう一歩踏み込むなら、次のあたりを一緒に決めたいです：

- どのリポを「軸」にするか（毎回 backend 起点？タスクによって変える？）
- iPhone からの操作は  
  - 「常に同じセッションを長く使う」のか  
  - 「用事ごとに短いセッションを作って閉じる」のか
- セッション開始時に毎回 `--add-dir` を打つのが面倒なら、**簡単なシェルスクリプト**を作るかどうか

例：

```bash
# ~/dev/start-workspace.sh
#!/bin/bash
cd ~/dev/backend
claude --add-dir ../frontend --add-dir ../shared-lib
```

こんな感じで「どういう起動の仕方が一番楽そうか」を一緒に詰めたいのですが、  
軸にしたいリポ（よく中心になるプロジェクト）は backend / frontend / その他 のどれになりそうですか？

情報源
[1] Claude Code --add-dir: Additional Working Directories Guide https://www.claudelog.com/faqs/--add-dir/
[2] How Does Claude Code Multi-directory Support Transform ... https://apidog.com/blog/claude-code-multi-directory-support/
[3] Windows に WSL 環境を用意して Claude Code を導入する方法 https://dev.classmethod.jp/articles/windows-wsl-claude-code/
[4] claude codeをWindows環境(WSL2)にインストールする - Qiita https://qiita.com/teraco/items/0b628b530bdf945afa0f
[5] Claude Code をセットアップする https://code.claude.com/docs/ja/setup
[6] Complete Claude Code Installation Guide for Windows https://claude.ai/public/artifacts/d5297b60-4c2c-4378-879b-31cc75abdc98
[7] CodeSail — Control Claude Code from Your iPhone https://www.codesail.app
[8] Visual Studio Code on Windows https://code.visualstudio.com/docs/setup/windows
[9] Using Claude Code in a Large Monorepo: Practical Questions About Structure, Discoverability & Workflow https://www.reddit.com/r/ClaudeCode/comments/1mkbamr/using_claude_code_in_a_large_monorepo_practical/
