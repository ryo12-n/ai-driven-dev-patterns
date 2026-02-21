# セッション起動ガイド

Claude Code で各セッションタイプを起動するための手順書です。

---

## セッションタイプ一覧

| タイプ | 用途 | 読み込むルールファイル |
|---|---|---|
| L1（管理） | バックログ管理・計画・ゲートレビュー | `CLAUDE.md` + `.claude/rules/l1-manager.md` |
| L2-worker（実施） | タスク実行・作業ログ記録 | `CLAUDE.md` + `.claude/rules/l2-worker.md` |
| L2-evaluator（評価） | 成果物評価・評価レポート生成 | `CLAUDE.md` + `.claude/rules/l2-evaluator.md` |

---

## L1 セッションの起動

### 手順

1. Claude Code を `dev-process-improvement/` ディレクトリで起動する
2. `CLAUDE.md` は自動で読み込まれる
3. セッション冒頭に以下を貼り付ける:

```
.claude/rules/l1-manager.md を読み込んでください。
その後、backlog/ideas.md を確認して現在の状況を把握してください。
```

または `templates/l1-prompts.md` から目的に合ったプロンプトをコピーして使用する。

### 主な用途別プロンプト

- バックログ整理 → `templates/l1-prompts.md` #5
- 施策立ち上げ → `templates/l1-prompts.md` #2
- ゲートレビュー → `templates/l1-prompts.md` #4

---

## L2-worker セッションの起動

### 前提条件

- L1 が `02_tasks.md` を作成・承認済みであること
- 担当タスク範囲が L1 から指示されていること

### 手順

1. `templates/l2-prompts.md` の「L2-worker: 実施セッション起動プロンプト」をコピー
2. `（施策フォルダ名）` と `（T開始〜T終了番号）` を埋める
3. Claude Code セッションの冒頭に貼り付けて起動

### 注意事項

- 各 L2-worker セッションは独立したコンテキストで起動する（セッション間の引き継ぎは `03_work_log.md` 経由）
- 中断後の再開は「継続セッション起動プロンプト」を使用する

---

## L2-evaluator セッションの起動

### 前提条件

- L2-worker が `04_work_report.md` を生成済みであること
- L1 が `05_eval_plan.md` を作成・承認済みであること

### 手順

1. `templates/l2-prompts.md` の「L2-evaluator: 評価セッション起動プロンプト」をコピー
2. `（施策フォルダ名）` を埋める
3. Claude Code セッションの冒頭に貼り付けて起動

---

## セッション終了時のチェックリスト

### L2-worker 終了時

- [ ] すべての完了タスクのチェックボックスが `[x]` になっている
- [ ] `03_work_log.md` に終了エントリが追記されている
- [ ] `04_work_report.md` が生成されている
- [ ] 未完了タスクがある場合は `07_issues.md` に記録されている
- [ ] L1 への完了報告メッセージが出力されている

### L2-evaluator 終了時

- [ ] `06_eval_report.md` が生成されている
- [ ] 総合グレードとスコアが記入されている
- [ ] `08_gate_review.md` は編集していない（L1が担当）

### L1 ゲートレビュー後

- [ ] `08_gate_review.md` に判定結果が記入されている
- [ ] `proceed` の場合: 次フェーズの指示が準備されている
- [ ] `rework` の場合: 具体的な修正指示が記載されている
- [ ] `close` の場合: クローズ理由と学びが記録されている
