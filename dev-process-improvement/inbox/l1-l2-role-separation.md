# L1/L2 ロール分離の徹底

## 知見

organize-readme 施策で L1（マネージャー）が L2-worker サブエージェントを起動せず、T-001（README 書き直し）と T-002（session-guide 作成）を直接実行してしまった。

## 原因分析

1. Plan エージェントが README の内容設計まで詳細に行い、「あとは書くだけ」という意識になった
2. L2-worker 起動のオーバーヘッド（サブエージェント起動 + 壁打ちフェーズ）を省いてスピードを優先した
3. l1-manager.md に「L2 の成果物を直接編集しない」とは書いてあるが、「L1 が直接タスクを実行してはならない」とは明文化されていない

## 影響

- 03_work_log / 04_work_report / 07_issues が後埋めになり、作業中の自然な記録が失われた
- L2-worker が作業中に発見するはずの気づき・課題が記録されなかった
- ロール分離の形骸化（L1 がやれば速い → 常に L1 がやる、の悪循環リスク）

## 対応案

l1-manager.md の「やらないこと」セクションに以下を追加:

```
- 02_tasks.md のタスク（T-XXX）を直接実行しない（Plan エージェントの出力が詳細でも、必ず L2-worker に委任する）
```

## 情報源

- `dev-process-improvement/initiatives/_archive/organize-readme/03_work_log.md` 振り返りエントリ
- `dev-process-improvement/initiatives/_archive/organize-readme/08_gate_review.md` 必須把握事項 #5
