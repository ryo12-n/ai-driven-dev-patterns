# スキャン計画: Set-2

## 壁打ちフェーズ [2026-03-06 10:00]

### 理解のサマリー
- タスクの目的: backlog 16件の棚卸し・施策化済みチェック・進行中施策の状態確認・backlog関係性分析・セッション構造標準ポリシーチェックの5つのTGタスクを走査し、構造化されたスキャンレポートを作成する
- スコープ: TG-002, TG-003, TG-005, TG-006, TG-008 の5タスク
- 完了条件: 04_scan_report.md に全5タスクの構造化された走査結果が記載され、発見した課題が 07_issues.md に起票されている

### 前提条件チェック
- [x] 割り当てTGタスクの内容を理解: 理解済み
- [x] 走査対象ファイル・ディレクトリの存在確認: 確認済み（backlog/ 16件、initiatives/ 1件進行中 + _archive/ 33件完了、TG-008対象の6ファイル全て存在）
- [x] 走査に必要なツール・アクセス権限: 確認済み

### 不明点・確認事項
なし

### マネージャー確認結果
確認事項なし：実施開始

---

## スキャン計画

### 走査対象

| # | TGタスクID | 対象 | 走査方法 | 想定所要時間 |
|---|----------|------|---------|------------|
| 1 | TG-002 | backlog/ 16件 | 各ファイルのメタ情報（優先度・ステータス・起票日）を読み取り、滞留期間・優先度妥当性を評価 | 中 |
| 2 | TG-003 | backlog/ vs initiatives/_archive/ | backlog各ファイルの名称・内容を initiatives/ + _archive/ の施策名と突合し、施策化済みを検出 | 中 |
| 3 | TG-005 | initiatives/dev-process-improvementリポジトリ分離/ | 02_tasks.md のタスク進捗・08_gate_review.md の状態・03_work_log.md の最新エントリを確認 | 低 |
| 4 | TG-006 | backlog/ 16件の横断分析 | 重複候補・依存関係・統合候補を分析。特にclaude-directory最適化関連2件に注目 | 中 |
| 5 | TG-008 | .claude/skills/ 配下6ファイル | triage-standard-policy-guideline.md のチェック項目A〜Dで各ファイルを走査 | 高 |

### 走査順序・依存関係
- TG-002 → TG-003 → TG-006 の順（backlog読み取り結果を後続タスクで再利用）
- TG-005 は独立（他タスクと依存なし）
- TG-008 は独立（他タスクと依存なし）
- 実施順: TG-002 → TG-003 → TG-005 → TG-006 → TG-008

### 注意事項・制約
- backlog は全て「候補」ステータスで未施策化（0/16）
- claude-directory最適化関連2件（ai-driven-dev-patterns版 / dev-process-improvement版）の統合可能性に注目
- initiatives/_archive/ に 33件の完了施策あり
- TG-008 の走査対象は6ファイル（l1-manager/SKILL.md, agents/l2-worker.md, agents/l2-evaluator.md, triage-manager/SKILL.md, agents/triage-worker.md, agents/triage-evaluator.md）

---
**作成者**: トリアージワーカー
**作成日**: 2026-03-06
