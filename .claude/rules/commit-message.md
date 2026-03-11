# コミットメッセージルール

## ベースルール: Conventional Commits

本リポジトリでは **Conventional Commits** スタイルを採用する。

### コミットメッセージの形式

```
<type>(<scope>): <summary>

<body>（任意）

<footer>（任意）
DT-XXX（dev_manager から割り当てられたタスクIDがある場合）
```

### DT-XXX フッタルール

dev_manager から DT-XXX 形式のタスク指示を受けている場合、コミットメッセージの footer に `DT-XXX` を含めること。これによりタスク単位のトレーサビリティを確保する。

### type の種類

| type | 用途 |
|------|------|
| `feat` | 新機能の追加 |
| `fix` | バグ修正 |
| `refactor` | 振る舞いを変えないリファクタリング |
| `test` | テストの追加・修正 |
| `perf` | パフォーマンス改善 |
| `docs` | ドキュメントの追加・修正 |
| `chore` | ビルド・CI・設定ファイルの変更 |

### scope の例

- `src`: `src/` 配下の変更
- `tests`: `tests/` 配下の変更
- `openspec`: `openspec/` 配下の変更
- `docs`: `docs/` 配下の変更
- `agents`: `.claude/agents/` 配下の変更

### コミットメッセージの例

```
feat(src): ユーザー認証パターンを追加

- src/auth/ ディレクトリを新規作成
- JWT 認証の実装パターンを追加
- 対応するテストを tests/auth/ に追加
```

### コミット実行例

```bash
git add src/auth.py tests/test_auth.py
git commit -m "$(cat <<'EOF'
feat(src): ユーザー認証パターンを追加

JWT 認証の実装パターンを追加
対応するテスト5件を追加、全パス
EOF
)"
```

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
| `triage` | `YYYYMMDD` | トリアージセッション（後方互換） | `[triage] 20260304: inbox 走査・バックログ整理` |
| `triage-mgr` | `YYYYMMDD` | マネージャー: 事前調査・計画・ディスパッチ・集約レポート | `[triage-mgr] 20260305: 事前調査・ワーカー割り当て` |
| `triage-worker` | `YYYYMMDD` | ワーカー: 走査実行・スキャンレポート | `[triage-worker] 20260305: set-1 inbox/CSV スキャン完了` |
| `triage-eval` | `YYYYMMDD` | 評価者: 評価レポート | `[triage-eval] 20260305: set-1 評価レポート作成` |
| `sync-worker` | `YYYYMMDD` | ワーカー: 同期作業実行・同期レポート | `[sync-worker] 20260308: 同期作業完了・レポート作成` |
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
- session-type のないコミットメッセージ（セッションプレフィックス形式を使う場合、`[session-type]` プレフィックスは必須）
- category のないコミットメッセージ（セッションプレフィックス形式を使う場合、施策名またはカテゴリは必須）

---

**作成日**: 2026-03-03
**同期元**: dev-process-improvement `.claude/rules/commit-message.md`
**最終同期日**: 2026-03-12
