# 実施計画: workflow.md ドキュメント整合性一括修正

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | ドキュメント修正（8課題の一括対応） | SC-1〜SC-5 を全て満たすこと |

単一フェーズで完結する施策。修正対象が明確で、Source of Truth（.claude/rules/*.md）に合わせる方向のため、設計判断は最小限。

## 成功基準（全体）

| ID | 基準 | 検証方法 |
|----|------|---------|
| SC-1 | ISS-008〜012 の乖離が解消されている | workflow.md と各 rules/*.md の記述を突合し、一致を確認 |
| SC-2 | ISS-024 の L1 参照が全てユーザーに置換されている | dev-workflow-detail.md 内の「施策管理 L1」参照が0件であること |
| SC-3 | ISS-029: triage.md に関連ファイル一覧セクションが追加されている | triage.md（またはtriage-manager.md）に「関連ファイル一覧」セクションが存在すること |
| SC-4 | ISS-030: collab-log 参照が inbox/ に更新され、collab-log.md が削除されている | grep で collab-log 参照が0件（git rm 対象を除く）、かつ collab-log.md が存在しないこと |
| SC-5 | 課題管理 CSV の対象8件のステータスが更新されている | CSV の ISS-008〜012, ISS-024, ISS-029, ISS-030 のステータスが「施策化」以降であること |

## リソース・前提条件

- Source of Truth ファイル: `.claude/rules/l1-manager.md`, `l2-worker.md`, `l2-evaluator.md`, `triage.md`（またはtriage-manager.md, triage-worker.md）
- 修正対象ファイル: `docs/workflow.md`, `docs/design/dev-workflow-detail.md`, `.claude/rules/triage*.md`, `.claude/CLAUDE.md`, テンプレート, `docs/collab-log.md`

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| workflow.md 修正で既存記述の意図しない破壊 | 低 | 中 | 最小限の変更に留め、diff を確認 |
| collab-log 参照の grep 漏れ | 低 | 低 | 複数パターンで検索（collab-log, collab_log, コラボレーションログ） |
| triage ルールファイルの構成が想定と異なる | 低 | 低 | 事前に triage*.md の構成を確認してから修正方針を決定 |

---
**作成者**: L1
**作成日**: 2026-03-04
**最終更新**: 2026-03-04
