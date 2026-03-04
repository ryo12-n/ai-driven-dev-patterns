# 課題メモ（施策内バッファ）: ai-driven-dev-patterns の改善サイクル整備

> **このファイルの役割**: 施策実施中に気づいた課題・知見・リスクの一時メモ置き場。
> 施策完了（または定期レビュー）時に `dev-process-improvement/プロセス改善_課題管理.csv` へ転記する

## 転記ルール

- 施策スコープ外・他の施策でも再発しうる課題 → **CSV に転記**
- 当施策内だけで完結する軽微な修正メモ → 転記不要（クローズ扱い）
- 転記済みの項目には `[転記済 ISS-XXX]` を末尾に追記する

---

## 未転記メモ

### [2026-03-04] dev-process-improvement 側の collab-log 参照残存 [転記済 ISS-030]
- **種別**: 改善提案
- **内容**: T-009 実施時に、`dev-process-improvement/` 配下に collab-log への参照が多数残存していることを確認。特に `dev-process-improvement/.claude/rules/triage.md`、`dev-process-improvement/CLAUDE.md`、`dev-process-improvement/docs/workflow.md`、`dev-process-improvement/triage/_template/00_pre_investigation.md` には能動的な運用ルールとして `docs/collab-log.md` への参照がある。ai-driven-dev-patterns 側で collab-log.md を廃止したため、dev-process-improvement 側の運用ルールも更新が必要。
- **対応方針（案）**: dev-process-improvement 側で別施策として collab-log 参照の inbox への更新を実施する。triage.md の蒸留フローを inbox 走査に変更、CLAUDE.md のセッション終了時の記録先を inbox に変更、テンプレートの collab-log セクションを inbox 確認に変更する。
- **関連タスク**: T-009

### [2026-03-04] inbox/backlog が ai-driven-dev-patterns と dev-process-improvement の両方に存在する二重構造 [転記済 ISS-031]
- **種別**: 知見
- **内容**: ai-driven-dev-patterns 直下に `inbox/` `backlog/` を新設したが、`dev-process-improvement/` 配下にも同名のディレクトリ（`inbox/` `backlog/`）が存在する。現状はそれぞれ独立した管理単位（ai-driven-dev-patterns 側は開発知見のバッファ、dev-process-improvement 側はプロセス改善の施策管理）だが、将来的に混乱する可能性がある。
- **対応方針（案）**: 当面は二重構造を許容する。用途が異なるため（開発プロセス vs プロセス改善施策管理）、README.md でスコープを明記して運用する。統合の必要性が出た場合は別施策として検討する。
- **関連タスク**: T-003, T-004
