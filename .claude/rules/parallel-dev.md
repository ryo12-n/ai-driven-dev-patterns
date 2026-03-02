# worktree 並列開発ルール

## 目的

dev_manager が複数の専門ロールを git worktree ベースで並列起動する際のルール・制約・判断基準をまとめる。

本ルールは `roles/dev_manager.md` セクション4.1〜4.4 の並列オーケストレーションロジックおよび `roles/_base/common.md` セクション8 の worktree 共通ルールと連携して適用される。

---

## 1. 並列化の判断基準

### 1.1 並列起動の適用条件（すべて満たすこと）

1. **依存関係の不在**: 並列対象のロール間に入力→出力の依存関係がない
2. **ファイル分離の確認**: 並列対象のロールの書き込み先ファイルが完全に分離している
3. **所要時間短縮の見込み**: 並列化による効果がオーバーヘッドを上回る

### 1.2 並列起動の判断責任者

**dev_manager のみ** が並列起動の判断を行う。専門ロールが自律的に並列化を提案・実行することはない。

### 1.3 オプトイン方式

並列起動はデフォルトでは無効。dev_manager が明示的に選択した場合のみ適用する。判断根拠は `sessions/<session-name>/plan.md` に記録する。

---

## 2. 禁止事項

### 2.1 並列起動してはならないロールの組み合わせ

| 組み合わせ | 理由 |
|-----------|------|
| test_writer(TDD先行) + feature_builder | test_writer のテストが feature_builder の入力（直列依存） |
| 任意のロール + reviewer（同一タスク） | reviewer はロールの成果物を入力としてレビューする |
| documentarian + reviewer（同一シナリオ内） | reviewer は documentarian の成果物が入力 |
| 同一ファイルを対象とする任意のロール同士 | 書き込み競合が発生する |

### 2.2 worktree 環境での禁止操作

- 他の worktree ブランチへの `git checkout`, `git merge`, `git rebase`
- メインブランチへの直接マージ（dev_manager の責務）
- worktree の作成・削除（dev_manager の責務）
- `sessions/<session-name>/` 直下の dev_manager 管理ファイルの編集（各ロールは自身のサブディレクトリのみ編集可）

---

## 3. マージ戦略

### 3.1 マージ手順

1. dev_manager がメインブランチにチェックアウトする
2. 各 worktree ブランチを順にマージする（`git merge --no-ff`）
3. マージ後に全テストを実行して統合に問題がないことを確認する
4. 問題がなければ worktree ブランチを削除する

### 3.2 コンフリクト解決手順

並列化の前提条件（ファイル分離）が正しければコンフリクトは発生しないはずだが、万が一発生した場合:

1. コンフリクトの原因を特定する（前提条件の判断ミスか、想定外のファイル変更か）
2. 原因を `sessions/<session-name>/log.md` に記録する
3. コンフリクトを手動で解決する（両方のロールの変更を保持する方向で解決）
4. 解決後に全テストを実行する
5. 今後の並列化判断に反映するため、`sessions/<session-name>/issues.md` に課題として記録する

### 3.3 マージ後のテスト

マージ後は以下を確認する:

- 全テストスイートがパスすること
- 各ロールの成果物が相互に干渉していないこと
- セッション作業履歴（sessions/ 配下）に欠損がないこと

---

## 4. ブランチ命名規則

### 4.1 worktree ブランチ

```
worktree/<session-name>/<role-name>
```

例:
- `worktree/development_implement-login/feature_builder`
- `worktree/development_implement-login/test_writer`
- `worktree/refactoring_cleanup-auth/refactorer`

### 4.2 命名規則の制約

- `<session-name>` は `sessions/` 配下のセッションディレクトリ名と一致させる
- `<role-name>` は `roles/` 配下のロール定義ファイル名（拡張子なし）と一致させる
- 同一ロールが複数起動される場合は連番を付与する: `feature_builder_1`, `feature_builder_2`

---

## 5. 参照先

| 文書 | 内容 |
|------|------|
| `roles/dev_manager.md` セクション4 | 並列オーケストレーションロジック（判断フロー・実行手順・マージ戦略・フォールバック条件） |
| `roles/_base/common.md` セクション8 | worktree 環境での共通ルール（コミット規約・マージ前確認・禁止事項） |
| `docs/git-worktree-guideline.md` | worktree 並列開発ガイドライン（Stage 1〜3 の全体像） |

---

**作成日**: 2026-03-02
**関連施策**: git worktree による Claude 並列開発の標準化
