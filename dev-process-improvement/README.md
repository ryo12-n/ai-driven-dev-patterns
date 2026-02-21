# dev-process-improvement

開発プロセス改善サイクルを管理するリポジトリ。  
L1（マネージャー）とL2（ワーカー）の2層AIセッション構成で、調査→計画→実施→評価→改善を回す。

## ディレクトリ構成

```
dev-process-improvement/
├── CLAUDE.md                          # Claude 共通ルール
├── プロセス改善_課題管理.csv            # 全施策横断の課題・知見管理（単一ソース・オブ・トゥルース）
├── .claude/
│   └── rules/
│       ├── l1-manager.md              # L1セッション用ルール
│       ├── l2-worker.md               # L2実施セッション用ルール
│       └── l2-evaluator.md            # L2評価セッション用ルール
│
├── initiatives/                       # 改善施策ごとのフォルダ
│   └── _template/                     # 新規施策のひな形
│       ├── 00_proposal.md
│       ├── 01_plan.md
│       ├── 02_tasks.md
│       ├── 03_work_log.md
│       ├── 04_work_report.md
│       ├── 05_eval_plan.md
│       ├── 06_eval_report.md
│       ├── 07_issues.md               # 施策内一時メモ（完了時に CSV へ転記）
│       └── 08_gate_review.md
│
├── backlog/                           # 施策候補・アイデアのストック
│   └── ideas.md
│
├── templates/                         # プロンプトテンプレート
│   ├── l1-prompts.md
│   └── l2-prompts.md
│
└── docs/
    ├── workflow.md                     # フロー全体の説明
    └── session-guide.md               # セッション運用ガイド
```

## 基本フロー

1. **L1: 調査・方針決定・計画作成・タスク作成**
2. **L2 (実施): タスク実施計画作成 → 実施 → 作業履歴管理 → 作業レポート作成 → 課題起票**
3. **L2 (評価): 評価実施計画作成 → 作業評価 → 作業履歴管理 → 評価レポート作成 → 課題起票**
4. **L1: レポート確認 → 課題確認 → ギャップ認識 → フェーズゲート判定 → 計画修正 → タスク修正**

詳細は `docs/workflow.md` を参照。
