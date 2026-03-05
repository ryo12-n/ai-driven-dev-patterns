# リンク実在性チェックの標準化

## 知見

ドキュメント評価時に全リンクのファイル実在確認を機械的に行うチェックリスト項目を標準化すると、評価の漏れと工数を同時に削減できる。

## 背景

organize-readme 施策の評価で README 17件 + session-guide 14件のリンクを手動確認した。スクリプト化またはチェックリスト化すれば次回以降の効率が上がる。

## 対応案

- .claude/rules/ に「ドキュメント変更時はリンク整合性を確認する」ルールを追加
- または hooks/ でドキュメント変更時に自動リンクチェックを実行

## 情報源

- `dev-process-improvement/initiatives/_archive/organize-readme/06_eval_report.md` 評価中の知見 #1
