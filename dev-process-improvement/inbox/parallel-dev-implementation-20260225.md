# 提案: 並列開発の仕組み実装

## 起票日
2026-02-25

## 起票元
施策1（git worktree 標準化）・施策2（協調プロトコル整備）のゲート判定完了時

## 背景

以下2つのガイドラインが作成済みであり、並列開発の設計基盤が整った。

- `docs/git-worktree-guideline.md` — worktree 運用の3段階ロードマップ（ステージ1〜3）
- `docs/coordination-protocol-guideline.md` — commit/lock/test 3プロトコルの設計、3層ロック方式、段階的導入4ステップ

現在は順次実行ワークフローで運用しており、並列開発は未実装。ガイドラインの設計を実際の仕組みとして実装し、段階的に並列化を進める必要がある。

## 実装候補（優先度順）

### 1. コミットメッセージ規約のルール反映（ISS-014）
- 協調プロトコルガイドラインで定義した `[session-type] initiative: summary` 形式を `.claude/rules/` に反映
- 即時適用可能。並列化の前提となる基盤整備

### 2. テストスクリプト整備
- `ci/run_fast.sh`（YAML/Markdown 構文チェック）・`ci/run_full.sh`（リンク切れ検出等）の実装
- 協調プロトコルガイドラインのステップ2に対応

### 3. worktree ステージ2 移行（限定的並列実行）
- L1 + L2×2 の構成で worktree を使った並列実行を試行
- テスト結果集約方法の定義（EVL-002）が前提
- worktree ガイドラインのステージ2に対応

### 4. Agent Teams 機能の調査・統合検討（ISS-013）
- Claude Code の Agent Teams 機能と worktree/協調プロトコルの組み合わせパターンを検討
- worktree ガイドラインのステージ3に対応

## 関連課題

| ID | 内容 | 出典 |
|----|------|------|
| ISS-013 | Agent Teams 機能への言及不足 | 施策1 評価 |
| ISS-014 | ルールファイルへの組み込みパスが曖昧 | 施策2 評価 |
| EVL-001 | 施策外コミットのカバー不足 | 施策2 評価 |
| EVL-002 | テスト結果集約方法の未定義 | 施策2 評価 |
| EVL-004 | 層3ロックの Task ツール環境での実現性懸念 | 施策2 評価 |

## 参照ドキュメント

- `docs/git-worktree-guideline.md`
- `docs/coordination-protocol-guideline.md`
- `dev-process-improvement/initiatives/worktree-standardization/08_gate_review.md`
- `dev-process-improvement/initiatives/coordination-protocol/08_gate_review.md`

## 処理指示

次回トリアージセッションで優先度を判定し、backlog への登録・施策化を検討すること。
特に ISS-014（コミットメッセージ規約のルール反映）は即時着手可能なため、早期の施策化を推奨する。
確認・対応完了後はこのファイルを削除する（git 履歴が証跡）。
