# worktree 環境での共通ルール

dev_manager が並列起動を選択した場合、各専門ロールは worktree（独立した作業ツリー）上で実行される。以下のルールは worktree 環境で動作するすべてのロールに適用される。

---

## 1. ブランチ命名規則

worktree 環境で作業する場合、dev_manager から指示されたブランチ名を使用する。

- 形式: `worktree/<session-name>/<role-name>`
- 例: `worktree/development_implement-login/feature_builder`

ロール自身がブランチを作成することはない。ブランチの作成と管理は dev_manager の責務である。

## 2. worktree 上でのコミット規約

通常のコミット規約（`.claude/rules/commit-message.md`）に加え、以下を遵守する:

- **コミットメッセージの footer** に worktree ブランチ名を含める（トレーサビリティ確保）
  ```
  feat(src): ユーザー認証パターンを追加

  JWT 認証の実装パターンを追加

  DT-001
  Branch: worktree/development_implement-login/feature_builder
  ```
- **こまめにコミットする**: worktree 上のコミットはマージ前に squash される可能性があるが、作業途中のコミットは歓迎される。コンテキスト枯渇時の復旧を容易にするため、作業の区切りごとにコミットする

## 3. マージ前の確認事項

worktree 上で作業を完了する際、以下を確認してから完了報告を行う:

1. **全テストの通過**: worktree 上で `tests/` のテストがすべてパスすること
2. **対象外ファイルへの変更がないこと**: dev_manager から指示された対象ファイル以外を変更していないこと
3. **コミットの整理**: 不要な中間コミット（デバッグ用変更等）がないこと

## 4. worktree 環境での禁止事項

- **他の worktree ブランチへの干渉禁止**: 自分の worktree ブランチ以外のブランチに対して `git checkout`, `git merge`, `git rebase` を行わない
- **メインブランチへの直接マージ禁止**: マージは dev_manager が行う。ロールはマージ操作を行わない
- **worktree の削除禁止**: worktree の作成・削除は dev_manager の責務

## 5. 逐次実行時との違い

worktree 環境で動作していても、作業手順（`.claude/rules/agent-common-workflow.md` の基本的な作業ループ）は同一である。違いは以下のみ:

- 作業ディレクトリが worktree のパスになる
- コミットは worktree ブランチに対して行われる
- 完了報告後のマージは dev_manager が行う
