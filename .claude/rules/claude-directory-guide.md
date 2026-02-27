# Claude Code 標準ディレクトリ構成ガイド

このドキュメントは Claude Code の `.claude/` ディレクトリおよび関連ファイルの標準構成をまとめたものである。
新規プロジェクトへの展開時や、既存プロジェクトの構成見直し時の参照資料として利用する。

> **情報源**: [Claude Code Settings](https://code.claude.com/docs/en/settings) / [Manage Claude's memory](https://code.claude.com/docs/en/memory) / [Extend Claude with skills](https://code.claude.com/docs/en/skills) / [Create custom subagents](https://code.claude.com/docs/en/sub-agents) / [Extend Claude Code](https://code.claude.com/docs/en/features-overview) / [Hooks reference](https://code.claude.com/docs/en/hooks) (2026-02 時点)

---

## 1. 標準ディレクトリ構成の全体像

### 1.1 プロジェクトレベル（リポジトリルート）

```
<project-root>/
├── CLAUDE.md                  # プロジェクトメモリ（チーム共有、git 管理）
├── CLAUDE.local.md            # 個人プロジェクト指示（gitignored、自動追加）
├── .mcp.json                  # プロジェクトスコープ MCP サーバー設定
└── .claude/
    ├── settings.json          # チーム共有設定（git 管理）
    ├── settings.local.json    # 個人プロジェクトオーバーライド（gitignored）
    ├── CLAUDE.md              # プロジェクトメモリ（ルート CLAUDE.md と等価。どちらか一方で可）
    ├── rules/                 # モジュラールール（トピック別の指示ファイル）
    │   └── *.md
    ├── commands/              # カスタムスラッシュコマンド（skills に統合済み、下位互換あり）
    │   └── *.md
    ├── skills/                # エージェントスキル（推奨拡張手段）
    │   └── <skill-name>/
    │       ├── SKILL.md
    │       └── supporting-files/
    ├── agents/                # カスタムサブエージェント
    │   └── *.md
    ├── hooks/                 # イベント駆動フック
    │   ├── scripts/
    │   └── config/
    └── plugins/               # インストール済みプラグイン
```

### 1.2 ユーザーレベル（グローバル設定）

```
~/.claude/
├── settings.json              # ユーザーレベル設定（全プロジェクト共通）
├── settings.local.json        # 個人オーバーライド
├── CLAUDE.md                  # ユーザーメモリ（全プロジェクト共通）
├── rules/                     # ユーザーレベルのモジュラールール
│   └── *.md
├── commands/                  # ユーザーレベルコマンド（skills に統合済み）
│   └── *.md
├── skills/                    # ユーザーレベルスキル
│   └── {skill-name}/SKILL.md
├── agents/                    # ユーザーサブエージェント
│   └── *.md
├── hooks/                     # ユーザーレベルフック
│   ├── scripts/
│   └── config/
├── tasks/                     # タスクリスト（グローバル専用）
│   └── {task-list-id}/
├── teams/                     # エージェントチーム設定（グローバル専用）
│   └── {team-name}/
│       └── config.json
├── projects/                  # プロジェクトごとの自動メモリ（グローバル専用）
│   └── {project-hash}/
│       └── memory/
│           ├── MEMORY.md
│           └── *.md
└── keybindings.json           # キーボードショートカット（グローバル専用）

~/.claude.json                 # MCP サーバー、OAuth、プリファレンス、キャッシュ（グローバル専用）
```

### 1.3 管理者レベル（Managed Settings）

組織全体のポリシーを強制する設定。ユーザー・プロジェクトレベルでオーバーライド不可。

| OS | managed-settings.json の配置場所 | CLAUDE.md の配置場所 |
|----|--------------------------------|---------------------|
| macOS | `/Library/Application Support/ClaudeCode/managed-settings.json` | `/Library/Application Support/ClaudeCode/CLAUDE.md` |
| Linux / WSL | `/etc/claude-code/managed-settings.json` | `/etc/claude-code/CLAUDE.md` |
| Windows | `C:\Program Files\ClaudeCode\managed-settings.json` | - |

Managed tier 内の優先順位（高い順）: サーバー管理 > MDM/OS レベルポリシー > managed-settings.json > HKCU レジストリ (Windows のみ)。ただし、**1つのソースのみ使用され、複数ソースはマージされない**。

---

## 2. 各ディレクトリ・ファイルの役割

### 2.1 CLAUDE.md — プロジェクトメモリ

セッション開始時に Claude が読み込む指示・コンテキストファイル。

| メモリ種別 | 配置場所 | 共有範囲 | 用途 |
|-----------|---------|---------|------|
| Managed policy | OS 管理パス（上表参照） | 組織全員 | 組織全体の指示 |
| Project memory | `./CLAUDE.md` または `./.claude/CLAUDE.md` | チーム（git 管理） | プロジェクト共通の指示・慣習 |
| Project rules | `./.claude/rules/*.md` | チーム（git 管理） | トピック別のモジュラー指示 |
| User memory | `~/.claude/CLAUDE.md` | 自分のみ | 全プロジェクト共通の個人設定 |
| Project local | `./CLAUDE.local.md` | 自分のみ（gitignored） | プロジェクト固有の個人設定 |
| Auto memory | `~/.claude/projects/<hash>/memory/` | 自分のみ | Claude の自動メモ・学習 |

**読み込み動作**:
- ディレクトリ階層を再帰的に上方向にたどり、見つかった CLAUDE.md を全て読み込む
- 子ディレクトリの CLAUDE.md はそのディレクトリ内のファイルにアクセスした時にオンデマンドで読み込まれる
- `@path/to/import` 構文で外部ファイルのインポートが可能（最大5ホップ再帰）
- CLAUDE.local.md は自動的に .gitignore に追加される
- 追加ディレクトリ（`--add-dir` 指定）の CLAUDE.md は、環境変数 `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` を設定した場合のみ読み込まれる

**ベストプラクティス**:
- CLAUDE.md は約500行以内に保つ。参照資料は skills に移動してオンデマンド読み込みにする
- 「常に守るべきルール」を CLAUDE.md に、「必要時に参照する知識」を skills に配置する

### 2.2 rules/ — モジュラールール

`.claude/rules/*.md` に配置するトピック別の指示ファイル。CLAUDE.md の分割管理手段。

- 全ての `.md` ファイルが**自動読み込み**される（セッション開始時に全文読み込み）
- サブディレクトリによる整理が可能（再帰的に検出）
- シンボリックリンクをサポート（プロジェクト間でルールを共有可能）
- `paths:` YAML フロントマターによるパス固有ルールをサポート

```yaml
---
paths: "src/api/**/*.ts"
---
# API コーディングルール
- REST API のエンドポイントは...
```

- ユーザーレベルルール（`~/.claude/rules/`）はプロジェクトルールより低い優先度

### 2.3 commands/ — カスタムスラッシュコマンド ※ skills に統合済み

`.claude/commands/*.md` に Markdown 形式で定義するスラッシュコマンド。

- **公式では skills への移行が推奨**されている
- 既存の commands は引き続き動作する（下位互換あり）
- 同名の skill と command がある場合は skill が優先

### 2.4 skills/ — エージェントスキル

`.claude/skills/<skill-name>/SKILL.md` に配置。Claude の能力を拡張する最も柔軟な仕組み。Agent Skills オープンスタンダード準拠（OpenAI Codex CLI と互換）。

**SKILL.md の構造**: YAML フロントマター + Markdown コンテンツ

```yaml
---
name: deploy-workflow
description: 'デプロイワークフローを実行する'
disable-model-invocation: false
user-invocable: true
allowed-tools: ["Bash"]
context: fork
agent: deploy-agent
---
# デプロイ手順
1. テストを実行する
2. ビルドを実行する
...
```

**主要フロントマターフィールド**:

| フィールド | 説明 |
|-----------|------|
| `name` | スキル名（ディレクトリ名と一致必須、`/` コマンド名になる） |
| `description` | 説明（Claude が自動起動の判断に使用。セッション開始時に読み込まれる） |
| `disable-model-invocation` | `true` でユーザー手動呼び出しのみ（コンテキストコスト削減） |
| `user-invocable` | `false` で `/` メニューに非表示（Claude 自動呼び出しのみ） |
| `allowed-tools` | スキル実行中に使用可能なツール制限 |
| `model` | 使用モデル |
| `context` | `fork` でサブエージェントコンテキストで実行 |
| `agent` | `context: fork` 時のサブエージェント指定 |
| `hooks` | スキルスコープのフック |

**優先順位**: managed > user (`~/.claude/skills/`) > project (`.claude/skills/`)

**補足**:
- 補助ファイル（テンプレート・スクリプト・リファレンス）をスキルディレクトリ内に配置可能
- `$ARGUMENTS`、`$0`、`$1` 等の引数置換をサポート
- `` !`command` `` 構文で動的コンテキスト注入が可能
- プラグインスキルは `/<plugin-name>:<skill-name>` の名前空間を持つ

### 2.5 agents/ — カスタムサブエージェント

`.claude/agents/*.md` に配置。独立したコンテキストウィンドウで動作する専門ワーカー。

```yaml
---
name: security-reviewer
description: 'セキュリティ観点でコードレビューを行う'
tools: ["Read", "Grep", "Glob"]
model: opus
skills:
  - security-guidelines
---
# セキュリティレビュワー
あなたはセキュリティ専門のコードレビュワーです。
...
```

- プロジェクトエージェント（`.claude/agents/`）はユーザーレベル（`~/.claude/agents/`）より優先
- 各サブエージェントは独立したコンテキストウィンドウを持つ
- skills をプリロードできる（`skills:` フィールド）。サブエージェントはメインセッションの skills を継承しない
- `tools` フィールドで使用可能ツールを制限可能
- 優先順位: managed > CLI flag > project > user > plugin

### 2.6 hooks/ — イベント駆動フック

LLM を介さずにイベント駆動で実行される決定論的スクリプト。

| フックイベント | 説明 | 用途例 |
|-------------|------|-------|
| `PreToolUse` | ツール実行前 | 危険操作のブロック、入力の自動修正 |
| `PostToolUse` | ツール実行後 | 自動フォーマット、テスト実行、ログ記録 |
| `Notification` | 通知時 | 外部通知連携 |
| `Stop` | セッション停止時 | クリーンアップ処理 |
| `SessionStart` | セッション開始時 | 環境初期化 |
| `UserPromptSubmit` | ユーザープロンプト送信時 | 入力の前処理 |

- `settings.json` 内の `hooks` オブジェクト、または `.claude/hooks/` ディレクトリで設定
- マッチャーでトリガー対象ツールをフィルタ可能（例: `Write|Edit`）
- **全ソースのフックがマージされて発火**する（settings.json / user / project / plugin の全てが対象）
- コンテキストコストはゼロ（外部スクリプトとして実行、フックの出力がコンテキストに追加されない限り）

### 2.7 settings.json — 設定ファイル

#### JSON Schema バリデーション

`$schema` を設定すると、VS Code / Cursor 等のエディタで自動補完とバリデーションが有効になる。

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json"
}
```

#### 主要設定項目

| カテゴリ | 設定キー | 説明 |
|---------|---------|------|
| **パーミッション** | `permissions.allow` / `.deny` / `.ask` | ツール/パターンの許可・拒否・確認 |
| | `permissions.additionalDirectories` | 追加ディレクトリアクセス |
| | `permissions.defaultMode` | デフォルト権限モード |
| | `permissions.disableBypassPermissionsMode` | `--dangerously-skip-permissions` の無効化（managed only） |
| **モデル** | `model` | 使用モデルティア（`opus` / `sonnet` / `haiku`） |
| | `availableModels` | 利用可能モデルリスト |
| | `alwaysThinkingEnabled` | 常時思考モード |
| **環境変数** | `env` | セッションに適用する環境変数（キー/値オブジェクト） |
| **UI** | `language` | 応答言語（例: `"japanese"`） |
| | `outputStyle` | 出力スタイル（例: `"Explanatory"`） |
| | `spinnerTipsEnabled` | スピナーチップスの有効/無効 |
| **MCP** | `enableAllProjectMcpServers` | プロジェクト MCP 全有効化 |
| | `enabledMcpjsonServers` / `disabledMcpjsonServers` | MCP サーバーの有効/無効リスト |
| **Git 属性** | `attribution.commit` / `.pr` | コミット・PR の帰属表示（空文字で非表示） |
| **サンドボックス** | `sandbox.enabled` | Bash コマンドのサンドボックス化 |
| | `sandbox.network.allowedDomains` | 許可ドメイン |
| | `sandbox.autoAllowBashIfSandboxed` | サンドボックス時の Bash 自動許可 |
| **自動メモリ** | `autoMemoryEnabled` | 自動メモリ有効化 |
| **フック** | `hooks.*` | フック設定（PreToolUse, PostToolUse 等） |
| **ファイル** | `fileSuggestion` | `@` 自動補完のカスタマイズ |
| | `respectGitignore` | gitignore ファイルの除外 |
| **プラン** | `plansDirectory` | プランファイルの保存先 |
| **クリーンアップ** | `cleanupPeriodDays` | セッションクリーンアップ間隔 |

#### パーミッションルール構文

`Tool` または `Tool(specifier)` 形式。ワイルドカード `*` / `**` 対応。

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)"
    ],
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)"
    ],
    "ask": [
      "Bash(git push *)"
    ]
  }
}
```

**評価順序**: deny -> ask -> allow（最初にマッチしたルールが適用）

### 2.8 plugins/ — プラグイン

skills、hooks、subagents、MCP サーバーをバンドルした配布可能なパッケージ。Claude Code が自動管理する。
プラグインスキルは `/<plugin-name>:<skill-name>` の名前空間を持ち、複数プラグインが共存可能。

### 2.9 .mcp.json — MCP サーバー設定

リポジトリルートに配置するプロジェクトスコープの Model Context Protocol サーバー設定。
MCP の優先順位: local > project > user。

---

## 3. 設定の優先順位

### 3.1 settings.json の優先順位（高い順）

| 優先度 | スコープ | 配置場所 | 共有範囲 |
|--------|---------|---------|---------|
| 1（最高） | Managed | サーバー管理/MDM/OS レベルポリシー/managed-settings.json | 組織全体（オーバーライド不可） |
| 2 | CLI 引数 | `--allowedTools` 等のコマンドライン引数 | 現セッションのみ |
| 3 | Local | `.claude/settings.local.json` | 個人（gitignored） |
| 4 | Project | `.claude/settings.json` | チーム（git 管理） |
| 5（最低） | User | `~/.claude/settings.json` | 個人（全プロジェクト） |

**パーミッションルールの評価順序**: deny -> ask -> allow（最初にマッチしたルールが適用）

### 3.2 CLAUDE.md / メモリの優先順位

より具体的（スコープが狭い）指示が、より広範な指示に優先する。

| 優先度 | 種別 | 説明 |
|--------|------|------|
| 1（最高） | Managed policy | 組織全体（オーバーライド不可） |
| 2 | Project local | `CLAUDE.local.md`（個人プロジェクト固有） |
| 3 | Project memory/rules | `CLAUDE.md` + `.claude/rules/*.md`（チーム共有） |
| 4 | User memory | `~/.claude/CLAUDE.md`（個人全プロジェクト共通） |
| 5（最低） | Auto memory | 自動メモ |

CLAUDE.md は全レベルが**加算的**に読み込まれる。矛盾する指示がある場合、Claude はより具体的な指示を優先する判断を行う。

### 3.3 各拡張機能の優先順位と衝突時の動作

| 拡張機能 | 優先順位（高い順） | 衝突時の動作 |
|---------|-----------------|-------------|
| **skills** | managed > user > project | 同名は高優先度が勝つ |
| **agents** | managed > CLI flag > project > user > plugin | 同名は高優先度が勝つ |
| **MCP** | local > project > user | 同名は高優先度が勝つ |
| **hooks** | 全ソースがマージ | マッチするイベント全てが発火（オーバーライドなし） |
| **CLAUDE.md** | 全レベルが加算的 | 矛盾時はより具体的な指示が優先 |

---

## 4. 本リポジトリの現状構成との差異と改善方針

### 4.1 現状構成

```
.claude/
├── settings.json              # コメントのみの空設定（JSONC 形式）
├── commands/
│   └── opsx/                  # OpenSpec カスタムコマンド（10ファイル）
├── rules/
│   ├── claude-directory-guide.md   # 本ドキュメント
│   ├── code-in-docs.md
│   ├── design-doc.md
│   ├── role-format-guide.md
│   └── sync.md
├── skills/
│   └── openspec-*/SKILL.md    # OpenSpec スキル（10スキル）
└── （agents/, hooks/, plugins/ は未作成）

CLAUDE.md                      # プロジェクトメモリ（ルート）
```

また `dev-process-improvement/.claude/rules/` に4つのロール定義ファイル（l1-manager.md, l2-worker.md, l2-evaluator.md, triage.md）、リポジトリルートの `roles/` ディレクトリに7つのロール定義がある。

### 4.2 差異分析

#### 標準にあるが本リポジトリにないもの

| 構成要素 | 影響度 | 説明 |
|---------|--------|------|
| `.claude/agents/` | **中** | CLAUDE.md にサブエージェント戦略の記載あり。agents/ で体系的に管理可能 |
| `.claude/hooks/` | 低 | フック自動化のニーズが明確でなければ不要 |
| `.claude/plugins/` | 低 | プラグイン利用時に自動生成される |
| `CLAUDE.local.md` | 低 | 個人設定が必要な場合に各自が作成 |
| `.claude/settings.local.json` | 低 | 個人設定が必要な場合に各自が作成 |
| `.mcp.json` | 低 | MCP サーバーを利用する場合に追加 |

#### 本リポジトリにあるが標準と異なるもの

| 現状 | 差異の内容 | 対応方針 |
|------|-----------|---------|
| `commands/opsx/*.md` | commands は skills に統合済み。skills が推奨 | `skills/openspec-*` として skills 化済み。中長期的に commands を廃止し skills に一本化 |
| `settings.json` が JSONC 形式 | 公式は純粋な JSON を使用。`$schema` も未設定 | 正式な JSON に修正し、`$schema` と有効な設定項目を追加すべき |
| `rules/` に `paths:` 未使用 | 対象パスが明確なルールに paths を設定すればコンテキスト効率が向上 | code-in-docs.md、design-doc.md に paths フロントマター追加を検討 |

### 4.3 改善方針（優先度順）

1. **settings.json の充実**（短期）: `$schema` の追加、パーミッション deny ルール（`.env` 等の機密ファイル排除）、頻用コマンドの allow ルールを追加。JSONC からの脱却
2. **rules/ の paths 活用**（短期）: 対象パスが明確なルール（code-in-docs.md → `docs/**/*.md`、design-doc.md → `docs/design/**/*.md`）に `paths:` フロントマターを設定
3. **agents/ ディレクトリの検討**（中期）: CLAUDE.md にサブエージェント戦略が明記されているため、`.claude/agents/` での管理体制への移行を検討
4. **commands/ から skills/ への段階的移行**（中期）: `commands/opsx/` は下位互換で動作するが、将来的に skills に統一
5. **hooks/ の導入**（低優先度）: 明確な自動化ニーズ（自動フォーマット、危険操作ブロック等）が発生した場合に導入

---

## 5. 新規プロジェクトへの展開時の推奨構成

### 5.1 最小構成（Starter）

まずはこの構成から始める。

```
<project-root>/
├── CLAUDE.md              # プロジェクトの概要・頻用コマンド・コーディング規約
└── .claude/
    └── settings.json      # 基本的な権限ルール
```

**CLAUDE.md に含めるべき内容**:
- プロジェクトの概要（技術スタック、ディレクトリ構成）
- 頻用コマンド（ビルド、テスト、リント）
- コーディング規約・命名規則
- 重要なアーキテクチャ上の決定事項

**settings.json の最小設定例**:
```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)"
    ]
  }
}
```

### 5.2 標準構成（Standard）

チーム開発が本格化したら拡張する。

```
<project-root>/
├── CLAUDE.md
├── .mcp.json                  # 外部サービス連携がある場合
└── .claude/
    ├── settings.json
    ├── rules/                 # トピック別ルール（CLAUDE.md が100行超なら分割）
    │   ├── coding-style.md
    │   └── testing.md
    └── skills/                # 再利用可能なワークフロー
        └── deploy/
            └── SKILL.md
```

### 5.3 フル構成（Advanced）

スキル・エージェント・フックを活用する成熟したプロジェクト向け。

```
<project-root>/
├── CLAUDE.md
├── CLAUDE.local.md            # 個人設定（gitignored）
├── .mcp.json
└── .claude/
    ├── settings.json          # チーム共有パーミッション・環境変数
    ├── settings.local.json    # 個人オーバーライド（gitignored）
    ├── rules/                 # モジュラールール（paths 活用、サブディレクトリで整理）
    │   ├── frontend/
    │   ├── backend/
    │   └── *.md
    ├── skills/                # プロジェクト固有スキル
    │   └── {skill-name}/
    │       └── SKILL.md
    ├── agents/                # 専門サブエージェント
    │   ├── security-reviewer.md
    │   └── test-writer.md
    └── hooks/                 # 自動化フック
        └── scripts/
```

### 5.4 展開時のチェックリスト

- [ ] CLAUDE.md に技術スタック・頻用コマンド・主要規約を記載（500行以内目標）
- [ ] settings.json に `$schema` と機密ファイルの deny ルールを設定
- [ ] CLAUDE.md が100行超になったら rules/ への分割を検討
- [ ] 繰り返しのワークフローがあれば skills/ でスキル化
- [ ] サブエージェントによるタスク分離が有効なら agents/ を導入
- [ ] CLAUDE.local.md と settings.local.json の存在をチームに周知

### 5.5 コンテキストコストの考慮

拡張機能はそれぞれ異なるタイミングでコンテキストに読み込まれる。過剰な読み込みはコンテキストウィンドウを圧迫し、Claude の精度低下を招く。

| 拡張機能 | 読み込みタイミング | コンテキストコスト |
|---------|-----------------|-----------------|
| CLAUDE.md | セッション開始時 | **毎リクエスト（常時）** |
| rules/ | セッション開始時 | **毎リクエスト（常時）** |
| skills | 開始時は description のみ、使用時に全文 | 低（description のみ常時、全文はオンデマンド） |
| MCP | セッション開始時 | 毎リクエスト（ツール定義 + JSON Schema） |
| agents | 起動時に独立コンテキスト | **メインセッションから分離**（コスト影響なし） |
| hooks | イベント発火時 | **ゼロ**（外部スクリプト実行） |

**ポイント**:
- CLAUDE.md と rules/ は常時読み込まれるため、**合計約500行以内**に保つことが推奨
- 参照資料は skills に移動してオンデマンド読み込みにする
- 大量のファイル読み込みが必要なタスクはサブエージェントに委譲し、メインコンテキストを汚染しない
- `disable-model-invocation: true` を設定したスキルはコンテキストコストがゼロ（手動呼び出し時のみ読み込み）

---

## 参考: 公式ドキュメント

- [Claude Code Settings](https://code.claude.com/docs/en/settings)
- [Manage Claude's memory](https://code.claude.com/docs/en/memory)
- [Extend Claude with skills](https://code.claude.com/docs/en/skills)
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Extend Claude Code (features overview)](https://code.claude.com/docs/en/features-overview)
- [Configure permissions](https://code.claude.com/docs/en/permissions)
- [Hooks reference](https://code.claude.com/docs/en/hooks)
- [Best Practices](https://code.claude.com/docs/en/best-practices)

---

**作成日**: 2026-02-27
**情報源**: Claude Code 公式ドキュメント (code.claude.com/docs/en/) 2026-02 時点
