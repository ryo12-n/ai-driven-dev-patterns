# 実施計画: トリアージ標準ポリシーガイドライン

## フェーズ構成

| フェーズ | 内容 | 期間 | 成功基準 |
|---------|------|------|----------|
| 1 | 調査・ガイドライン作成・TGタスク追加・workflow更新 | 1セッション | 下記成功基準1〜4を全て満たす |

## スケジュール

- フェーズ1: L2-worker がガイドライン作成・ルール更新を実施
- フェーズ1完了後: L2-evaluator が成果物を評価
- ゲート判定: L1 が `08_gate_review.md` で判定

## 成功基準（全体）

1. `docs/triage-standard-policy-guideline.md` が存在し、全セッションタイプ（L1/L2-worker/L2-evaluator/triage-mgr/triage-worker/triage-evaluator）のライフサイクルステージをカバーしている
2. `.claude/rules/triage-manager.md` に新TGタスク（TG-008: セッション構造標準ポリシーチェック）が追加されている
3. `.claude/rules/triage-worker.md` に TG-008 の走査手順が追加されている
4. `docs/workflow.md` が TG-008 の追加を反映して更新されている

## リソース・前提条件

- 参照ファイル: `l1-manager.md`, `l2-worker.md`, `l2-evaluator.md`, `triage-manager.md`, `triage-worker.md`, `triage-evaluator.md`, `roles/dev_manager.md`, `roles/_base/common.md`
- `docs/workflow.md` の整合性ルール（CLAUDE.md: ルールファイルが Source of Truth、workflow.md はその可視化）に従うこと

## リスクと対策
| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| セッションタイプが多すぎて網羅に時間がかかる | 低 | 低 | 主要6タイプに絞り、dev_manager は参考として記載 |
| triage-manager.md / triage-worker.md の既存構造と整合が取れない | 低 | 中 | 既存 TG タスクの記載形式に合わせる |

---
**作成者**: L1
**作成日**: 2026-03-05
**最終更新**: 2026-03-05
