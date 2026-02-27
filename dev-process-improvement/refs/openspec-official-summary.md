# OpenSpec 公式リポジトリ調査サマリー

> **調査対象**: https://github.com/Fission-AI/OpenSpec
> **調査日**: 2026-02-27
> **調査元ドキュメント**: README.md, docs/concepts.md, docs/getting-started.md, docs/workflows.md, docs/commands.md

---

## 1. OpenSpec とは

OpenSpec は **spec-driven development (SDD) フレームワーク** であり、AI コーディングアシスタントと人間がコード実装前に仕様を共有・合意するための軽量な仕様レイヤーを提供する。

### 設計哲学（4原則）

1. **Fluid not rigid** -- フェーズゲートなし。どのアーティファクトも任意のタイミングで更新可能
2. **Iterative not waterfall** -- 実装中にも仕様を改善し続ける
3. **Easy not complex** -- Markdown ベースで最小限のセットアップ
4. **Brownfield-first** -- 既存プロジェクトへの導入を前提に設計

---

## 2. 標準ディレクトリ構成

`openspec init` 実行後に生成されるディレクトリ構造:

```
openspec/
  config.yaml          # スキーマ・プロジェクトコンテキスト設定
  specs/               # 現在状態の仕様（Single Source of Truth）
    <domain>/          # ドメイン単位でサブディレクトリ（例: auth/, payments/）
      spec.md          # そのドメインの仕様ファイル
  changes/             # 進行中の変更サイクル
    <change-name>/     # 変更単位のフォルダ（kebab-case）
      .openspec.yaml   # メタデータ（schema, created 等）
      proposal.md      # 変更の Why / What
      specs/           # デルタ仕様（ADDED / MODIFIED / REMOVED）
        <domain>/
          spec.md
      design.md        # 技術的な How
      tasks.md         # 実装チェックリスト
    archive/           # 完了した変更のアーカイブ
      YYYY-MM-DD-<change-name>/  # 日付プレフィックス付き
        (同上の構造)
```

### 各ディレクトリ・ファイルの役割

| パス | 役割 |
|------|------|
| `config.yaml` | スキーマ（spec-driven 等）とプロジェクトコンテキスト（ルール・命名規約・ディレクトリ構成の説明）を定義 |
| `specs/` | システムの現在の振る舞いを記述する「正の情報源（Source of Truth）」。ドメイン単位で整理 |
| `specs/<domain>/spec.md` | RFC 2119 キーワード（MUST / SHALL / SHOULD / MAY）で要件を記述。Given/When/Then のシナリオを含む |
| `changes/` | 進行中の変更提案。各変更は独立したフォルダで管理され、並行作業が可能 |
| `changes/<name>/proposal.md` | 変更の意図・スコープ・影響範囲を記述（Why / What Changes / Impact） |
| `changes/<name>/specs/` | デルタスペック。ADDED / MODIFIED / REMOVED の3セクションで差分を表現 |
| `changes/<name>/design.md` | 技術的なアーキテクチャ・設計判断を記述 |
| `changes/<name>/tasks.md` | 実装タスクをチェックリスト形式で管理（階層番号: 1.1, 1.2, 2.1 等） |
| `changes/archive/` | 完了した変更を日付プレフィックス付きで保管。コンテキスト・経緯の追跡用 |

---

## 3. 変更サイクルのフロー

### アーティファクトの生成順序

```
Proposal → Specs → Design → Tasks → Implementation
(why/scope)  (what)   (how)   (steps)
```

依存関係は「何が作成可能か」を示すもので、厳格な順序制約ではない。Design が不要なら飛ばしてもよい。

### ワークフロープロファイル

**Core プロファイル（デフォルト）**: 4コマンド

| コマンド | 役割 |
|---------|------|
| `/opsx:propose` | 変更提案。全アーティファクト（proposal, specs, design, tasks）を一括生成 |
| `/opsx:explore` | 要件が不明確な場合の調査・探索 |
| `/opsx:apply` | tasks.md に従ってコード実装 |
| `/opsx:archive` | 完了した変更のアーカイブ。デルタスペックを specs/ にマージ |

**Expanded プロファイル（オプション）**: 追加コマンド

| コマンド | 役割 |
|---------|------|
| `/opsx:new` | 変更フォルダのスキャフォールド（メタデータのみ） |
| `/opsx:continue` | 依存関係に従いアーティファクトを1つずつ生成 |
| `/opsx:ff` | 全プランニングアーティファクトを一括生成（fast-forward） |
| `/opsx:verify` | 実装がアーティファクトと一致するか検証（completeness, correctness, coherence） |
| `/opsx:sync` | デルタスペックを specs/ にマージ（archive とは独立） |
| `/opsx:bulk-archive` | 複数変更を一括アーカイブ |
| `/opsx:onboard` | インタラクティブチュートリアル |

### 代表的なワークフローパターン

- **Quick Feature**: `new` -> `ff` -> `apply` -> `verify` -> `archive`
- **Exploratory**: `explore` -> `new` -> `continue` -> `apply`
- **Parallel Changes**: 複数の変更フォルダを切り替えながら並行作業

---

## 4. デルタスペック（Brownfield 対応）

変更による仕様差分を3セクションで表現する:

- **ADDED Requirements** -- 新規追加される振る舞い
- **MODIFIED Requirements** -- 変更される振る舞い（旧バージョンも記載）
- **REMOVED Requirements** -- 廃止される振る舞い

デルタスペックにより、既存仕様を全文書き換えることなく差分だけを明確化できる。複数変更が同じファイルに影響する場合のコンフリクトも軽減される。

---

## 5. アーカイブプロセス

1. デルタスペックの各セクション（ADDED / MODIFIED / REMOVED）を対応する `specs/` にマージ
2. 変更フォルダを `changes/archive/YYYY-MM-DD-<change-name>/` に移動
3. 完全なコンテキストを保持し、変更の経緯を追跡可能にする

---

## 6. 命名規約

| 対象 | 規約 |
|------|------|
| 変更フォルダ名 | kebab-case（例: `add-dark-mode`, `fix-auth-flow`） |
| アーカイブフォルダ名 | `YYYY-MM-DD-<change-name>` |
| spec ディレクトリ | ドメイン単位の kebab-case（例: `specs/auth/`, `specs/payments/`） |
| タスク番号 | 階層番号（`1.1 Task Name`, `1.2 Subtask`, `2.1 Next Phase`） |
| ファイル名 | 小文字・ハイフン区切り |

---

## 7. config.yaml のスキーマ

```yaml
schema: spec-driven          # ワークフロースキーマ
context: |                    # プロジェクトのコンテキスト情報
  ## リポジトリ概要
  ...
  ## ディレクトリ構成
  ...
  ## 命名規約
  ...
  ## 変更サイクルの流れ
  ...
rules:                        # アーティファクト種別ごとのルール
  proposal:
    - ルール1
  design:
    - ルール1
  tasks:
    - ルール1
  specs:
    - ルール1
```

- `schema`: ワークフローのスキーマ名（`spec-driven` がデフォルト）
- `context`: プロジェクト固有の情報を記述するブロック
- `rules`: proposal / design / tasks / specs の各アーティファクト生成時に AI が従うルール

---

## 8. ベストプラクティス

- 高推論モデル（Opus 4.5, GPT 5.2 等）をプランニング・実装に使用する
- コンテキストウィンドウを清潔に保つ
- 変更は単一の論理的なまとまりに集中させる
- アーカイブ前に `/opsx:verify` で検証する
- デルタスペックは実装ではなく観測可能な振る舞い・制約・エラー条件を記述する

---

## 9. 技術要件

- Node.js 20.19.0 以上
- パッケージマネージャ: npm, pnpm, yarn, bun, nix 対応
- ライセンス: MIT
- 20+ AI ツール対応（Claude, GitHub Copilot, GPT 等）
