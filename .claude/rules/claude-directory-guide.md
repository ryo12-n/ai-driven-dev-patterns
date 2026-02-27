# Claude Code ディレクトリ構成ガイド

このドキュメントは Claude Code のディレクトリ構成・設定体系を整理し、本リポジトリでの運用方針を定めるものである。

---

## 1. 標準ディレクトリ構成の全体像

### グローバル設定（`~/.claude/`）

ユーザー個人の全プロジェクト共通設定。マシン固有であり git 管理しない。

```
~/.claude/
├── settings.json          # ユーザーレベル設定
├── settings.local.json    # 個人オーバーライド
├── CLAUDE.md              # ユーザーメモリ（全プロジェクト共通の指示）
├── agents/                # ユーザーサブエージェント
│   └── *.md
├── rules/                 # ユーザーレベルのモジュラールール
│   └── *.md
├── commands/              # ユーザーレベルコマンド（skills に統合済み）
│   └── *.md
├── skills/                # ユーザーレベルスキル
│   └── {skill-name}/SKILL.md
├── tasks/                 # タスクリスト（グローバル専用）
├── teams/                 # エージェントチーム設定（グローバル専用）
├── projects/              # プロジェクト別自動メモリ（グローバル専用）
│   └── {project-hash}/memory/
│       ├── MEMORY.md
│       └── *.md
├── keybindings.json       # キーボードショートカット（グローバル専用）
└── hooks/                 # ユーザーレベルフック

~/.claude.json             # MCPサーバー、OAuth、プリファレンス（グローバル専用）
```

### プロジェクト設定（`.claude/`）

プロジェクト固有の設定。チーム共有するファイルは git 管理する。

```
<project-root>/
├── CLAUDE.md              # プロジェクトメモリ（チーム共有の指示）
├── CLAUDE.local.md        # 個人プロジェクト固有指示（gitignored）
├── .claude/
│   ├── settings.json      # チーム共有設定（権限ルール等）
│   ├── settings.local.json # 個人プロジェクトオーバーライド（gitignored）
│   ├── CLAUDE.md          # .claude/ 内のプロジェクトメモリ（ルート CLAUDE.md と等価）
│   ├── agents/            # プロジェクトサブエージェント
│   │   └── *.md
│   ├── rules/             # モジュラールール（トピック別指示）
│   │   └── *.md
│   ├── commands/          # カスタムスラッシュコマンド（skills に統合済み）
│   │   └── *.md
│   ├── skills/            # カスタムスキル
│   │   └── {skill-name}/
│   │       ├── SKILL.md
│   │       └── supporting-files/
│   ├── hooks/             # プロジェクトレベルフック
│   │   ├── scripts/
│   │   └── config/
│   └── plugins/           # インストール済みプラグイン
└── .mcp.json              # プロジェクトスコープ MCP サーバー設定
```

---

## 2. 各ディレクトリ・ファイルの役割説明

### CLAUDE.md（メモリファイル）

セッション開始時に Claude が読み込む指示・コンテキストファイル。

| 種別 | 配置場所 | 目的 | 共有範囲 |
|------|---------|------|---------|
| Managed policy | OS 管理パス（`/etc/claude-code/CLAUDE.md` 等） | 組織全体の指示（IT/DevOps が管理） | 組織全員 |
| Project memory | `./CLAUDE.md` or `./.claude/CLAUDE.md` | チーム共有のプロジェクト指示 | チームメンバー（git 経由） |
| Project rules | `./.claude/rules/*.md` | トピック別のモジュラー指示 | チームメンバー（git 経由） |
| User memory | `~/.claude/CLAUDE.md` | 個人の全プロジェクト共通設定 | 自分のみ |
| Project local | `./CLAUDE.local.md` | 個人のプロジェクト固有設定 | 自分のみ（gitignored） |
| Auto memory | `~/.claude/projects/<project>/memory/` | Claude の自動メモ・学習 | 自分のみ |

**読み込みルール**:
- cwd から上方向に再帰的にたどり、見つかった CLAUDE.md を全て読み込む
- 子ディレクトリの CLAUDE.md はオンデマンド読み込み（該当ファイルアクセス時）
- `@path/to/import` 構文で外部ファイルのインポートが可能（最大5ホップ）
- Auto memory は `MEMORY.md` の先頭200行のみをセッション開始時に読み込み

### settings.json（権限・動作設定）

Claude の動作権限とツールアクセスを制御する JSON ファイル。

**主要設定項目**:
- `permissions.allow` / `permissions.deny` / `permissions.ask` — ツール権限ルール
- `permissions.additionalDirectories` — 追加ディレクトリアクセス許可
- `permissions.defaultMode` — デフォルト権限モード
- `model` / `availableModels` — 使用モデル設定
- `env` — 環境変数
- `hooks` — イベント駆動フック設定
- `sandbox` — サンドボックス設定
- `attribution` — Git コミット/PR の属性表示
- `autoMemoryEnabled` — 自動メモリの有効/無効

### rules/（モジュラールール）

CLAUDE.md を分割してトピック別に管理するためのディレクトリ。

- `.claude/rules/*.md` に配置。全ての `.md` ファイルが自動読み込みされる
- サブディレクトリによる整理が可能（再帰的に検出される）
- YAML フロントマター `paths:` によるパス固有ルールをサポート
  ```yaml
  ---
  paths:
    - 'src/api/**/*.ts'
  ---
  # このルールは src/api/ 配下の TypeScript ファイル操作時のみ適用
  ```
- シンボリックリンクをサポート（プロジェクト間でルールを共有可能）
- ユーザーレベルルール（`~/.claude/rules/`）はプロジェクトルールより低い優先度

### skills/（スキル）

Claude の能力を拡張するためのモジュラーパッケージ。Agent Skills オープンスタンダード準拠。

- `.claude/skills/{skill-name}/SKILL.md` に配置
- YAML フロントマター + Markdown コンテンツで構成
- 主要フロントマターフィールド:
  - `name` — スキル名（ディレクトリ名と一致必須、`/` コマンド名になる）
  - `description` — 説明（Claude が自動起動の判断に使用、推奨）
  - `disable-model-invocation` — `true` でユーザー手動呼び出しのみに制限
  - `user-invocable` — `false` で `/` メニューに非表示
  - `allowed-tools` — スキル実行中に使用可能なツール
  - `context` — `fork` でサブエージェント内実行
  - `agent` — `context: fork` 時のサブエージェント指定
- 補助ファイル（テンプレート・スクリプト・リファレンス）をスキルディレクトリ内に配置可能
- `$ARGUMENTS`、`$0`、`$1` 等の引数置換をサポート
- `` !`command` `` 構文で動的コンテキスト注入が可能

### commands/（カスタムコマンド） ※ skills に統合済み

- `.claude/commands/*.md` に配置するスラッシュコマンド定義
- **公式では skills への移行が推奨**されている
- 既存の commands ファイルは引き続き動作する
- 同名の skill と command がある場合は skill が優先

### agents/（サブエージェント）

特化型の独立エージェントを定義するディレクトリ。

- `.claude/agents/*.md` に配置
- YAML フロントマター（`name`, `description`, `tools`, `model`）+ Markdown（システムプロンプト）
- 各サブエージェントは独立したコンテキストウィンドウを持つ
- `tools` フィールドで使用可能ツールを制限可能
- プロジェクトエージェント（`.claude/agents/`）はユーザーレベル（`~/.claude/agents/`）より優先

### hooks/（イベント駆動フック）

ツール実行前後に自動処理を挟むための仕組み。

- `settings.json` 内の `hooks` オブジェクト、または `.claude/hooks/` ディレクトリで設定
- 主要イベント: `PreToolUse`（実行前検証）、`PostToolUse`（実行後処理）、`Stop`、`Notification`、`SessionStart`、`UserPromptSubmit`
- PreToolUse: 危険操作のブロック、入力の自動修正に使用
- PostToolUse: 自動フォーマット、テスト実行、ログ記録に使用
- マッチャーでトリガー対象ツールをフィルタ可能（例: `Write|Edit`）

### plugins/（プラグイン）

外部から提供される拡張パッケージのインストール先。Claude Code が自動管理する。

### .mcp.json（MCP サーバー設定）

プロジェクトスコープの Model Context Protocol サーバー設定。リポジトリルートに配置。

---

## 3. 設定の優先順位

### settings.json の優先順位（高い順）

| 優先度 | スコープ | 配置場所 | 共有範囲 |
|--------|---------|---------|---------|
| 1（最高） | Managed | サーバー管理/MDM/OS レベルポリシー | 組織全体（オーバーライド不可） |
| 2 | Command line | CLI 引数（`--allowedTools` 等） | 現セッションのみ |
| 3 | Local | `.claude/settings.local.json` | 個人（gitignored） |
| 4 | Project | `.claude/settings.json` | チーム（git 管理） |
| 5（最低） | User | `~/.claude/settings.json` | 個人（全プロジェクト） |

**パーミッションルールの評価順序**: deny が最優先 → ask → allow（最初にマッチしたルールが適用）

### CLAUDE.md / メモリの優先順位

- より具体的（スコープが狭い）指示が、より広範な指示に優先する
- Managed policy > Project memory/rules > User memory
- 子ディレクトリの CLAUDE.md は親ディレクトリの CLAUDE.md を上書きできる
- ユーザーレベルルール（`~/.claude/rules/`）はプロジェクトルール（`.claude/rules/`）より低い優先度

### スキル・エージェントの優先順位

- スキル: enterprise > personal（`~/.claude/skills/`） > project（`.claude/skills/`）
- エージェント: project（`.claude/agents/`） > user（`~/.claude/agents/`）

---

## 4. 本リポジトリの現状構成との差異と改善方針

### 現状構成

```
.claude/
├── commands/opsx/         # OpenSpec カスタムコマンド（10ファイル）
├── rules/                 # モジュラールール（4ファイル）
│   ├── code-in-docs.md
│   ├── design-doc.md
│   ├── role-format-guide.md
│   └── sync.md
├── settings.json          # 設定ファイル（コメントのみ、実質空）
└── skills/                # OpenSpec スキル（10スキル）
    └── openspec-*/SKILL.md

CLAUDE.md                  # プロジェクトメモリ（ルート、約115行）
```

### 差異と改善方針

| 項目 | 現状 | 推奨 | 対応方針 |
|------|------|------|---------|
| settings.json | コメントのみの空設定 | 権限ルール（deny で機密ファイル排除等）を設定 | 短期: 基本的な deny/allow ルールを追加 |
| agents/ | 未作成 | CLAUDE.md にサブエージェント戦略の記載あり | 中期: 汎用サブエージェント定義を検討 |
| commands/ と skills/ の並存 | 同等機能が両方に存在 | skills に一本化（公式推奨） | 中期: commands を段階的に廃止し skills に統一 |
| rules/ の paths 未活用 | paths フロントマターなし | 対象パスが明確なルールには paths を設定 | 短期: code-in-docs.md, design-doc.md に paths 追加を検討 |
| hooks/ | 未作成 | フォーマッタ自動実行等のニーズがあれば導入 | 低優先: 明確なニーズ発生時に導入 |
| .mcp.json | 未作成 | MCP サーバー利用時に追加 | 低優先: 必要時に対応 |
| CLAUDE.local.md | 未作成 | 個人設定が必要なメンバーが各自作成 | 情報周知のみ |

---

## 5. 新規プロジェクトへの展開時の推奨構成

新規プロジェクトで Claude Code を導入する際の最小推奨構成と段階的な拡張パスを示す。

### 最小構成（Starter）

まずはこの構成から始める。

```
<project-root>/
├── CLAUDE.md              # プロジェクトの概要・アーキテクチャ・頻用コマンド・コーディング規約
└── .claude/
    └── settings.json      # 基本的な権限ルール（deny で機密ファイル排除）
```

**CLAUDE.md に含めるべき内容**:
- プロジェクトの概要（技術スタック、ディレクトリ構成）
- 頻用コマンド（ビルド、テスト、リント）
- コーディング規約・命名規則
- 重要なアーキテクチャ上の決定事項

**settings.json の最小設定例**:
```json
{
  "permissions": {
    "deny": [
      "Read(**/.env)",
      "Read(**/.env.*)",
      "Read(**/secrets/**)"
    ]
  }
}
```

### 標準構成（Standard）

チーム開発が本格化したら拡張する。

```
<project-root>/
├── CLAUDE.md
└── .claude/
    ├── settings.json
    └── rules/
        ├── code-style.md      # コーディングスタイル規約
        ├── testing.md         # テスト規約
        └── {domain}.md        # ドメイン固有ルール
```

CLAUDE.md が100行を超えたら、トピック別に `.claude/rules/` へ分割する。

### フル構成（Advanced）

スキル・エージェント・フックを活用する成熟したプロジェクト向け。

```
<project-root>/
├── CLAUDE.md
├── CLAUDE.local.md        # 個人設定（gitignored）
├── .mcp.json              # MCP サーバー設定
└── .claude/
    ├── settings.json
    ├── settings.local.json # 個人権限オーバーライド（gitignored）
    ├── agents/             # プロジェクト固有サブエージェント
    │   └── *.md
    ├── rules/              # モジュラールール（paths 活用）
    │   ├── frontend/
    │   ├── backend/
    │   └── *.md
    ├── skills/             # プロジェクト固有スキル
    │   └── {skill-name}/
    │       └── SKILL.md
    └── hooks/              # 自動化フック
        └── scripts/
```

### 展開時のチェックリスト

- [ ] CLAUDE.md に技術スタック・頻用コマンド・主要規約を記載
- [ ] settings.json で機密ファイルの deny ルールを設定
- [ ] CLAUDE.md が100行超になったら rules/ への分割を検討
- [ ] 繰り返しのワークフローがあれば skills/ でスキル化
- [ ] サブエージェントによるタスク分離が有効なら agents/ を導入
- [ ] CLAUDE.local.md と settings.local.json の存在をチームに周知

---

## 参考: 公式ドキュメント

- [Claude Code settings](https://code.claude.com/docs/en/settings)
- [Manage Claude's memory](https://code.claude.com/docs/en/memory)
- [Extend Claude with skills](https://code.claude.com/docs/en/skills)
- [Configure permissions](https://code.claude.com/docs/en/permissions)
- [Hooks reference](https://code.claude.com/docs/en/hooks)
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents)
