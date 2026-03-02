# 改善施策提案: dev-process-improvement リポジトリ分離

## 背景・課題

`dev-process-improvement/` ディレクトリは `ai-driven-dev-patterns` リポジトリ内に同居しているが、以下の問題がある。

1. **責務の混在**: ai-driven-dev-patterns は開発パターン集であり、プロセス改善施策管理とは関心事が異なる
2. **独立度が高い**: トリアージの実現可能性評価で独立度 95% と判定。内部パスのみ参照、コード依存ゼロ、機能的依存なし
3. **リポジトリの肥大化**: initiatives/_archive/ に 22 の完了施策が蓄積されており、パターン集リポの見通しが悪くなっている

## 目標

1. `dev-process-improvement/` のコンテンツを独立リポジトリ `https://github.com/ryo12-n/dev-process-improvement` に移行する
2. 親リポの全参照箇所（8ファイル）を更新し、分離後も両リポが正常に機能する状態にする
3. 親リポから `dev-process-improvement/` を削除する

## スコープ

### やること

- 新リポジトリへのコンテンツコピー（単純コピー、履歴なし）
- 新リポジトリの初期設定（CLAUDE.md、README.md 等の調整）
- 親リポの参照更新（8ファイル）:
  - `CLAUDE.md` — collab-log パスを親リポ内の新パスに変更
  - `README.md` — sync 除外リストから dev-process-improvement を削除
  - `.claude/rules/role-format-guide.md` — 適用対象から dev-process-improvement の記述を除去
  - `.claude/rules/claude-directory-guide.md` — 現状構成の記述を更新
  - `docs/git-worktree-guideline.md` — 参照テーブルの更新
  - `docs/design/dev-workflow-overview.md` — ワークフロー比較の記述更新
  - `roles/_base/common.md` — ディレクトリ構成コメントの更新
  - `openspec/config.yaml` — 設定コメントの更新
- collab-log.md を親リポ側に新設（`docs/collab-log.md`）
- 親リポから `dev-process-improvement/` を削除

### やらないこと

- Git 履歴の移行（単純コピーで十分と判断）
- 新リポ側の CI/CD 設定（分離後の別施策として実施）
- 新リポ側の upstream 同期設定（分離後に検討）

## 期待される効果

- ai-driven-dev-patterns リポジトリがパターン集としての本来の役割に集中できる
- プロセス改善の関心事が独立し、リポジトリの責務が明確になる
- 新リポでの施策管理がよりシンプルになる（パス階層が1段浅くなる）

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| 新リポ作成の権限不足 | 中 | 事前に `gh repo create` の可否を確認する |
| 参照の更新漏れ | 中 | 8ファイルの一覧を事前に洗い出し済み。タスクでチェックリスト化する |
| 分離後の施策管理フロー変更 | 低 | 現行フローを維持。パスのプレフィックスが変わるだけ |

## 壁打ちの背景

フェーズ0 の壁打ちで以下の意思決定を行った。

| 論点 | 選択肢 | 決定 | 理由 |
|------|--------|------|------|
| Git 履歴の移行方法 | subtree split / 単純コピー | **単純コピー** | 過去施策は _archive に保持されているため履歴の参照ニーズは低い |
| collab-log.md の配置先 | 新リポ / 親リポ新設 / 両方 | **親リポ側に新設** | collab-log は ai-driven-dev-patterns での協働記録であり、親リポの関心事 |
| role-format-guide.md の整理 | 記述除去 / 参照リンクに変更 | **記述除去** | 分離後は別リポの管轄。リンク維持は保守コストが高い |
| 施策管理場所 | 親リポ / 新リポ | **親リポで実施** | 分離対象のディレクトリ内で施策管理するのは自己参照的。親リポ側で施策を完了させてから削除する |

## 備考・設計パターン

- 本施策は「親リポ側で施策を管理し、分離完了後にクローズ処理で dev-process-improvement/ ごとアーカイブ→削除」の流れになる
- 新リポの GitHub リポジトリは事前に作成されている前提（`https://github.com/ryo12-n/dev-process-improvement`）
- クローズ処理の特殊性: 通常の施策は _archive に移動するが、本施策は dev-process-improvement/ 自体を削除するため、08_gate_review.md の作成後に削除を行う

---
**起票者**: L1
**起票日**: 2026-03-02
**ステータス**: 起票
