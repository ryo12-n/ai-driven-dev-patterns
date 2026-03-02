# 評価計画: m6o-es-product-api ドキュメント移動実施

## 壁打ちフェーズ [2026-03-02 11:00]

### 理解のサマリー
- 評価の目的: L2-worker が実施した86件のファイル移動・CLAUDE.md更新・kebab-case改名が、design.md の設計通りに正確に完了しているかを客観的に検証する
- 評価スコープ: T-E-001（全件照合）・T-E-002（CLAUDE.md パス参照）・T-E-003（kebab-case 改名）・T-E-004（課題起票・CSV転記）
- 完了条件: 全4タスクが完了し、06_eval_report.md に評価結果が記載されていること

### 前提条件チェック
- [x] 評価対象（04_work_report.md）の完成度: 十分（T-001〜T-006 の全タスク結果が記載されている）
- [x] 評価基準（01_plan.md の成功基準）の明確さ: 評価可能（4つの成功基準が明確に定義されている）
- [x] 評価に必要なツール・アクセス権限: 確認済み（git status・ls コマンドで検証可能。リポジトリへのアクセス権限あり）

### 不明点・確認事項
なし

### L1 確認結果
確認事項なし：評価開始

L1 補足情報:
- L1 補足: `docs/Design Doc：PoC MDIを活用した新基盤構築.md` の ` D` 問題は L1 が `git checkout HEAD --` でリストア済み。現在は問題なし。

---

## 評価対象

`m6o-es-product-api` リポジトリで実施されたファイル移動作業の成果物。
具体的には以下を評価する：
1. `git mv` による86件のファイル移動（design.md マッピング表との照合）
2. `CLAUDE.md` の `my_work/` パス参照の更新
3. `.claude/rules/` 配下4ファイルの kebab-case 英語名への改名

## 評価項目

| # | 評価項目 | 評価方法 | 判定基準（合格ライン） |
|---|---------|---------|---------------------|
| 1 | 全件照合（T-E-001） | `git -c core.quotePath=false status --short` の `renamed:` 一覧と design.md セクション5.1〜5.14 のマッピング表を Python スクリプトで比較 | 86件全件一致（不一致0件） |
| 2 | CLAUDE.md パス参照（T-E-002） | `grep my_work CLAUDE.md` で残存確認、新パス参照が正確かを目視確認 | `my_work` 残存0件、新パス参照が正確 |
| 3 | kebab-case 改名（T-E-003） | `.claude/rules/` 配下の4ファイルの存在と命名を `ls` で確認 | `session-operation-guide.md`・`directory-structure.md`・`plugin-guide.md`・`worker-prompt-templates.md` の4ファイルが存在 |
| 4 | 課題起票・CSV転記（T-E-004） | `07_issues.md` の全課題に転記済みまたは転記不要の判断が付いているか確認 | 全課題に `[転記済 ISS-XXX]` または「転記不要」が付いている |

## 評価スケジュール
- 評価実施: 2026-03-02（L2-evaluator 起動当日）
- 成果物提出: 同日

## 前提・制約
- 評価は `git status` のステージング済み変更（未コミット）を対象とする
- L1 による `docs/Design Doc：PoC MDIを活用した新基盤構築.md` のリストアは評価スコープ外
- `.gitkeep` ファイル（ディレクトリプレースホルダー）は86件に含まれる（`my_work/プロセス改善/tools/logs/.gitkeep`）

---
**作成者**: L2（評価）
**作成日**: 2026-03-02
