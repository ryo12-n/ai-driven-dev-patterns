# コミットメッセージ規約

## 適用対象

dev-process-improvement 配下で行うすべての git コミットに適用する。

---

## 形式

```
[<session-type>] <category>: <summary>

<details>
```

### パラメータ

| パラメータ | 必須 | 説明 |
|-----------|------|------|
| `session-type` | 必須 | コミットを行うセッション種別（下記テーブル参照） |
| `category` | 必須 | 施策名またはカテゴリ（下記テーブル参照） |
| `summary` | 必須 | 1行の要約（50文字以内推奨） |
| `details` | 任意 | 変更したファイル一覧、作業内容の詳細（複数行可） |

---

## セッション種別と category の対応

### 施策作業（initiatives/ 配下の作業）

| session-type | category | 用途 | 例 |
|-------------|----------|------|-----|
| `L1` | initiatives/ 配下のディレクトリ名 | 提案・計画・タスク作成・ゲート判定 | `[L1] commit-message-rules: 提案・計画を作成` |
| `L2-worker` | 同上 | タスク実施・作業記録・レポート作成 | `[L2-worker] commit-message-rules: ルールファイルを作成` |
| `L2-evaluator` | 同上 | 評価計画・評価実施・レポート作成 | `[L2-evaluator] commit-message-rules: 評価レポートを作成` |

### 非施策作業（EVL-001 対応）

| session-type | category | 用途 | 例 |
|-------------|----------|------|-----|
| `triage-mgr` | `YYYYMMDD` | マネージャー: 事前調査・計画・ディスパッチ・集約レポート | `[triage-mgr] 20260305: 事前調査・ワーカー割り当て` |
| `triage-worker` | `YYYYMMDD` | ワーカー: 走査実行・スキャンレポート | `[triage-worker] 20260305: set-1 inbox/CSV スキャン完了` |
| `triage-eval` | `YYYYMMDD` | 評価者: 評価レポート | `[triage-eval] 20260305: set-1 評価レポート作成` |
| `sync` | 同期方向（`upstream-to-origin` / `origin-to-upstream`） | リポジトリ間の同期 | `[sync] upstream-to-origin: main ブランチを同期` |
| `maintenance` | 作業対象を示す名前 | 設定変更・リファクタ等の保守作業 | `[maintenance] settings: $schema と deny ルールを追加` |

---

## 例

### 施策作業のコミット

```
[L2-worker] coordination-protocol: ガイドライン文書を作成

- docs/coordination-protocol-guideline.md を新規作成
- 03_work_log.md に作業履歴を記録
- 04_work_report.md に作業レポートを作成
```

### 非施策作業のコミット

```
[triage-mgr] 20260303: 事前調査・ワーカー割り当て・集約レポート作成

- 00_pre_investigation.md, 01_plan.md を作成
- set-1, set-2 をディスパッチ
- 03_report.md を作成し PR 提出
```

```
[maintenance] settings: $schema と deny ルールを追加

- .claude/settings.json に JSON Schema バリデーションを追加
- .env, secrets/ の deny ルールを設定
```

---

## 禁止事項

- `git push --force` の使用
- 意味のないコミットメッセージ（`update`, `fix`, `wip` 等のみ）
- session-type のないコミットメッセージ（`[session-type]` プレフィックスは必須）
- category のないコミットメッセージ（施策名またはカテゴリは必須）

---

**作成日**: 2026-03-03
**情報源**: `docs/coordination-protocol-guideline.md` セクション2.2
**関連施策**: `initiatives/commit-message-rules/`
