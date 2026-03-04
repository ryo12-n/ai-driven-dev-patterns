# 「関連ファイル一覧」セクションの他ルールファイルへの横展開

## 概要

施策 workflow-doc-consistency-fix で triage-manager.md に「関連ファイル一覧」セクションを追加した。このパターンを l1-manager.md, l2-worker.md, l2-evaluator.md 等の他のルールファイルにも適用し、ルール変更時の連動更新漏れを体系的に防止する。

## 背景

- ISS-029 への対応として triage-manager.md に導入
- backlog-relationship-analysis 施策で実施ワーカーと評価ワーカーが独立して同一の知見に到達しており、パターンの重要性が裏付けられている
- triage-manager.md の3分割構成（manager/worker/evaluator）との親和性が高い

## 検討ポイント

- 各ルールファイルごとに連動更新対象ファイルを洗い出す必要がある
- テンプレート（initiatives/_template/）への影響も含める
- docs/workflow.md はほぼ全てのルールファイルの連動対象になりうる

## ソース

- 施策: workflow-doc-consistency-fix の 04_work_report.md（参考情報 #2）
- 関連 CSV: ISS-029
