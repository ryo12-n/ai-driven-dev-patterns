# ai-driven-dev-patterns

> **疑似フォーク運用について**
>
> このリポジトリを社内 Enterprise へ取り込む場合、GitHub のフォーク機能は使わず、
> upstream/origin の2リモート管理方式（疑似フォーク）での運用を推奨しています。
> 同期手順は [docs/sync-guide.md](docs/sync-guide.md) を参照してください。

---

Claude Code + OpenSpec を前提とした、仕様駆動開発のリポジトリ構成テンプレートです。

---

## ディレクトリ構成

```text
your-project/
├── src/                                # アプリ本体のコード
├── tests/                              # テスト
├── openspec/                           # OpenSpec本体（仕様駆動レイヤ）
│   ├── config.yaml                     # スキーマ・プロジェクトコンテキスト設定
│   ├── specs/                          # 現在状態の仕様（Single Source of Truth）
│   └── changes/                        # 進行中の変更サイクル
├── docs/                               # 人間向けの日本語ドキュメント
│   ├── design-templates/               # 設計書テンプレート
│   │   ├── basic-design-template.md
│   │   └── detailed-design-template.md
│   ├── design-prompt-templates.md      # Claude用プロンプトパターン集
│   ├── design-review-checklist.md      # 設計書レビューチェックリスト
│   └── examples/                       # サンプルコード・画面イメージなど
├── CLAUDE.md                           # プロジェクト全体のルール・前提
└── .claude/
    ├── settings.json                   # Claude Codeの設定
    ├── commands/opsx/                  # /opsx:* スラッシュコマンド（openspec init が生成）
    ├── skills/                         # OpenSpec スキル（openspec init が生成）
    └── rules/
        ├── design-doc.md               # 設計書生成用ルール
        └── code-in-docs.md             # 設計書へのコード混入防止ルール
```

---

## 各ディレクトリ・ファイルの役割

### `src/`
アプリケーション本体のソースコードを置く場所。
OpenSpec の変更サイクルが完了した後、Claude が実装を書き込む対象ディレクトリ。

### `tests/`
テストコードを置く場所。
`openspec/changes/` 内の `tasks.md` に基づいてテストが生成・配置される。

---

### `openspec/` — 仕様駆動レイヤ

OpenSpec の標準構成に従い、AIと人間が共有する「仕様」の置き場所。

| ファイル/ディレクトリ | 役割 |
|---|---|
| `config.yaml` | スキーマ・プロジェクトコンテキスト・アーティファクト別ルールを設定する（`openspec init` で生成） |
| `specs/` | 現在の「真の仕様」一式。機能ごとにサブディレクトリを作り `spec.md` を置く |
| `changes/` | 進行中の変更ごとにサブディレクトリを作る。変更が完了したら `specs/` にマージする |

#### `openspec/changes/` 以下の構造（変更サイクル1件の例）

```text
changes/
└── add-user-profile/
    ├── proposal.md   # 何を・なぜ・スコープ
    ├── design.md     # 技術方針・データフロー（コードなし）
    ├── tasks.md      # DB / API / フロント / テストに分割したTODO
    └── specs/
        └── user/
            └── spec.md   # 差分仕様（delta）
```

---

### `docs/` — 日本語設計書・ドキュメント

Claude に設計書を書かせる・レビューするための人間向けドキュメント置き場。

| ファイル/ディレクトリ | 役割 |
|---|---|
| `design-templates/` | 基本設計書・詳細設計書のMarkdownテンプレート。Claudeへの指示時に参照させる |
| `design-prompt-templates.md` | 設計書生成パターン別のプロンプト集。コピペしてClaudeに渡して使う |
| `design-review-checklist.md` | 生成された設計書をレビューするためのチェック項目一覧 |
| `examples/` | 言語依存のサンプルコードを置く場所。spec内からはパスでリンクするのみ |

---

### `CLAUDE.md` — プロジェクト全体のルール

Claude Code がプロジェクトを開いたとき自動で読み込まれるルールファイル。
「このリポジトリでClaudeを使うときの共通前提」として機能する。

---

### `.claude/` — Claude Code 設定

| ファイル/ディレクトリ | 役割 |
|---|---|
| `settings.json` | Claude Code のプロジェクト設定 |
| `commands/opsx/` | `/opsx:new`・`/opsx:continue`・`/opsx:apply`・`/opsx:archive` 等のスラッシュコマンド群（`openspec init --tools claude` で自動生成） |
| `skills/` | OpenSpec スキル群（コマンドの実体となる詳細な指示ファイル。`openspec init` で自動生成） |
| `rules/design-doc.md` | `docs/design/**/*.md` に対してのみ適用されるルール（mermaid図必須、コード禁止など） |
| `rules/code-in-docs.md` | `docs/**/*.md` 全体に対してコード混入を防ぐルール |

> `.claude/rules/` 以下のファイルは、対象ファイルのパスに応じて動的に読み込まれる。
> 「設計書ファイルだけ厳しめルール」のような条件付き適用が可能。
>
> `commands/opsx/` と `skills/` は `openspec init --tools claude` を実行すると自動生成される。
> 手動で編集した場合は `openspec update` で更新を確認すること。

---

## upstream 同期

本リポジトリは外部リポジトリ(upstream)の変更を定期的に取り込む運用をしている。
以下の4ディレクトリは社内固有の作業実績のため、**upstream の変更で上書きしない**。

- `dev-process-improvement/backlog/`
- `dev-process-improvement/inbox/`
- `dev-process-improvement/initiatives/`
- `dev-process-improvement/triage/`

同期手順・Claude への依頼方法: **[docs/sync-guide.md](docs/sync-guide.md)**

---

## セットアップ

開発を始める前に、必要なツールが揃っているか確認してください。

- **セットアップガイド**: [docs/dev-setup.md](docs/dev-setup.md)

```bash
# セットアップ確認スクリプトを実行
bash scripts/setup.sh
```

---

## 開発フロー（概要）

```
1. /opsx:new <feature>   → openspec/changes/<feature>/ を自動作成
2. /opsx:continue × 4   → proposal → specs → design → tasks を順に生成
3. /opsx:apply           → tasks.md に従い Claude が src/ 以下を実装
4. /opsx:archive         → changes/.../specs/ の delta を openspec/specs/ にマージ
5. openspec/specs/ が常に最新状態の仕様になる
```

> コマンドとスキルは `openspec init --tools claude` で `.claude/` 以下に自動生成される。
> 初回セットアップは `npm install -g @fission-ai/openspec` を実行してから `openspec init` を使うこと。
