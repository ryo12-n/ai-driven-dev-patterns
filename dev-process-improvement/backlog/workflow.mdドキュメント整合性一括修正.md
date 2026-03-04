# workflow.md ドキュメント整合性一括修正

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 🟡 中 |
| **ステータス** | 候補 |
| **対象リポジトリ** | dev-process-improvement |
| **起票日** | 2026-03-02 |

## 課題・背景

workflow.md に関する整合性の課題が ISS-008〜012 として5件起票されており、4回連続のトリアージで未対応のまま残存している。個別対応ではなく一括施策として対処する。

### 対象課題

| ID | タイトル |
|----|---------|
| ISS-008 | workflow.md 整合性（詳細は課題管理 CSV 参照） |
| ISS-009 | 同上 |
| ISS-010 | 同上 |
| ISS-011 | 同上 |
| ISS-012 | 同上 |
| ISS-024 | （詳細は課題管理 CSV 参照） |
| ISS-029 | ルール変更時の連動更新対象ファイル一覧 |
| ISS-030 | dev-process-improvement 側 collab-log 参照未更新 |

加えて、2026-03-02 トリアージで発見された新規乖離 Issue A〜C も ISS-008 の対応範囲に包含する。

## 期待効果

- 4回連続未対応のドキュメント債務を一括で解消できる
- workflow.md が実態と一致し、信頼できるドキュメントとして機能する

## 補足・参考情報

- ISS-008〜012 の詳細は `dev-process-improvement/docs/issues.csv` を参照
- 新規乖離（Issue A〜C）は ISS-008 の対応範囲に包含。別途起票不要

### 統合元: inbox/triage-rule-related-files-list.md（ISS-029 由来）

- **内容**: triage.md の「関連ファイル一覧」セクション追加提案。ルール変更時に連動更新が必要なファイル（テンプレート・レポート・workflow.md）を明文化する
- **統合理由**: ルールとドキュメントの整合性維持という共通テーマ。関連ファイル一覧追加は整合性修正の一環
- **統合日**: 2026-03-04（トリアージレポート承認に基づく）

### 統合元: backlog/dev-process-improvement側collab-log参照更新.md（ISS-030 由来）

- **内容**: dev-process-improvement 側の運用ルール（triage.md、CLAUDE.md、workflow.md、テンプレート）に残存する `docs/collab-log.md` への参照を inbox への参照に更新する
- **統合理由**: workflow.md・triage.md・CLAUDE.md の整合性修正の一部。collab-log 参照更新は整合性修正の一環として実施する方が効率的
- **対象ファイル**: triage.md の蒸留フロー、CLAUDE.md のセッション終了時記録先、workflow.md、テンプレートの collab-log セクション
- **関連課題**: ISS-030
- **統合日**: 2026-03-04（トリアージレポート承認に基づく）
