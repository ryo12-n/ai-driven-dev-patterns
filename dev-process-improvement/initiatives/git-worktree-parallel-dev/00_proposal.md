# 改善施策提案: git worktree による Claude 並列開発の標準化

## 背景・課題

`ai-driven-dev-patterns` リポジトリのルートディレクトリには、dispatcher → dev_manager → 7ロール（feature_builder, test_writer, reviewer, bug_fixer, refactorer, optimizer, documentarian）による開発ワークフローが整備されている。

現在の課題:
1. **逐次実行のみ**: dev_manager が各ロールを順番に起動するため、独立性の高いタスク（例: feature_builder と test_writer の TDD 分離時、reviewer の独立レビュー）でも直列実行となる
2. **隔離メカニズムの未実装**: Claude Code の `isolation: "worktree"` 機能が利用可能であるにも関わらず、開発ワークフローに組み込まれていない
3. **ガイドラインと実装のギャップ**: 前回施策（`git-worktree-standardization`）でガイドライン（`docs/git-worktree-guideline.md`）を作成済みだが、「参考情報」の位置づけに留まっており、ルール・設定・スクリプトへの落とし込みが未完了

## 目標

ガイドラインの Stage 2（独立タスクの並列化）を実装し、ルートディレクトリの開発ワークフローで worktree ベースの並列開発を標準利用できる状態にする。

具体的な達成基準:
1. dev_manager が worktree を使って複数ロールを並列起動できるオーケストレーションロジックが定義されている
2. 並列実行対象のロール定義に `isolation: worktree` が適切に設定されている
3. セッション管理（`sessions/` 構造）が並列実行に対応している
4. マージ・コンフリクト解決の手順が明文化されている
5. 開発者がすぐに利用できる設定ファイル・スクリプトが揃っている

## スコープ

### やること
- ルートディレクトリの開発ワークフロー（`roles/`, `.claude/`, `sessions/`）に worktree 並列化を組み込む
- dev_manager ロール定義の更新（並列オーケストレーション対応）
- 並列実行対象ロールの特定と `isolation: worktree` 設定の追加
- セッションディレクトリ構造の並列対応設計
- マージ戦略・コンフリクト解決手順の定義
- `.claude/rules/` への並列開発ルール追加
- `.claude/settings.json` の必要な更新
- 既存ガイドライン（`docs/git-worktree-guideline.md`）の実装反映による更新

### やらないこと
- `dev-process-improvement/` の L1/L2 ワークフローの変更（メタフレームワークは対象外）
- Stage 3（高度な並列化 + 協調プロトコル）の実装（スコープ外）
- ロックベース方式の実装（worktree 方式に集中）
- Agent Teams 機能の調査・実装（別施策として切り出し済み: ISS-013）
- 新規ロールの追加や既存ロールの機能変更

## 期待される効果

1. **開発効率の向上**: 独立タスクの並列実行により、セッション全体の所要時間を短縮
2. **変更の安全な分離**: worktree による物理的隔離で、ロール間のファイル競合リスクをゼロに
3. **標準パターンの確立**: 開発者が迷わずに並列開発を開始できる設定・手順・テンプレートの整備
4. **段階的導入の基盤**: Stage 3 への移行に必要なインフラ基盤の構築

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| Claude Code の worktree 仕様が変更される | 中 | バージョン依存の前提を文書化し、変更追従の手順を明記 |
| 並列実行時のマージコンフリクト頻度が想定以上 | 中 | ロール間のファイル所有権ルールを厳格化し、コンフリクト発生パターンを事前分析 |
| worktree 作成のオーバーヘッドが実用上問題になる | 低 | 判断基準を設け、オーバーヘッドが利点を上回る場合は逐次実行にフォールバック |
| 既存のロール定義・設計書との整合性が崩れる | 中 | 既存の設計書を丁寧に読み込み、変更箇所を最小限に抑える |

## 壁打ちの背景

### 意思決定の経緯

1. **スコープの確定**: `ai-driven-dev-patterns` ルートディレクトリの開発フローが対象。`dev-process-improvement` は独立したメタフレームワークであり、将来的に別リポジトリとして切り出す計画がある。よって今回は dev-process-improvement の L1/L2 ワークフローには手を入れない。

2. **前回施策との関係**: 前回の `git-worktree-standardization` は調査・ガイドライン作成フェーズ（Stage 1）。今回は Stage 2 の実装フェーズとして、ガイドラインを実際のルール・設定・スクリプトに落とし込む。

3. **成果物の方向性**: ドキュメント（ルール定義、ガイドライン更新）+ 実装（設定ファイル、テンプレート、スクリプト）の両方を含む。

4. **バックログ「並列開発の仕組み実装」との関係**: 今回の成果を踏まえて統合するか別施策として残すかを判断する。

## 備考・設計パターン

### 前提バージョン
- Claude Code: 2026年2月〜3月時点の仕様に基づく
- `isolation: "worktree"` はカスタムサブエージェント（`.claude/agents/*.md`）の YAML frontmatter で設定可能

### 参照資料
- `docs/git-worktree-guideline.md` — 前回施策のガイドライン成果物
- `docs/coordination-protocol-guideline.md` — 協調プロトコルガイドライン
- `docs/design/dev-workflow-detail.md` — 開発ワークフロー内部設計
- `docs/design/session-flow-foundations.md` — セッションフロー基盤設計
- `docs/design/session-flow-advanced.md` — 高度なセッション設計（ハイブリッドレビュー等）
- `roles/_base/common.md` — 全ロール共通ルール
- `roles/dev_manager.md` — dev_manager ロール定義

---
**起票者**: L1
**起票日**: 2026-03-02
**ステータス**: 実施中
