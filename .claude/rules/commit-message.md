---
paths: "triage/**/*.md"
---
# コミットメッセージルール

## ベースルール

`roles/_base/common.md` セクション5「コミット規約」に従う（Conventional Commits 形式）。

## セッションロール別プレフィックス

セッションマネージャー（dev_manager）が起動するセッションのコミットには、以下のプレフィックス形式を使用する。

```
[<session-type>] <category>: <summary>
```

### パラメータ

| パラメータ | 必須 | 説明 |
|-----------|------|------|
| `session-type` | 必須 | コミットを行うセッション種別（下記テーブル参照） |
| `category` | 必須 | 施策名またはカテゴリ（下記テーブル参照） |
| `summary` | 必須 | 1行の要約（50文字以内推奨） |

### セッション種別と category の対応

#### 施策作業（sessions/initiatives/ 配下の作業）

| session-type | category | 用途 | 例 |
|-------------|----------|------|-----|
| `L1` | sessions/initiatives/ 配下のディレクトリ名 | 提案・計画・タスク作成・ゲート判定 | `[L1] commit-message-rules: 提案・計画を作成` |
| `L2-worker` | 同上 | タスク実施・作業記録・レポート作成 | `[L2-worker] commit-message-rules: ルールファイルを作成` |
| `L2-evaluator` | 同上 | 評価計画・評価実施・レポート作成 | `[L2-evaluator] commit-message-rules: 評価レポートを作成` |

#### 非施策作業

| session-type | category | 用途 | 例 |
|-------------|----------|------|-----|
| `triage` | `YYYYMMDD` | トリアージセッション | `[triage] 20260304: inbox 走査・バックログ整理` |
| `maintenance` | 作業対象を示す名前 | 設定変更・リファクタ等の保守作業 | `[maintenance] settings: $schema と deny ルールを追加` |

### 例

```
[triage] 20260304: inbox 走査・バックログ整理
[triage] 20260304: 課題管理CSV レビュー・ルール整合性チェック
[triage] 20260304: トリアージレポート作成
[L1] auth-pattern: 提案・計画を作成
[L2-worker] auth-pattern: 認証パターンを実装
[maintenance] settings: deny ルールを追加
```

## 使い分けガイド

- **Conventional Commits 形式**（`feat(scope): ...`）: 通常の開発作業（feature_builder, test_writer 等のロールが実施するコード変更）
- **セッションプレフィックス形式**（`[session-type] category: ...`）: セッション管理作業（トリアージ・施策管理・保守等）

通常の開発作業では Conventional Commits を使い、セッション管理系の作業ではセッションプレフィックスを使う。

## 禁止事項

- `git push --force` の使用
- 意味のないコミットメッセージ（`update`, `fix`, `wip` 等のみ）
