# タスクリスト: ロール定義フォーマット統一

## フェーズ1: フォーマットガイド作成

- [x] **T-001** `.claude/rules/role-format-guide.md` を新規作成する
  - 必須セクション定義（あなたの役割 / 作業フロー / やること / やらないこと）
  - 任意セクション定義（担当ファイル / 停止ルール）
  - セクション順序の明示
  - YAML フロントマターの使い方
  - 完了条件: ファイルが作成され、標準フォーマットが定義されている
  - 優先度: 高

## フェーズ2: `.claude/rules/*.md` への適用

- [x] **T-002** `dev-process-improvement/.claude/rules/l2-worker.md` に `## やること` / `## やらないこと` セクションを追加する
  - 完了条件: 両セクションが存在し、既存の責務内容と矛盾しない
  - 優先度: 高

- [x] **T-003** `dev-process-improvement/.claude/rules/l2-evaluator.md` に `## やること` / `## やらないこと` セクションを追加する
  - 完了条件: 両セクションが存在し、既存の責務内容と矛盾しない
  - 優先度: 高

- [x] **T-004** `dev-process-improvement/.claude/rules/triage.md` に `## やること` / `## やらないこと` セクションを追加する
  - 完了条件: 両セクションが存在し、既存の責務内容と矛盾しない
  - 優先度: 高

- [x] **T-005** `dev-process-improvement/.claude/rules/l1-manager.md` に `## やること` / `## やらないこと` セクションを追加する
  - 完了条件: 両セクションが存在し、既存の責務内容と矛盾しない
  - 優先度: 高

## フェーズ3: `roles/*.md` への適用

- [x] **T-006** `roles/` 配下の各ロールファイルに `## やること` セクションを追加する
  - 対象: bug_fixer.md, reviewer.md, feature_builder.md, refactorer.md, optimizer.md, test_writer.md, documentarian.md
  - 完了条件: 全ファイルに `## やること` セクションが存在する
  - 優先度: 中

## 課題転記タスク

- [x] **T-007** `07_issues.md` の未転記課題を確認し、施策をまたぐ課題を `プロセス改善_課題管理.csv` へ転記する
  - 完了条件: 全課題に `[転記済 ISS-XXX]` または「転記不要」の判断が付いている
  - 優先度: 高
