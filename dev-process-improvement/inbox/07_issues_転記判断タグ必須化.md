# 07_issues.md の全エントリに転記判断タグを必須化

## 背景

dev-process-improvementリポジトリ分離施策の評価で、07_issues.md の2番目のエントリに転記判断タグ（`[転記済]` or `[転記不要]`）が付いておらず、評価者が転記漏れか意図的な未転記か判断できない問題が発生した。

## 提案

- `initiatives/_template/07_issues.md` のテンプレートに「全エントリに転記判断タグを付与すること」を明記する
- または L2-worker エージェント定義（`l2-worker.md`）の課題CSV転記セクションに「全エントリに `[転記済 ISS-XXX]` または `[転記不要: 理由]` のタグを必須とする」ルールを追加する

## 情報源

- `initiatives/dev-process-improvementリポジトリ分離/06_eval_report.md` — ルール化候補 #2
- `initiatives/dev-process-improvementリポジトリ分離/08_gate_review.md` — 必須把握事項 #4
