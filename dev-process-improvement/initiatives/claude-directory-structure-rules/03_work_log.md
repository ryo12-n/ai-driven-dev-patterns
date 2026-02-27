# 作業履歴: Claude標準ディレクトリ構成のルール化

## 壁打ちフェーズ [2026-02-27 10:00]

### 理解のサマリー
- タスクの目的: Claude Code 公式ドキュメントを調査し、標準ディレクトリ構成のルールドキュメント（`.claude/rules/claude-directory-guide.md`）を作成する。本リポジトリの現状構成との差異分析も含む。
- スコープ: フェーズ1の全タスク（T-001〜T-004）。Web調査・現状分析・ルールドキュメント作成・課題CSV転記まで。ディレクトリの実際の再配置は行わない。
- 完了条件:
  - T-001: 調査結果が03_work_logに整理、公式ドキュメントURLが記録されている
  - T-002: 差異分析結果が03_work_logに記載されている
  - T-003: `.claude/rules/claude-directory-guide.md` が存在し、5項目（ツリー図・役割説明・優先順位・差異と改善方針・推奨構成）が網羅されている
  - T-004: 07_issues.mdの課題にCSV転記判断が付いている
  - 04_work_report.md に作業レポートが作成されている

### 前提条件チェック
- [x] 依存タスクの完了状態: なし（フェーズ1の最初のタスク群）
- [x] 必要ツール・コマンドの利用可否: WebSearch ツール利用可能、確認済み
- [x] 環境の準備状況（ファイル・ディレクトリの存在等）: `.claude/` ディレクトリ存在確認済み。settings.json、rules/、commands/、skills/ が存在。

### 不明点・確認事項
なし

### L1 確認結果
確認事項なし：実施開始

---

## 実施計画サマリ

1. **T-001**: WebSearch ツールで Claude Code 公式ドキュメントを調査。調査対象は6項目（グローバル設定、プロジェクト設定、CLAUDE.md、rules/commands/skills/、settings.json、優先順位）。調査結果を本ログに整理。
2. **T-002**: 本リポジトリの `.claude/` 配下をツリー構造で棚卸し。T-001 の調査結果と照合して差異を3観点（標準にあるが本リポにないもの、本リポにあるが標準と異なるもの、改善推奨点）で分析。
3. **T-003**: T-001・T-002 の結果を基に `.claude/rules/claude-directory-guide.md` を日本語で作成。5項目を網羅。
4. **T-004**: 07_issues.md の未転記課題を確認し、CSV転記の要否を判断。

---

## 作業ログ

### [2026-02-27 10:10] タスクID: T-001
**状態**: 完了
**作業内容**:

WebSearch ツールおよび WebFetch ツールを使って Claude Code 公式ドキュメントを調査した。

#### 調査ソース

- [Claude Code settings - 公式ドキュメント](https://code.claude.com/docs/en/settings)
- [Manage Claude's memory - 公式ドキュメント](https://code.claude.com/docs/en/memory)
- [Extend Claude with skills - 公式ドキュメント](https://code.claude.com/docs/en/skills)
- [Configure permissions - 公式ドキュメント](https://code.claude.com/docs/en/permissions)
- [Hooks reference - 公式ドキュメント](https://code.claude.com/docs/en/hooks)
- [Create custom subagents - 公式ドキュメント](https://code.claude.com/docs/en/sub-agents)
- [Claude Code overview - 公式ドキュメント](https://code.claude.com/docs/en/overview)
- [Claude Code Rules Directory: Modular Instructions That Scale](https://claudefa.st/blog/guide/mechanics/rules-directory)
- [Claude Code Settings Reference](https://claudefa.st/blog/guide/settings-reference)
- [Inside Claude Code Skills: Structure, prompts, invocation](https://mikhail.io/2025/10/claude-code-skills/)

#### 調査結果

##### (1) `~/.claude/` グローバル設定の構成

```
~/.claude/
├── settings.json          # ユーザーレベル設定（全プロジェクト共通）
├── settings.local.json    # 個人オーバーライド
├── CLAUDE.md              # ユーザーメモリ（全プロジェクト共通）
├── agents/                # ユーザーサブエージェント（全プロジェクト利用可能）
│   └── *.md
├── rules/                 # ユーザーレベルのモジュラールール
│   └── *.md
├── commands/              # ユーザーレベルコマンド
│   └── *.md
├── skills/                # ユーザーレベルスキル
│   └── */SKILL.md
├── tasks/                 # グローバル専用: タスクリスト
│   └── {task-list-id}/
├── teams/                 # グローバル専用: エージェントチーム設定
│   └── {team-name}/
│       └── config.json
├── projects/              # グローバル専用: プロジェクトごとの自動メモリ
│   └── {project-hash}/
│       └── memory/
│           ├── MEMORY.md
│           └── *.md
├── keybindings.json       # グローバル専用: キーボードショートカット
└── hooks/                 # ユーザーレベルフック
    ├── scripts/
    └── config/

~/.claude.json             # グローバル専用: MCPサーバー、OAuth、プリファレンス、キャッシュ
```

注意: `~/.claude.json` は `~/.claude/` ディレクトリの外に配置される。

##### (2) `./.claude/` プロジェクト設定の構成

```
.claude/
├── settings.json          # チーム共有設定（git管理）
├── settings.local.json    # 個人プロジェクトオーバーライド（gitignored）
├── CLAUDE.md              # プロジェクトメモリ
├── agents/                # プロジェクトサブエージェント
│   └── *.md
├── rules/                 # プロジェクトレベルのモジュラールール
│   └── *.md
├── commands/              # カスタムスラッシュコマンド
│   └── *.md
├── skills/                # カスタムスキル
│   └── {skill-name}/
│       ├── SKILL.md
│       └── supporting-files/
├── hooks/                 # プロジェクトレベルフック
│   ├── scripts/
│   └── config/
└── plugins/               # インストール済みプラグイン

.mcp.json                  # プロジェクトスコープMCPサーバー（リポルート）
```

##### (3) CLAUDE.md の役割

- **用途**: セッション開始時に Claude が読み込む指示・コンテキストファイル
- **配置場所と優先順位**:

| メモリ種別 | 配置場所 | 目的 | 共有範囲 |
|-----------|---------|------|---------|
| Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS), `/etc/claude-code/CLAUDE.md` (Linux) | 組織全体の指示 | 組織全員 |
| Project memory | `./CLAUDE.md` or `./.claude/CLAUDE.md` | チーム共有のプロジェクト指示 | チームメンバー（ソース管理経由） |
| Project rules | `./.claude/rules/*.md` | モジュラーなトピック別指示 | チームメンバー（ソース管理経由） |
| User memory | `~/.claude/CLAUDE.md` | 個人の全プロジェクト共通設定 | 自分のみ |
| Project local | `./CLAUDE.local.md` | 個人のプロジェクト固有設定 | 自分のみ |
| Auto memory | `~/.claude/projects/<project>/memory/` | Claudeの自動メモ・学習 | 自分のみ |

- ディレクトリ階層を再帰的に上方向にたどり、見つかった CLAUDE.md を全て読み込む
- 子ディレクトリの CLAUDE.md は、そのディレクトリ内のファイルを読んだ時にオンデマンドで読み込まれる
- `@path/to/import` 構文で外部ファイルのインポートが可能（最大5ホップ再帰）
- CLAUDE.local.md は自動的に .gitignore に追加される

##### (4) `rules/`, `commands/`, `skills/` の役割

**rules/**: モジュラーなプロジェクト指示ファイル
- `.claude/rules/*.md` に配置。全ての `.md` ファイルが自動読み込みされる
- `paths:` フロントマターによるパス固有ルールをサポート
- サブディレクトリによる整理が可能（再帰的に検出）
- シンボリックリンクをサポート（共有ルールの横展開用）
- ユーザーレベルルール（`~/.claude/rules/`）はプロジェクトルールより低い優先度

**commands/**: カスタムスラッシュコマンド
- `.claude/commands/*.md` に配置
- Markdown ファイルで定義
- skills に統合済み（既存の commands は引き続き動作）
- 同名の skill と command がある場合は skill が優先

**skills/**: エージェントスキル
- `.claude/skills/{skill-name}/SKILL.md` に配置
- YAML フロントマター（name, description 等）+ Markdown コンテンツ
- Agent Skills オープンスタンダード準拠（OpenAI Codex CLI と互換）
- 主要フロントマターフィールド:
  - `name`: スキル名（ディレクトリ名と一致必須）
  - `description`: 説明（推奨）
  - `disable-model-invocation`: true でユーザー手動呼び出しのみ
  - `user-invocable`: false で Claude 自動呼び出しのみ
  - `allowed-tools`: 使用可能なツール制限
  - `model`: 使用モデル
  - `context`: fork でサブエージェントコンテキストで実行
  - `agent`: context: fork 時のサブエージェント指定
  - `hooks`: スキルスコープのフック
- 優先順位: enterprise > personal > project
- `$ARGUMENTS` 等の文字列置換をサポート
- `!`command`` 構文で動的コンテキスト注入が可能

**agents/**: カスタムサブエージェント
- `.claude/agents/*.md` に配置
- YAML フロントマター（name, description, tools, model）+ Markdown ボディ（システムプロンプト）
- プロジェクトエージェントはユーザーレベルエージェントより優先
- 各サブエージェントは独立したコンテキストウィンドウを持つ

##### (5) `settings.json` の設定項目

**パーミッション**:
- `permissions.allow`: 許可するツール/パターン
- `permissions.deny`: 拒否するツール/パターン
- `permissions.ask`: 承認を求めるツール/パターン
- `permissions.additionalDirectories`: 追加ディレクトリアクセス
- `permissions.defaultMode`: デフォルト権限モード

**モデル設定**: `model`, `availableModels`, `alwaysThinkingEnabled`

**環境変数**: `env` オブジェクトでキー/値を設定

**UI/表示**: `language`, `outputStyle`, `spinnerTipsEnabled`, `prefersReducedMotion` 等

**MCP サーバー**: `enableAllProjectMcpServers`, `enabledMcpjsonServers`, `disabledMcpjsonServers`

**Git 属性**: `attribution.commit`, `attribution.pr`

**サンドボックス**: `sandbox.enabled`, `sandbox.autoAllowBashIfSandboxed`, `sandbox.network.allowedDomains` 等

**自動メモリ**: `autoMemoryEnabled`

**フック**: `hooks.PreToolUse`, `hooks.PostToolUse`, `hooks.Notification`, `hooks.Stop` 等

##### (6) 設定の優先順位体系

**settings.json の優先順位**（高い順）:
1. **Managed** — サーバー管理/MDM/OS レベルポリシー/managed-settings.json（オーバーライド不可）
2. **Command line** — CLI 引数（`--allowedTools` 等）
3. **Local** — `.claude/settings.local.json`（個人、gitignored）
4. **Project** — `.claude/settings.json`（チーム共有、git管理）
5. **User** — `~/.claude/settings.json`（個人、全プロジェクト共通）

**パーミッションルールの評価順序**: deny → ask → allow（最初にマッチしたルールが勝つ）

**CLAUDE.md / メモリの優先順位**: より具体的な指示が、より広範な指示に優先する
- Managed policy > Project memory/rules > User memory > Auto memory

**成果物**: 上記の調査結果を本ログに整理完了
**課題・気づき**: なし

---

### [2026-02-27 10:30] タスクID: T-002
**状態**: 完了
**作業内容**:

本リポジトリの `.claude/` 配下の現状構成を棚卸しし、T-001 の調査結果と照合して差異を分析した。

#### 本リポジトリの現状構成

```
.claude/
├── commands/
│   └── opsx/
│       ├── apply.md
│       ├── archive.md
│       ├── bulk-archive.md
│       ├── continue.md
│       ├── explore.md
│       ├── ff.md
│       ├── new.md
│       ├── onboard.md
│       ├── sync.md
│       └── verify.md
├── rules/
│   ├── code-in-docs.md
│   ├── design-doc.md
│   ├── role-format-guide.md
│   └── sync.md
├── settings.json
└── skills/
    ├── openspec-apply-change/SKILL.md
    ├── openspec-archive-change/SKILL.md
    ├── openspec-bulk-archive-change/SKILL.md
    ├── openspec-continue-change/SKILL.md
    ├── openspec-explore/SKILL.md
    ├── openspec-ff-change/SKILL.md
    ├── openspec-new-change/SKILL.md
    ├── openspec-onboard/SKILL.md
    ├── openspec-sync-specs/SKILL.md
    └── openspec-verify-change/SKILL.md

CLAUDE.md  （リポジトリルート）
```

#### 差異分析

##### (1) 標準にあるが本リポジトリにないもの

| 標準構成要素 | 説明 | 影響度 |
|-------------|------|--------|
| `.claude/agents/` | カスタムサブエージェント定義 | 中 — CLAUDE.md にサブエージェント戦略の記載あり。agents/ でサブエージェントを定義すれば、より体系的に管理可能 |
| `.claude/hooks/` | イベント駆動の自動化（PreToolUse, PostToolUse 等） | 低 — 現時点でフック自動化のニーズが明確でなければ不要 |
| `.claude/plugins/` | インストール済みプラグイン | 低 — プラグイン利用時に自動生成される |
| `.claude/CLAUDE.md` | `.claude/` 内のプロジェクトメモリ（ルート CLAUDE.md と等価） | 低 — ルート CLAUDE.md が既に存在。どちらか一方で十分 |
| `.claude/settings.local.json` | 個人プロジェクトオーバーライド | 低 — 個人設定が必要な場合に各自が作成 |
| `CLAUDE.local.md` | 個人のプロジェクト固有指示 | 低 — 個人設定が必要な場合に各自が作成 |
| `.mcp.json` | プロジェクトスコープ MCP サーバー設定 | 低 — MCP サーバーを利用する場合に追加 |

##### (2) 本リポジトリにあるが標準と異なる配置のもの

| 現状 | 標準との差異 | 対応方針 |
|------|------------|---------|
| `.claude/commands/opsx/*.md` | 公式では commands は skills に統合済み。commands は引き続き動作するが、skills が推奨 | 本リポでは commands と skills の両方を利用中。既に `skills/openspec-*` として skills 化も進んでいるが、`commands/opsx/` も残存。commands は下位互換で動作するため急ぎの移行は不要だが、中長期的には skills に一本化が望ましい |
| `settings.json` がコメント付き JSONC 形式 | 標準 JSON が期待される。Claude Code はコメント付きを許容する可能性はあるが、公式ドキュメントでは純粋な JSON を使用 | 正式な JSON 形式に修正するか、有効な設定項目を追加すべき |

##### (3) 改善が推奨される点

1. **settings.json の充実**: 現在はコメントのみの空設定。権限ルール（deny で `.env` 等の機密ファイル排除、allow で頻用コマンド許可）を追加すべき
2. **agents/ ディレクトリの検討**: CLAUDE.md にサブエージェント戦略が明記されているのに `.claude/agents/` が存在しない。CLAUDE.md 内の `dev-process-improvement/.claude/rules/` にロール定義はあるが、これはプロセス改善固有。プロジェクト全体のサブエージェント定義を `.claude/agents/` で管理する検討余地あり
3. **commands/ から skills/ への段階的移行**: `commands/opsx/` と `skills/openspec-*` が同等機能で並存。公式は skills を推奨しており、将来的に commands を廃止して skills に統一すべき
4. **rules/ の paths 活用**: 現在の rules ファイル（code-in-docs.md, design-doc.md）には `paths:` フロントマターがない。対象パスが明確なルールには paths を設定し、コンテキスト効率を向上できる

**成果物**: 差異分析結果を本ログに記載完了
**課題・気づき**: なし

---

### [2026-02-27 10:45] タスクID: T-003
**状態**: 完了
**作業内容**:

T-001・T-002 の結果を基に `.claude/rules/claude-directory-guide.md` を日本語で作成した。

以下の5項目を網羅:
1. 標準ディレクトリ構成の全体像（グローバル設定・プロジェクト設定のツリー図）
2. 各ディレクトリ・ファイルの役割説明（CLAUDE.md, settings.json, rules/, skills/, commands/, agents/, hooks/, plugins/, .mcp.json）
3. 設定の優先順位（settings.json の5段階優先順位、パーミッション評価順序、CLAUDE.md/メモリの優先順位、スキル・エージェントの優先順位）
4. 本リポジトリの現状構成との差異と改善方針（差異テーブルと対応方針）
5. 新規プロジェクトへの展開時の推奨構成（Starter/Standard/Advanced の3段階構成 + チェックリスト）

**成果物**: `.claude/rules/claude-directory-guide.md`（新規作成）
**課題・気づき**: なし

---

### [2026-02-27 10:50] タスクID: T-004
**状態**: 完了
**作業内容**:

`07_issues.md` の未転記課題を確認した。

- 未転記メモセクションに課題は0件
- 作業中（T-001〜T-003）に新たな課題・リスクの発見もなし
- CSV転記は不要と判断

**成果物**: なし（転記不要の確認完了）
**課題・気づき**: なし

---

