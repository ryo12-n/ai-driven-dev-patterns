# ai-driven-dev-patterns トリアージプロセスのブラッシュアップ

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 🟡 中 |
| **ステータス** | 候補 |
| **対象リポジトリ** | ai-driven-dev-patterns |
| **起票日** | 2026-03-04 |

## 課題・背景

PR#59 で ai-driven-dev-patterns 側に基本的なトリアージプロセスをセットアップ済み（`.claude/rules/triage.md` + `triage/_template/`）だが、dev-process-improvement 側のトリアージプロセスと比較して以下の差分がある:

1. **refs/ 管理が未対応**: ai-driven-dev-patterns には refs/ ディレクトリと ref_* ポインターの管理フローが未定義
2. **collab-log 蒸留フローが未定義**: dev-process-improvement には `docs/collab-log.md` の未蒸留エントリ確認・蒸留フローがあるが、ai-driven-dev-patterns 側には対応する仕組みがない
3. **施策化済みチェック（TG-002 拡張）が未反映**: backlog と sessions/_archive/ の突合チェックが未実装
4. **完了済みセッションのアーカイブ確認が未定義**: sessions/ 配下の完了セッションを _archive/ に移動するフローが未定義
5. **テンプレートの詳細度不足**: 00_pre_investigation.md のチェック項目が dev-process-improvement 版より少ない
6. **ルール・ロール整合性チェックの対象範囲**: `.claude/rules/*.md` ↔ `roles/*.md` の整合性チェックはあるが、対象ファイルの具体的な列挙や判断基準が不足

## 期待効果

- ai-driven-dev-patterns 側のトリアージプロセスが dev-process-improvement 側と同等の品質・網羅性を持つようになる
- inbox の滞留防止、backlog の陳腐化検出、ルール・ロール間のドリフト検出が自動的にトリアージフローに組み込まれる
- 将来のリポジトリ分離後も、各リポジトリが独立して改善サイクルを回せる状態になる

## 補足・参考情報

- 現行セットアップ: `.claude/rules/triage.md`（109行）、`triage/_template/`（4ファイル）
- 参考: `dev-process-improvement/.claude/rules/triage.md`（109行、より詳細なルール定義）
- 関連: ISS-030（collab-log 参照未更新）、backlog「workflow.md整合性一括修正」
- 注意: dev-process-improvement 固有の概念（initiatives/、L1/L2 セッション構造、refs/）はそのまま転用せず、ai-driven-dev-patterns のディレクトリ構造（sessions/、roles/）に合わせた適応が必要
