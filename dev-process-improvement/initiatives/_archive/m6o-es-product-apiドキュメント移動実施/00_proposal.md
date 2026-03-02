# 改善施策提案: m6o-es-product-api ドキュメント移動実施

## 背景・課題

フェーズ1「m6o-es-product-api ドキュメント整理」（`initiatives/_archive/m6o-es-product-apiドキュメント整理/`）において、`my_work/` 配下 86件のファイルについて以下の設計が完了した。

- AI用/人間用/参考資料の3区分による分類
- 新ディレクトリ構造（8ディレクトリ）の定義
- 全86件の移動先マッピング表の作成

現状は設計のみが完了しており、`m6o-es-product-api` リポジトリの `my_work/` 配下には依然として86件のファイルが混在した状態にある。設計成果物が陳腐化する前に実際のファイル操作として反映する。

## 目標

- `my_work/` 配下の全86件のファイルを `design.md` のマッピング表に従い新ディレクトリへ移動する
- `CLAUDE.md` の `my_work/` 参照パスを新パスへ更新する

## スコープ

### やること

- 新ディレクトリ（`.claude/rules/`・`.claude/tools/`・`docs/design/`・`docs/process/`・`docs/re/`・`refs/poc/`・`refs/impl-history/`・`refs/process-history/`）の作成
- `design.md` マッピング表に従ったファイル移動（86件）
- `.claude/rules/` 配置ファイルの kebab-case 英語名への改名（4件）
- `m6o-es-product-api/CLAUDE.md` 内の `my_work/` パス参照を新パスへ更新（8箇所）

### やらないこと

- `.claude/rules/` ファイルの内容整備・書き直し（別施策: ISS-016）
- ソースコード変更

## 期待される効果

- `my_work/` 配下の混在状態が解消され、AI用/人間用/参考資料の区分で整理される
- `.claude/rules/` に AI 向けコンテキストファイルが集約され、Claude が適切に参照できるようになる
- `docs/` に人間向けドキュメントが集約され、発見性が向上する
- 将来の資料追加時に「どこに置くか」が明確になる

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| ファイル移動漏れ・誤移動 | 高 | evaluator による全件照合で検出 |
| CLAUDE.md パス更新漏れ | 中 | 移動後に grep で残存確認 |
| m6o-es-product-api リポジトリへの意図しない変更 | 中 | 移動対象ファイルのみを git mv で操作し、diff を確認する |

## 壁打ちの背景

- **ブランチ名**: `initiative/doc-migration`（`main` から分岐）— フェーズ2の実移動を表す `doc-migration` を選択
- **施策ディレクトリ**: `dev-process-improvement/initiatives/m6o-es-product-apiドキュメント移動実施/` — 通常フローに従い `_template/` からコピー
- **作業対象リポジトリの確認**: `my_work/` は `ai-driven-dev-patterns-fork` ではなく `m6o-es-product-api` リポジトリ内にある（`/home/developer/projects/m6o-es-product-api_dev_process_improvement/m6o-es-product-api/`）。L2-worker はそちらのリポジトリで操作を行う

## 備考・設計パターン

- **設計書の参照先**: `dev-process-improvement/initiatives/_archive/m6o-es-product-apiドキュメント整理/design.md`（マッピング表 86件が記載）
- **注意**: `04_work_report.md` のファイル数記載（73件）は誤り。正しくは 86件（design.md が正）

---
**起票者**: L1
**起票日**: 2026-03-02
**ステータス**: 実施中
