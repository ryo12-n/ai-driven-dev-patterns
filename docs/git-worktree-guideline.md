# git worktree 並列開発ガイドライン

> **位置づけ**: 実装済みパターン（Stage 2 完了）
>
> 本ドキュメントは `ai-driven-dev-patterns` リポジトリの開発ワークフローにおける git worktree ベースの並列開発のガイドラインである。Stage 1（調査・ガイドライン策定）を経て、Stage 2（独立タスクの並列化）が実装済みとなっている。

---

## 1. 概要

### 1.1 目的

Claude Code の `isolation: "worktree"` 機能を活用し、dev_manager が複数の専門ロールを物理的に分離された worktree 上で並列起動することで、開発セッション全体の所要時間を短縮する。

### 1.2 基本方針

- **オプトイン方式**: 並列起動はデフォルト無効。dev_manager が明示的に選択した場合のみ適用する
- **逐次実行との後方互換性**: 並列化は既存の逐次実行ワークフローを拡張するものであり、逐次実行パスは一切変更しない
- **安全性優先**: ファイル分離が確認できない場合は逐次実行にフォールバックする

---

## 2. Stage 定義と進捗

| Stage | 内容 | ステータス |
|-------|------|-----------|
| Stage 1 | 調査・ガイドライン策定 | 完了 |
| Stage 2 | 独立タスクの並列化 | **完了** |
| Stage 3 | 高度な並列化 + 協調プロトコル | 未着手 |

### 2.1 Stage 1: 調査・ガイドライン策定（完了）

- worktree の基本概念と Claude Code の `isolation: "worktree"` 仕様の調査
- 並列開発パターンの類型化（Hub-and-spoke、Pipeline、Independent workers）
- 本ガイドラインの初版を作成

### 2.2 Stage 2: 独立タスクの並列化（完了）

- ロール間の依存関係分析（5シナリオ全て）
- 並列化可能パターンの特定（後処理並列・独立モジュール並列・品質改善並列）
- dev_manager への並列オーケストレーションロジックの実装
- 全ロール共通ルールへの worktree 環境ルール追加
- `.claude/rules/parallel-dev.md` の作成
- セッションテンプレートの並列実行対応

**実装成果物**:
- `roles/dev_manager.md` セクション 4.1〜4.4（並列起動の判断・実行・マージ・フォールバック）
- `roles/_base/common.md` セクション 8（worktree 環境での共通ルール）
- `.claude/rules/parallel-dev.md`（並列開発ルール）
- `sessions/_template/plan.md`（並列実行計画テンプレート）
- `sessions/_template/log.md`（並列実行ログテンプレート）
- `sessions/_template/report.md`（並列実行統合レポートテンプレート）

### 2.3 Stage 3: 高度な並列化 + 協調プロトコル（未着手）

- 同一シナリオ内での実装並列化（例: 複数 feature_builder の同時起動）
- ロール間の協調プロトコル（進捗共有・依存解決）
- Agent Teams 機能との統合検討

---

## 3. 並列化可能パターン

### 3.1 パターン一覧

| パターン | シナリオ | 並列ロール | 前提条件 | ファイル競合リスク |
|---------|---------|-----------|---------|-----------------|
| 後処理並列 | シナリオ2（開発） | test_writer(拡充) + documentarian | レビュー合格後の後処理 | 低（tests/ vs docs/） |
| 独立モジュール並列 | シナリオ2（開発） | 複数の同一ロール（例: feature_builder x2） | 対象ファイルが完全分離 | 低（前提条件による） |
| 品質改善並列 | シナリオ5（リファクタリング・最適化） | refactorer + optimizer | 対象ファイルが異なる | 中（確認が必要） |

### 3.2 並列起動不可の組み合わせ

| 組み合わせ | 理由 |
|-----------|------|
| test_writer(TDD先行) + feature_builder | test_writer のテストが feature_builder の入力（直列依存） |
| 任意のロール + reviewer（同一タスク） | reviewer はロールの成果物を入力としてレビューする |
| documentarian + reviewer（同一シナリオ内） | reviewer は documentarian の成果物が入力 |
| 同一ファイルを対象とする任意のロール同士 | 書き込み競合が発生する |

---

## 4. worktree 運用ルール

### 4.1 ブランチ命名規則

```
worktree/<session-name>/<role-name>
```

例:
- `worktree/development_implement-login/feature_builder`
- `worktree/development_implement-login/test_writer`
- `worktree/refactoring_cleanup-auth/refactorer`

同一ロールが複数起動される場合は連番を付与する: `feature_builder_1`, `feature_builder_2`

### 4.2 コミット規約

- worktree ブランチ上のコミットメッセージの footer にブランチ名を含める
- こまめなコミットを推奨（マージ時の競合解決を容易にするため）

### 4.3 マージ手順

1. dev_manager がメインブランチにチェックアウトする
2. 各 worktree ブランチを順にマージする（`git merge --no-ff`）
3. マージ後に全テストを実行して統合に問題がないことを確認する
4. 問題がなければ worktree ブランチを削除する

### 4.4 禁止事項

- 他の worktree ブランチへの `git checkout`, `git merge`, `git rebase`
- メインブランチへの直接マージ（dev_manager の責務）
- worktree の作成・削除（dev_manager の責務）
- `sessions/<session-name>/` 直下の dev_manager 管理ファイルの編集

---

## 5. 判断フロー

dev_manager がロール起動計画策定時に以下のフローで並列化を判断する。

```
1. ロール起動計画を策定する
2. 起動予定のロール群に並列化パターンの該当があるか確認する
3. 該当する場合:
   a. 書き込み先ファイルの分離を確認する
   b. 分離が確認できた場合 → 並列起動を選択し、plan.md に判断根拠を記録する
   c. 分離が不明確な場合 → 逐次起動にフォールバックする
4. 該当しない場合 → 逐次起動する
```

### フォールバック条件

以下のいずれかに該当する場合は逐次起動にフォールバックする:

- 書き込み先ファイルの分離が確認できない
- 並列対象のロール数が1つ
- 対象タスクが小規模で、並列化のオーバーヘッドが利点を上回る（変更ファイル数 2 以下が目安）
- dev_manager が並列化のリスクが高いと判断した場合

---

## 6. 関連ドキュメント

| 文書 | 内容 |
|------|------|
| `roles/dev_manager.md` セクション 4 | 並列オーケストレーションロジック（判断フロー・実行手順・マージ戦略・フォールバック条件） |
| `roles/_base/common.md` セクション 8 | worktree 環境での共通ルール（コミット規約・マージ前確認・禁止事項） |
| `.claude/rules/parallel-dev.md` | 並列開発ルール（判断基準・禁止事項・マージ戦略・ブランチ命名規則） |
| `sessions/_template/plan.md` | 並列実行計画テンプレート |
| `sessions/_template/log.md` | 並列実行ログテンプレート |
| `sessions/_template/report.md` | 並列実行統合レポートテンプレート |
| `docs/design/dev-workflow-detail.md` | 開発ワークフロー内部設計（ロール定義・シナリオ別フロー） |
| `docs/design/session-flow-scenarios.md` | セッションフローシナリオ設計（5シナリオ定義） |

---

**作成日**: 2026-03-02
**関連施策**: git-worktree-standardization（Stage 1）、git-worktree-parallel-dev（Stage 2）
**前提バージョン**: Claude Code 2026年2月〜3月時点の仕様
