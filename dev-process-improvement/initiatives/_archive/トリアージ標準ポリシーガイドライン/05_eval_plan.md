# 評価計画: トリアージ標準ポリシーガイドライン

## 壁打ちフェーズ [2026-03-05 12:00]

### 理解のサマリー
- 評価の目的: L2-worker が作成した成果物（ガイドライン文書、triage-manager.md / triage-worker.md / workflow.md の更新）が 01_plan.md の成功基準4項目を満たしているかを客観的に評価する
- 評価スコープ: 成功基準 SC-1〜SC-4 に対する達成度評価、07_issues.md の実施ワーカー未転記課題確認、知見の記録（T-E01）、CSV転記（T-E02）
- 完了条件: 06_eval_report.md に評価結果・知見・推奨事項が記載され、07_issues.md の未転記確認結果が記載され、T-E02 の CSV 転記が完了していること

### 前提条件チェック
- [x] 評価対象（04_work_report.md）の完成度: 十分（全7タスク完了、サマリ・タスク実績・成果物一覧・知見セクションが揃っている）
- [x] 評価基準（01_plan.md の成功基準）の明確さ: 評価可能（4項目とも具体的で判定可能）
- [x] 評価に必要なツール・アクセス権限: 確認済み（全評価対象ファイルが読み取り可能）

### 不明点・確認事項
なし

### L1 確認結果
確認事項なし：評価開始

---

## 評価対象
- `dev-process-improvement/docs/triage-standard-policy-guideline.md` — ガイドライン文書（SC-1）
- `dev-process-improvement/.claude/rules/triage-manager.md` — TG-008 追加（SC-2）
- `dev-process-improvement/.claude/rules/triage-worker.md` — TG-008 走査手順追加（SC-3）
- `dev-process-improvement/docs/workflow.md` — TG-008 反映（SC-4）
- `dev-process-improvement/initiatives/トリアージ標準ポリシーガイドライン/04_work_report.md` — 作業レポート
- `dev-process-improvement/initiatives/トリアージ標準ポリシーガイドライン/07_issues.md` — 課題メモ

## 評価項目

| # | 評価項目 | 評価方法 | 判定基準（合格ライン） |
|---|---------|---------|---------------------|
| SC-1 | ガイドライン文書の存在とカバレッジ | `docs/triage-standard-policy-guideline.md` を読み、6セッションタイプ全てのライフサイクルステージがカバーされているか確認 | ファイルが存在し、L1/L2-worker/L2-evaluator/triage-mgr/triage-worker/triage-evaluator の6タイプ全てが適用マトリクスに含まれている |
| SC-2 | TG-008 の triage-manager.md への追加 | `triage-manager.md` を読み、TG-008 エントリの存在・チェック範囲・アクションの明確さを確認 | TG-008 エントリが存在し、チェック範囲（ロール定義・セッションルールの準拠確認）とアクション（CSV起票の重大度別対応）が明記されている |
| SC-3 | TG-008 走査手順の triage-worker.md への追加 | `triage-worker.md` を読み、走査対象ファイル・確認項目・不適合時アクション・CSV起票の記載を確認 | 走査対象ファイル一覧、確認項目（カテゴリ別）、不適合時のアクション（CSV起票）が記載されている |
| SC-4 | workflow.md の TG-008 反映 | `docs/workflow.md` を読み、TG-008 の記載があること、triage-manager.md / triage-worker.md との整合性を確認 | workflow.md のトリアージフローに TG-008 の記載があり、ルールファイルと整合している |

## 評価スケジュール
- SC-1〜SC-4 を順に評価
- 07_issues.md の未転記課題確認
- 06_eval_report.md に評価結果・知見を記載
- T-E02: CSV 転記の確認・実行

## 前提・制約
- 実施ワーカーの成果物（03_work_log.md、04_work_report.md）は直接修正しない
- L1 の成果物（00, 01, 02, 08）は編集しない

---
**作成者**: L2（評価）
**作成日**: 2026-03-05
