# トリアージ事前調査: 2026-02-25

<!-- 実施前にこのテンプレートを埋めること。調査結果を 01_plan.md の判断材料とする。 -->

## inbox 確認

- [x] 未処理アイテム数：5 件
- [x] 最古アイテムの日付：2026-02-24（triage-handoff-20260224.md、ref_ai-driven-development-poc.md）
- [x] 注目すべきアイテム（タイトル列挙）：
  - `triage-handoff-20260224.md` — 前回トリアージからの申し送り（3項目）
  - `gitworktreeによるクロードの開発を標準として採用できるか検討する.md` — 新規。worktree 活用の検討提案
  - `デビンにもクロードと同じルールに従わせたい.md` — 新規。Devin へのルール適用方法の整理
  - `ボリスのclaudeルールを採用する.md` — 新規。外部のClaude運用ベストプラクティスの取り込み
  - `ref_ai-driven-development-poc.md` — 前回作成済みの参照物ポインター（参照のみ保持）

## backlog 確認

- [x] 総件数：5 件（テンプレート除く）
- [x] 優先度 🔴（高）：0 件
- [x] 優先度未設定：0 件
- [x] ステータス「候補」のまま放置（30日以上）：0 件（全件 2026-02-25 起票）
- [x] 特記事項：
  - 前回トリアージ（2/24）で提案された 6 施策のうち、2件は直接 initiative 化（readme-improvement, backlog-operation-improvement）されて既に完了
  - 「openspec × 実コード実装の試験運用」が backlog に登録されていない（未登録 or 却下？要確認）

## 課題管理 CSV 確認（プロセス改善_課題管理.csv）

- [x] ステータス「起票」（未対応）：0 件
- [x] ステータス「未対応」：1 件（ISS-006）
- [x] 最古の未対応課題：ISS-006 (2026-02-23) — ロール定義と OpenSpec 開発ライフサイクルの統合が未定義
- [x] 特記事項：
  - ISS-001〜004: クローズ（openspec-process-integration 完了）
  - ISS-005: 対応済（l2-evaluator・l1-manager にCSV転記ルール追記）
  - ISS-007: クローズ（テンプレート修正で即対応済）
  - ISS-006 は「OpenSpec 開発ライフサイクル定義後に別施策として対応」方針だが着手条件が未達

## 進行中 initiative 確認

- [x] 進行中：1 件
  - `dev-setup-knowledge`: フェーズ1完了・ゲート通過済、フェーズ2（L2-evaluator による動作検証）未着手
- [x] ブロック中：0 件
- [x] 完了済：4 件
  - `openspec-process-integration`: 完了・クローズ（2026-02-23）
  - `role-agent-prompts`: 完了・クローズ（2026-02-23）
  - `readme-improvement`: 完了・クローズ（2026-02-25）
  - `backlog-operation-improvement`: 完了・クローズ（2026-02-25）

## collab-log 確認（docs/collab-log.md）

- [x] 未蒸留エントリ：1 件（保留）
- [x] 蒸留候補のエントリ（タイトル列挙）：
  - 気づき3（2026-02-23）: OpenSpec v1.1.1 アーキテクチャ変更に伴うバージョン依存前提の明示 — ステータス「保留」。前回トリアージで 00_proposal.md テンプレートに備考セクション追加・ISS-007 起票済み。より具体的な運用ルール化が残課題

## ルール・workflow 整合性確認（.claude/rules/*.md ↔ docs/workflow.md）

- [x] 乖離あり（以下に詳細）

### 重大な乖離（HIGH）

| # | 内容 | 影響 |
|---|------|------|
| 1 | **壁打ちフェーズ（フェーズ0）が workflow.md に未記載** — l1-manager / l2-worker / l2-evaluator で必須とされている壁打ちフェーズが workflow.md に一切記載されていない | workflow.md のみ参照するとフェーズ0をスキップしうる |
| 2 | **L2 サブエージェント起動の詳細が未記載** — l1-manager.md で「L2はサブエージェント（Taskツール）として順番に起動する」と明記されているが、workflow.md では L2 の起動方法が不明 | L1 がどのようにL2を管理するかが分からない |
| 3 | **固定タスク要件が未記載** — l1-manager.md で `02_tasks.md` に必ず含めるべき固定タスク（CSV転記）が定められているが、workflow.md に記載なし | タスクリスト作成時にCSV転記タスクが漏れる |

### 中程度の乖離（MEDIUM）

| # | 内容 |
|---|------|
| 4 | ルール・workflow 整合性チェック要件がトリアージの workflow.md 記述で強調されていない |
| 5 | ファイル所有権テーブルの記号体系が rules と workflow.md で微妙に異なる |
| 6 | L1 の CSV 更新責務（07_issues.md 経由）が workflow.md で曖昧 |
| 7 | L1 の判断根拠記録場所（03_work_log.md）が workflow.md に未記載 |

### 軽微な乖離（LOW）

| # | 内容 |
|---|------|
| 8 | refs/ 孤立エントリ処理の手順が workflow.md で不十分 |

## 前回トリアージからの変化

- 前回実施日：2026-02-24
- inbox 増減：+3 件（新規3件追加。前回の申し送り1件 + ref ポインター1件は残存）
- backlog 増減：+5 件（前回提案の施策が承認・登録された）
- 完了施策：+3 件（readme-improvement, role-agent-prompts, backlog-operation-improvement が 2/23〜2/25 に完了）
- 新規課題：0 件

## 調査サマリ・今回の重点

<!-- 上記を踏まえ、今回トリアージで特に注力すべき点を記載する -->

- 重点1：**申し送り事項の処理** — triage-handoff-20260224.md の3項目（dev-setup-knowledge 状況確認、backlog 登録確認、collab-log 保留再評価）を処理する
- 重点2：**新規 inbox 3件の処理** — worktree 活用、Devin ルール適用、Boris ルール採用の3件を評価し、backlog 候補化 or 却下を判断する
- 重点3：**ルール・workflow 乖離への対応** — 壁打ちフェーズ・L2起動詳細・固定タスク要件の3つの重大乖離を修正する（中程度・軽微はCSV起票して次回以降）

---
**調査者**: トリアージセッション
**調査日**: 2026-02-25
