---
paths: "openspec/**"
---
# OpenSpec 開発ルール

## 目的

Claude が `openspec/` 配下のファイルを操作する際に従うべきルール・フローを定義する。
本ルールは `openspec/config.yaml` の設定内容と整合しており、公式リポジトリ（Fission-AI/OpenSpec）の設計意図に準拠している。

---

## ディレクトリ構成ルール

`openspec/` ディレクトリは以下の構成を維持すること。

```
openspec/
  config.yaml          # スキーマ・プロジェクトコンテキスト設定（このリポジトリの設定）
  specs/               # 現在状態の仕様（Single Source of Truth）
    <domain>/          # ドメイン単位のサブディレクトリ（kebab-case）
      spec.md          # ドメインの仕様ファイル
  changes/             # 進行中の変更サイクル
    <change-name>/     # 変更単位のフォルダ（kebab-case）
      .openspec.yaml   # メタデータ（schema, created）
      proposal.md      # 変更の Why / What Changes / Impact
      specs/           # デルタ仕様（ADDED / MODIFIED / REMOVED）
        <domain>/
          spec.md
      design.md        # 技術的アーキテクチャ・設計判断
      tasks.md         # 実装チェックリスト
    archive/           # 完了した変更のアーカイブ
      YYYY-MM-DD-<change-name>/
```

### ディレクトリ操作の制約

- `specs/` ディレクトリは直接編集しない。変更は必ず `changes/` 経由で行い、`/opsx:archive` でマージする
- `changes/` 配下に新規フォルダを作成する場合は `/opsx:new` または `/opsx:propose` を使用する
- `archive/` は読み取り専用。手動でファイルを追加・編集しない

---

## 変更サイクルのフロー

本リポジトリでは Expanded プロファイルを使用する。変更サイクルは以下の順序で進行する。

### 標準フロー

```
1. /opsx:new <change-name>     # サイクル開始（フォルダ・メタデータ作成）
2. /opsx:continue              # proposal -> specs -> design -> tasks を順次生成
   （または /opsx:ff で一括生成）
3. /opsx:apply                 # tasks.md に従ったコード実装
4. /opsx:archive               # デルタスペックを specs/ にマージしてアーカイブ
```

### 各フェーズの詳細

| フェーズ | コマンド | 生成物 | 説明 |
|---------|---------|--------|------|
| 提案 | `/opsx:new` + `/opsx:continue` | proposal.md | 変更の Why / What を記述 |
| 仕様 | `/opsx:continue` | specs/ (delta) | ADDED / MODIFIED / REMOVED で差分を表現 |
| 設計 | `/opsx:continue` | design.md | 技術的な How を記述 |
| タスク | `/opsx:continue` | tasks.md | 実装チェックリストを作成 |
| 実装 | `/opsx:apply` | (コード) | tasks.md のチェックリストに従い実装 |
| アーカイブ | `/opsx:archive` | archive/ | デルタスペックを specs/ にマージし、フォルダを archive/ に移動 |

### フロー上の注意

- アーティファクトの依存関係: `Proposal -> Specs -> Design -> Tasks`。ただし Design が不要な場合はスキップ可能
- 1 つの変更サイクルは 1 つの論理的なまとまりに集中させる
- 複数の変更を並行して進める場合は、それぞれ独立した `changes/<name>/` フォルダで管理する

---

## 成果物の命名規則

| 対象 | 規約 | 例 |
|------|------|-----|
| change フォルダ名 | kebab-case | `add-user-profile`, `fix-auth-flow` |
| spec ディレクトリ | ドメイン単位の kebab-case | `specs/user/`, `specs/auth/` |
| アーカイブフォルダ名 | `YYYY-MM-DD-<change-name>` | `2026-02-21-update-readme-for-v1` |
| タスク番号 | 階層番号 | `1.1`, `1.2`, `2.1` |
| ファイル名 | 小文字・ハイフン区切り | `proposal.md`, `design.md` |
| ドキュメント言語 | 日本語 | -- |
| コード言語 | 英語 | -- |

---

## アーティファクト作成時のルール

### proposal.md

- 日本語で記述すること
- Summary / Motivation / Scope / Success Criteria のセクションを必ず含めること
- 変更の Why / What Changes / Impact を明記すること

### specs/ (デルタスペック)

- RFC 2119 キーワード（MUST / SHALL / SHOULD / MAY）を必ず含めること
- 新規 spec を追加する場合は「ADDED Requirements」セクションを使うこと
- 既存 spec への要件追加は「MODIFIED Requirements」セクションを使うこと
- 廃止する要件は「REMOVED Requirements」セクションに記載すること
- 実装の詳細（クラス名、フレームワーク固有の記述）ではなく、観測可能な振る舞い・制約・エラー条件を記述すること
- Given/When/Then 形式のシナリオを含めること

### design.md

- 日本語で記述すること
- mermaid 図を最低 1 つ含めること（アーキテクチャ図またはデータフロー図）
- 本文中にコードブロックを入れないこと（実装の詳細は tasks.md で扱う）

### tasks.md

- 日本語で記述すること
- チェックボックス形式（`- [ ]`）でタスクを列挙すること
- DB / API / フロントエンド / テスト のカテゴリに分けること
- タスク番号は階層番号（`1.1`, `1.2`, `2.1`）を使用すること

---

## config.yaml 編集時の注意

- `openspec/config.yaml` は OpenSpec の中核設定ファイルである。編集時は慎重に行うこと
- `rules:` セクションの文字列値に日本語が含まれる場合は**シングルクォート**で囲むこと
  - 正: `- '日本語のルール文字列'`
  - 誤: `- "日本語のルール文字列"`（YAML パースエラーになる場合がある）
- `schema:` の値を変更しないこと（`spec-driven` を維持）
- `context:` ブロックを編集する場合は、既存のディレクトリ構成の記述と実際のリポジトリ構造が一致するよう確認すること

---

## Claude が従うべき手順

### 新しい変更を開始するとき

1. `openspec/config.yaml` の `context` を読み、現在のプロジェクトコンテキストを把握する
2. `/opsx:new <change-name>` で変更フォルダを作成する（手動でフォルダを作らない）
3. `/opsx:continue` を繰り返して proposal -> specs -> design -> tasks を順次生成する
4. 各アーティファクトは上記「アーティファクト作成時のルール」に従う

### コードを実装するとき

1. `/opsx:apply` で tasks.md のチェックリストに従い実装する
2. タスクを完了したらチェックボックスを更新する
3. テストを実行して動作を確認する

### 変更を完了するとき

1. 全タスクの完了を確認する
2. `/opsx:archive` でデルタスペックを specs/ にマージし、変更フォルダをアーカイブに移動する
3. アーカイブ後、`specs/` の内容が正しく更新されていることを確認する
