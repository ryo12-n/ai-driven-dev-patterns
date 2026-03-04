# dev-process-improvement 側の collab-log 参照を inbox に更新する

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 🟡 中 |
| **ステータス** | 候補 |
| **対象リポジトリ** | ai-driven-dev-patterns（dev-process-improvement 配下） |
| **起票日** | 2026-03-04 |

## 課題・背景

ai-driven-dev-patterns 側で `docs/collab-log.md` を廃止し `inbox/` に統合したが、dev-process-improvement 側の運用ルール（triage.md、CLAUDE.md、workflow.md、triage/_template/00_pre_investigation.md）に `docs/collab-log.md` への能動的な参照が残存している。蒸留フローや記録先の指定が古い参照を指したままであり、運用の一貫性が損なわれている。

## 期待効果

- dev-process-improvement 側の運用ルールが inbox を参照するようになり、ai-driven-dev-patterns 側と一貫した運用が実現する
- collab-log.md への参照が完全に消滅し、混乱のリスクがなくなる

## 補足・参考情報

- 関連課題: ISS-030（プロセス改善_課題管理.csv）
- 元施策: ai-driven-dev-patternsの改善サイクル整備（08_gate_review.md 次施策候補 #1）
- 対象ファイル: triage.md の蒸留フロー、CLAUDE.md のセッション終了時記録先、workflow.md、テンプレートの collab-log セクション
