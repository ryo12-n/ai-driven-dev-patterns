# トリアージ事前調査: 2026-02-22

<!-- 実施前にこのテンプレートを埋めること。調査結果を 01_plan.md の判断材料とする。 -->

## inbox 確認

- [x] 未処理アイテム数：3 件
- [x] 最古アイテムの日付：2026-02-22
- [x] 注目すべきアイテム（タイトル列挙）：
  - `ref_parallel-agent-poc.md`（パラレルエージェントPOC の参照物ポインター）
  - `triage_manager_worker_idea.md`（トリアージのマネージャー・ワーカー構成化アイデア）
  - `openspec_process_improvement.md`（AI生成の OpenSpec 解説コンテンツ）

## backlog 確認

- [x] 総件数：0 件（実質空・プレースホルダーのみ）
- [x] 優先度 🔴（高）：0 件
- [x] 優先度未設定：0 件
- [x] ステータス「候補」のまま放置（30日以上）：0 件
- [x] 特記事項：backlog は初期状態。施策候補は inbox から今回初めて登録予定

## 課題管理 CSV 確認（プロセス改善_課題管理.csv）

- [x] ステータス「起票」（未対応）：4 件（ISS-001〜004）
- [x] ステータス「方針確定」（未タスク化）：0 件
- [x] 最古の未対応課題：ISS-001 (2026-02-21)
- [x] 特記事項：全件 openspec-process-integration 施策のツール知見。全件に対応方針案あり。openspec/AGENTS.md 作成タスク（T-003）への組み込みで一括対応可能

## 進行中 initiative 確認

- [x] 進行中：1 件
  - 施策名・フェーズ：openspec-process-integration（フェーズ1A・全タスク ⬜ 未着手）
- [x] ブロック中：0 件

## collab-log 確認（docs/collab-log.md）

- [x] 未蒸留エントリ：0 件（空）

## ルール・workflow 整合性確認（.claude/rules/*.md ↔ docs/workflow.md）

- [x] 乖離あり（軽微 × 2）：
  - `workflow.md` Step1 に collab-log 確認が記載されていない（`triage.md` には明記済み）
  - `triage/_template/00_pre_investigation.md` に collab-log 確認セクションがない
  → 今回セッション内で修正する

## refs/ 孤立エントリ確認

- [x] `refs/ai-driven-development-poc/` が存在
  - 対応する `inbox/ref_parallel-agent-poc.md` あり（ファイル名と refs 名は異なるが `参照先` フィールドで紐付き）
  - → 孤立エントリなし

## 前回トリアージからの変化

- 前回実施日：なし（初回）
- inbox 増減：+3 件
- backlog 増減：0 件
- 完了施策：なし
- 新規課題：ISS-001〜004（openspec-process-integration 施策内で既に起票済み）

## 調査サマリ・今回の重点

- 重点1：inbox 3件の全件処理（分類・判断）
- 重点2：CSV ISS-001〜004 の対応方針確定（ステータス更新）
- 重点3：rules/workflow の軽微な乖離を今回セッション内で修正

---
**調査者**: トリアージセッション
**調査日**: 2026-02-22
