# 実施計画: トリアージ情報欠損リスク評価ステップ追加

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | triage-manager / triage-worker / triage-evaluator のルール定義変更 + docs/workflow.md 更新 | 全変更対象ファイルが整合的に更新されている |

## 成功基準（全体）

1. triage-worker.md に TG-009（情報欠損リスク評価）の走査手順が追加されている
2. triage-manager SKILL.md にリスク評価のディスパッチフローが追加されている
3. triage-evaluator.md にリスク評価の評価基準が追加されている
4. docs/workflow.md のフロー記述が更新されている
5. triage-manager SKILL.md の関連ファイル一覧が最新の状態である
6. 既存の TG タスク（TG-001〜TG-008）の記述に影響を与えていない

## リソース・前提条件

- 変更対象ファイル:
  - `.claude/skills/triage-manager/SKILL.md`
  - `.claude/skills/triage-manager/agents/triage-worker.md`
  - `.claude/skills/triage-manager/agents/triage-evaluator.md`
  - `docs/workflow.md`

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| 既存ルールとの整合性破壊 | 低 | 高 | 変更前に既存の TG タスク定義を精読し、責務の重複・矛盾がないことを確認する |
| docs/workflow.md の記述更新漏れ | 中 | 中 | 関連ファイル一覧に基づき連動更新を実施する |

---
**作成者**: L1
**作成日**: 2026-03-06
**最終更新**: 2026-03-06
