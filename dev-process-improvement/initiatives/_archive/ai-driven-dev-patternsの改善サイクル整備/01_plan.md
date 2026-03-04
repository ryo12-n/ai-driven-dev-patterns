# 実施計画: ai-driven-dev-patterns の改善サイクル整備

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | 知見キャプチャの義務化とルーティングインフラの構築 | common.md に知見記載ルールが追加され、inbox/backlog/CSV が新設されている |
| 2 | dev_manager のルーティングロジック拡張と壁打ち統一 | dev_manager.md §6 が新ルーティング先に対応し、common.md に壁打ちルールが追加されている |
| 3 | collab-log.md の廃止と参照更新 | collab-log.md が削除され、CLAUDE.md 等の参照が inbox に更新されている |

## 成功基準（全体）

1. `roles/_base/common.md` に知見記載の最低1行義務ルールが定義されている
2. `roles/dev_manager.md` §6 のルーティング先に inbox/backlog/CSV が追加されている
3. ai-driven-dev-patterns 直下に `inbox/`・`backlog/`・`課題管理.csv` が存在する
4. `docs/collab-log.md` が削除され、CLAUDE.md の参照が更新されている
5. `roles/_base/common.md` に壁打ちフェーズの統一ルールが追加されている

## リソース・前提条件

- ai-driven-dev-patterns リポジトリへの書き込み権限
- 既存の `roles/_base/common.md`、`roles/dev_manager.md`、`sessions/_template/report.md` の構造を把握していること

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| common.md への追記で既存ルールと矛盾 | 低 | 中 | 追記箇所を既存セクション構造に合わせる |
| collab-log.md 廃止時に参照漏れ | 低 | 低 | grep で全参照箇所を洗い出してから削除 |
| CSV フォーマットが dev-process-improvement 側と乖離 | 低 | 低 | 同一フォーマットを採用し、将来の統合に備える |

---
**作成者**: L1
**作成日**: 2026-03-04
**最終更新**: 2026-03-04
