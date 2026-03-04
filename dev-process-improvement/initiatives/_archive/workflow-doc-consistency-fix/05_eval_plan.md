# 評価計画: workflow-doc-consistency-fix

## 壁打ちフェーズ [2026-03-04 12:00]

### 理解のサマリー
- 評価の目的: L2-worker が実施した workflow.md ドキュメント整合性修正（ISS-008〜012, ISS-024, ISS-029, ISS-030 の8課題）の成果物が、01_plan.md の成功基準 SC-1〜SC-5 を満たしているかを検証する
- 評価スコープ: SC-1〜SC-5 の全5基準。実際のファイルを読んで Source of Truth と突合する
- 完了条件: 各成功基準の達成/未達成が明確に判定され、06_eval_report.md に記載されていること

### 前提条件チェック
- [x] 評価対象（04_work_report.md）の完成度: 十分（全12タスク完了報告あり、知見セクション・課題セクション記載あり）
- [x] 評価基準（01_plan.md の成功基準）の明確さ: 評価可能（SC-1〜SC-5 ともに検証方法が明記されている）
- [x] 評価に必要なツール・アクセス権限: 確認済み（Read, Grep, Bash ツールで全対象ファイルにアクセス可能）

### 不明点・確認事項
なし

### L1 確認結果
確認事項なし：評価開始

---

## 評価対象
L2-worker の成果物（04_work_report.md に記載の修正ファイル群）を、01_plan.md の成功基準 SC-1〜SC-5 に照らして検証する。

## 評価項目

| # | 評価項目 | 評価方法 | 判定基準（合格ライン） |
|---|---------|---------|---------------------|
| 1 | SC-1: ISS-008〜012 の乖離解消 | workflow.md と各 rules/*.md（l1-manager.md, l2-worker.md, l2-evaluator.md, triage-manager.md）の記述を突合し、一致を確認。T-003/T-004/T-005 が「既に対応済み」との報告が妥当か workflow.md を確認 | 5課題すべてについて workflow.md と rules の記述が整合していること |
| 2 | SC-2: ISS-024 の L1 参照置換 | dev-workflow-detail.md 内で「施策管理 L1」「L1」（ロールとしての参照）を grep し、残存が0件であることを確認 | dev-workflow-detail.md 内に「施策管理 L1」参照が0件 |
| 3 | SC-3: ISS-029 関連ファイル一覧追加 | triage-manager.md に「関連ファイル一覧」セクションが存在し、連動更新対象ファイルが列挙されていることを確認 | triage-manager.md に「関連ファイル一覧」セクションが存在すること |
| 4 | SC-4: ISS-030 collab-log 参照更新と削除 | (a) dev-process-improvement 配下で collab-log を grep し、能動的参照が0件であることを確認（アーカイブ・バックログ・triage 過去ログは除外）。(b) collab-log.md が存在しないことを確認 | collab-log 能動的参照0件、かつ collab-log.md が存在しない |
| 5 | SC-5: CSV ステータス更新 | プロセス改善_課題管理.csv の ISS-008〜012, ISS-024, ISS-029, ISS-030 のステータスが「施策化」以降であることを確認 | 対象8件すべてが「施策化」以降のステータス |

## 評価スケジュール
- SC-1〜SC-5 を順番に検証し、06_eval_report.md に結果を記載する

## 前提・制約
- SC-4 の「collab-log 参照が0件」は能動的な運用参照のみが対象（アーカイブ、バックログ内の記述、past triage ログ内の記述は除外）
- triage ルールは triage-manager.md, triage-worker.md, triage-evaluator.md の3分割構成
- L2-worker の 04_work_report.md で「T-003/T-004/T-005 は既に対応済み」と報告されている。これが妥当か実際に workflow.md を確認する

---
**作成者**: L2（評価）
**作成日**: 2026-03-04
