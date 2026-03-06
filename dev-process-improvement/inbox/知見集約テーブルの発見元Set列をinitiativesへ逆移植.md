# 知見集約テーブルの「発見元 Set」列を initiatives テンプレートへ逆移植

## 背景

`refine-triage-template` 施策で triage の `03_report.md` 知見集約テーブルに「発見元 Set」列を追加した。これは複数ワーカーセットからの知見集約時に出典を追跡するためのもの。

initiatives テンプレートには同等の列（例: 「発見元フェーズ」）がないが、L2-worker と L2-evaluator の両方から知見を集約する `08_gate_review.md` で同様の出典追跡が有用な可能性がある。

## 提案

initiatives テンプレートの知見テーブルに「発見元」列の追加を検討する。

## 情報源

- `initiatives/refine-triage-template/08_gate_review.md` 必須把握事項 #4
- `initiatives/refine-triage-template/06_eval_report.md` 参考情報 #2
