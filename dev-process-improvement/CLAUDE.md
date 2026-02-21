# CLAUDE.md — dev-process-improvement 共通ルール

このファイルは `dev-process-improvement/` 配下のすべてのセッションに適用される共通ルールです。

---

## セッション種別の定義

| 種別 | 役割 | 専用ルール |
|---|---|---|
| **L1（管理）** | バックログ管理・計画策定・ゲート判定・L2への指示出し | `.claude/rules/l1-manager.md` |
| **L2-worker（実施）** | タスク実行・作業ログ記録・成果物生成 | `.claude/rules/l2-worker.md` |
| **L2-evaluator（評価）** | 成果物の評価・評価レポート生成 | `.claude/rules/l2-evaluator.md` |

セッション起動時は、必ずセッション種別に対応するルールファイルを追加で読み込ませること。

---

## ファイル命名規約

- 施策フォルダ名: `initiatives/<連番>_<施策名-kebab-case>/`（例: `initiatives/01_ci-speed-up/`）
- 施策内ファイルは `_template/` のプレフィックス番号を維持する（`00_` 〜 `08_`）
- 作業ログのエントリは `### YYYY-MM-DD HH:MM` の見出し形式で追記する

---

## 出力形式の規約

- すべての出力は日本語で記述する
- Markdownのみを使用する（HTMLタグは使わない）
- フロントマターを各テンプレートに持たせ、`status` フィールドで進捗を管理する
  - 有効な `status` 値: `draft` / `in-progress` / `done` / `blocked` / `cancelled`
- 施策の判断・承認は L1 セッションのみが行う
- L2 セッションは担当フェーズ外のファイルを上書きしない

---

## ディレクトリの参照関係

```
sessions
  ├── L1 → backlog/ideas.md を起点に initiatives/ を管理
  ├── L2-worker → initiatives/<施策名>/02_tasks.md を起点に実施
  └── L2-evaluator → initiatives/<施策名>/04_work_report.md を起点に評価
```

---

## 禁止事項

- L2 セッションが `08_gate_review.md` の判定を書き込むことは禁止
- L1 セッションが `03_work_log.md` / `04_work_report.md` を直接編集することは禁止（読み取りは可）
- `_template/` フォルダを施策フォルダとして直接使用することは禁止（必ずコピーして使う）
