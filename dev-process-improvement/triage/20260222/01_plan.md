# トリアージ実施計画: 2026-02-22

<!-- 00_pre_investigation.md の結果を受けて作成する -->

## 今回の実施スコープ

### 実施する走査対象

- [x] inbox（未処理アイテムの分類・優先度付け）
- [x] backlog（追加候補の優先度・施策名確定）
- [x] 課題管理 CSV（未対応課題の対応方針確定）
- [x] 進行中 initiative の状態確認
- [x] collab-log の蒸留確認
- [x] rules/workflow の整合性確認・軽微な修正

### 実施しない対象と理由

- refs/ 内容の詳細調査：`ref_parallel-agent-poc.md` の概要把握は完了済み。施策化候補として backlog に登録すれば十分

## 走査タスク一覧

| タスクID | 対象 | やること | 完了条件 |
|---------|------|---------|---------|
| TG-001 | inbox | 3件を「backlog候補 / 却下 / 対応不要」に分類する | 全件に判断が付いている |
| TG-002 | backlog | 追加候補3件の優先度・施策名を確定しレポートに記載する | ユーザー確認用リストが 03_report.md に記載されている |
| TG-003 | CSV | ISS-001〜004 の対応方針を確定・CSV を更新する | 全件ステータスが「タスク化済」になっている |
| TG-004 | initiative | openspec-process-integration の現状を確認・記録する | 状態が 02_work_log.md に記録されている |
| TG-005 | rules/workflow | workflow.md と _template の乖離（collab-log 確認の記載漏れ）を修正する | collab-log 確認が workflow Step1 とテンプレートに追記されている |

## 今回の重点

1. inbox 3件の全件処理
2. CSV ISS-001〜004 の対応方針確定
3. rules/workflow の軽微乖離を今回セッション内で修正

## 完了基準

- [x] 全走査タスクを実施し、結果を 02_work_log.md に記録している
- [ ] backlog への追加・変更が確定している（ユーザー確認後）
- [ ] 振り返りレポート（03_report.md）を作成し、PR を作成している

---
**作成者**: トリアージセッション
**作成日**: 2026-02-22
