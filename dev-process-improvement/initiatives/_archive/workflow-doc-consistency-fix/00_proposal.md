# 改善施策提案: workflow.md ドキュメント整合性一括修正

## 背景・課題

workflow.md に関する整合性の課題が ISS-008〜012 として5件、ISS-024, ISS-029, ISS-030 として3件、計8件が起票されている。ISS-008〜012 は4回連続のトリアージで未対応のまま残存するドキュメント債務である。

個別課題の概要:

| ID | カテゴリ | 概要 |
|----|---------|------|
| ISS-008 | workflow.md | トリアージのルール・workflow整合性チェックが必須ステップとして強調されていない |
| ISS-009 | workflow.md | ファイル所有権シンボルの不整合（emoji vs テキスト） |
| ISS-010 | workflow.md | L1 CSV更新責務（resume → 代理転記フロー）が曖昧 |
| ISS-011 | workflow.md | L1 判断根拠の記録場所（03_work_log.md）が未記載 |
| ISS-012 | workflow.md | refs/ 孤立エントリ処理手順が不十分 |
| ISS-024 | dev-workflow-detail.md | mermaid 図・エスカレーションテーブルに残存する L1 参照 |
| ISS-029 | triage.md | ルール変更時の連動更新対象ファイル一覧が未明文化 |
| ISS-030 | 複数ファイル | collab-log.md への参照が inbox/ に未更新 |

## 目標

1. 8件のドキュメント整合性課題を全て解消する
2. `.claude/rules/*.md`（Source of Truth）と `docs/workflow.md`（人間向け解釈）の記述を一致させる
3. collab-log 参照を inbox/ に統一し、collab-log.md を削除する

## スコープ

### やること

- workflow.md の5箇所の乖離修正（ISS-008〜012）
- dev-workflow-detail.md の L1 参照をユーザーに置換（ISS-024）
- triage.md に「関連ファイル一覧」セクションを追加（ISS-029）
- collab-log 参照を inbox/ に更新し、collab-log.md を削除（ISS-030）
- 修正対象の CSV ステータスを「施策化」に更新

### やらないこと

- ルールファイル（.claude/rules/*.md）の内容変更（Source of Truth 側は変更しない。記述追加のみ）
- workflow.md の構成・フォーマットの大幅リファクタリング
- ISS-029 のパターンを triage.md 以外のルールファイルに展開すること（将来施策として検討）

## 期待される効果

- 4回連続未対応のドキュメント債務を一括解消
- workflow.md が実態と一致し、信頼できるドキュメントとして機能する
- ルール変更時の連動更新対象が明文化され、将来の乖離発生を予防する

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| workflow.md 修正で意図しない既存記述の破壊 | 中 | 修正前後の diff を確認し、変更箇所を最小限にする |
| ISS-024 の dev-workflow-detail.md が親リポジトリ側ファイル | 低 | スコープに含めることを壁打ちで確認済み |
| collab-log.md 削除で参照漏れ | 低 | grep で全参照箇所を事前に洗い出す |

## 壁打ちの背景

- **ISS-024 のスコープ**: dev-workflow-detail.md は ai-driven-dev-patterns/docs/design/ にあるが、ドキュメント整合性修正の一環としてスコープに含めることをユーザーと合意した
- **collab-log の方針**: dev-process-improvement 側の collab-log 参照を inbox/ に統一し、collab-log.md 自体も削除する方針をユーザーと合意した
- **ディレクトリ名**: `workflow-doc-consistency-fix`（英語）を使用

## 備考・設計パターン

- Source of Truth は `.claude/rules/*.md`。workflow.md はその人間向け解釈文書という位置づけ
- 修正は Source of Truth を読み、workflow.md の記述を合わせる方向で実施する
- ISS-029 は予防策としてルールファイルに連動更新先を明記するアプローチ

---
**起票者**: L1
**起票日**: 2026-03-04
**ステータス**: 承認済
