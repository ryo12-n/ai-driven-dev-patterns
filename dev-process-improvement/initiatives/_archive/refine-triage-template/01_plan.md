# 実施計画: triage テンプレートのブラッシュアップ

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | ワーカーテンプレート変更 + マネージャーテンプレート変更 + ルールファイル更新 | 全テンプレート・ルールファイルが整合した状態で完成 |

## 変更後のファイル構成

### Worker level (`triage/_template/workers/_template/`)
```
01_tasks.md               (変更なし)
02_scan_plan.md           (新規: worker 壁打ち + スキャン計画)
03_work_log.md            (02からリネーム、壁打ちセクション削除)
04_scan_report.md         (03からリネーム)
05_eval_plan.md           (新規: evaluator 壁打ち + 評価計画)
06_eval_report.md         (04からリネーム + 知見セクション追加)
07_issues.md              (新規: ワーカーセット別課題バッファ)
```

### Manager level (`triage/_template/`)
```
00_pre_investigation.md   (変更なし)
01_plan.md                (変更なし)
02_dispatch_log.md        (変更なし)
03_report.md              (修正: 知見集約・課題集約セクション追加)
04_gate_review.md         (新規: ゲート判定・知見ルーティング)
```

### Rule files (`.claude/rules/`)
```
triage-manager.md         (修正: ゲート判定・知見/課題集約手順追加)
triage-worker.md          (修正: CSV直接起票→07_issues.mdバッファに変更)
triage-evaluator.md       (修正: 壁打ち・評価計画・知見記録・課題バッファ追加)
```

## 成功基準（全体）

1. ワーカーテンプレートに 02_scan_plan.md, 05_eval_plan.md, 07_issues.md が存在する
2. マネージャーテンプレートに 04_gate_review.md が存在し、知見ルーティング構造を持つ
3. 3つのルールファイル（triage-manager/worker/evaluator.md）が新ファイル構成と整合している
4. ルールファイル間のファイル番号参照に不整合がない（grep で横断検証）
5. 06_eval_report.md に「評価中の知見」セクション（ルール化候補・参考情報テーブル）が存在する
6. 03_report.md に知見集約・課題集約セクションが存在する

## リソース・前提条件
- initiatives テンプレート（`initiatives/_template/`）を参照パターンとして使用
- 既存トリアージセッション（`triage/YYYYMMDD/`）には影響しない

## リスクと対策
| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| ファイル番号参照の不整合 | 中 | 中 | 完了後に grep で全ルールファイルを横断検証 |
| 03_report.md と 04_gate_review.md の境界曖昧化 | 低 | 中 | report=事実集約、gate_review=判断・ルーティングの原則を徹底 |

---
**作成者**: L1
**作成日**: 2026-03-05
**最終更新**: 2026-03-05
