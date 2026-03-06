# ワーカータスク指示: Set-2

## 割り当てTGタスク

| タスクID | 対象 | やること | 完了条件 |
|---------|------|---------|---------|
| TG-002 | backlog | `dev-process-improvement/backlog/` の 16 件を棚卸し。各アイテムのステータス・優先度を見直し、長期滞留アイテムを検出 | 各アイテムに判断が記録されている |
| TG-003 | backlog→initiatives | 各 backlog ファイルが既に施策化されていないかを `initiatives/` + `initiatives/_archive/` と突合する | 施策化済みアイテムが「削除・クローズ候補」に記載されている |
| TG-005 | initiative | 進行中施策 1 件（`dev-process-improvementリポジトリ分離`）の状態確認。ゲート通過済み未アーカイブの検出 | 全施策の状態がスキャンレポートに記録されている |
| TG-006 | backlog | backlog 16 件のアイテム間関係性を横断分析（重複候補・依存関係・統合候補） | 分析結果テーブルが作成されている |
| TG-008 | skills/agents | `.claude/rules/triage-standard-policy-guideline.md` のチェックリストに基づき、セッション構造の準拠チェックを実施 | チェックリスト結果が記録されている |

## 走査時の注意事項

- backlog は全て「候補」ステータスで未施策化（0/16）。全アイテムの優先度が妥当かレビューすること
- TG-003: initiatives/_archive/ に 22+ の完了施策あり。backlog との名称・内容の類似度を確認
- TG-005: `dev-process-improvementリポジトリ分離` は gate_review がテンプレートのまま。進捗状況を確認
- TG-006: 特に claude-directory 最適化関連（2件）の統合可能性に注目
- TG-008: 走査対象ファイルは triage-worker.md に記載の一覧を参照。`triage-standard-policy-guideline.md` のチェック項目A〜Dを全て実施すること

---
**作成者**: トリアージマネージャー
**作成日**: 2026-03-06
