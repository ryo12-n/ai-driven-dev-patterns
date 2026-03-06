# ワーカータスク指示: Set-1

## 割り当てTGタスク

| タスクID | 対象 | やること | 完了条件 |
|---------|------|---------|---------|
| TG-001 | inbox | `dev-process-improvement/inbox/` の全 26 件を走査し、各アイテムを「backlog候補 / ルール反映 / 却下 / 対応不要 / 保留」に分類する。ref_* 4件のポインター整合性も確認。前回未確認4件を優先確認 | 全26件に分類と根拠が記載 |
| TG-004 | CSV | `プロセス改善_課題管理.csv` のステータス「起票」12件の対応方針を検討。ISS-027（高）を重点レビュー | 各アイテムに対応方針案が記載 |
| TG-007 | rules/workflow | `.claude/skills/*/SKILL.md`、`agents/*.md` と `docs/workflow.md` の整合性確認。前回CRITICAL 2件のフォロー | 乖離の有無・対応方針が記録 |

## 走査時の注意事項

- inbox 前回（20260305-2）で内容未確認だった4件を優先的に内容確認すること: `doc-separation-pattern.md`, `l1-l2-role-separation.md`, `link-validation-standardization.md`, `readme-line-limit-rule.md`
- CSV ISS-027 は高優先度。リポジトリ分離施策（initiatives/dev-process-improvementリポジトリ分離）との関連を考慮すること
- TG-007 の前回 CRITICAL: (1) イニシアティブクローズ手順欠落 (2) Evaluator ステップ欠落 — 修正されているか確認
- 課題発見時は `07_issues.md` に記録し、施策スコープ外の課題は CSV 起票も実施

---
**作成者**: トリアージマネージャー
**作成日**: 2026-03-06
