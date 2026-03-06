# 評価計画: .claude/ ディレクトリ用途最適化

## 壁打ちフェーズ [2026-03-06]

### 理解のサマリー
- 評価の目的: L2-worker が実施した rules/ → skills/ 移行の成果物が、01_plan.md の成功基準9項目をすべて満たしているかを検証する
- 評価スコープ: 移行先スキル（session-flow-policy, triage-standard-policy）のファイル内容・フロントマター、旧ファイルの削除、参照パスの更新、commit-message.md の誤移行なし、docs/workflow.md の更新
- 完了条件: 全9成功基準に対する合否判定が完了し、次フェーズへの推奨が記載されていること

### 前提条件チェック
- [x] 評価対象（04_work_report.md）の完成度: 十分
- [x] 評価基準（01_plan.md の成功基準）の明確さ: 評価可能
- [x] 評価に必要なツール・アクセス権限: 確認済み

### 不明点・確認事項
なし

### L1 確認結果
確認事項なし：評価開始

---

## 評価対象
- L2-worker のコミット `58921e4` で変更されたファイル群
- `.claude/skills/session-flow-policy/SKILL.md`（新規作成）
- `.claude/skills/triage-standard-policy/SKILL.md`（新規作成）
- `.claude/rules/session-flow-policy.md`（削除）
- `.claude/rules/triage-standard-policy-guideline.md`（削除）
- `.claude/skills/l1-manager/SKILL.md`（参照追記）
- `.claude/skills/triage-manager/SKILL.md`（参照パス更新）
- `.claude/skills/triage-manager/agents/triage-worker.md`（参照パス更新）
- `docs/workflow.md`（参照パス更新）

## 評価項目

| # | 評価項目 | 評価方法 | 判定基準（合格ライン） |
|---|---------|---------|---------------------|
| SC-1 | session-flow-policy の移行 | ファイル存在確認（新規 SKILL.md の存在 + 旧 rules/ の不在） | SKILL.md が存在し、旧ファイルが削除されている |
| SC-2 | triage-standard-policy の移行 | ファイル存在確認（新規 SKILL.md の存在 + 旧 rules/ の不在） | SKILL.md が存在し、旧ファイルが削除されている |
| SC-3 | YAML フロントマターの正確性 | 両 SKILL.md のフロントマターを読み取り確認 | `user-invocable: false` と具体的な `description` が設定されている |
| SC-4 | commit-message.md の保全 | rules/commit-message.md の存在確認 | rules/ に残っている |
| SC-5 | l1-manager への参照追記 | l1-manager SKILL.md 内の session-flow-policy 参照を grep で確認 | 参照が存在する |
| SC-6 | triage-manager への参照追記 | triage-manager SKILL.md 内の triage-standard-policy 参照を grep で確認 | 参照が存在する |
| SC-7 | 既存参照パスの更新 | triage-worker.md 内の旧パス参照を grep で確認 | 旧パスが存在せず、新パスに更新されている |
| SC-8 | docs/workflow.md の更新 | docs/workflow.md 内の参照を grep で確認 | 新パスに更新されている |
| SC-9 | スキル本文の同一性 | git diff で旧ファイルと新ファイルを比較 | YAML フロントマターの変更と本文内の旧パス参照更新を除き、内容が同一 |

## 評価スケジュール
- 即時実施（単一フェーズ）

## 前提・制約
- 評価はファイルの直接確認と git diff による差分検証で行う
- `.claude/` 配下および `docs/` の旧パス参照残存確認は grep で網羅的に行う

---
**作成者**: L2（評価）
**作成日**: 2026-03-06
