# dev-process-improvement

AI（Claude Code）を活用した開発プロセス改善を、継続的・組織的に運用するためのディレクトリです。

---

## 目的

- 開発プロセスの課題を「施策」単位で管理し、提案→計画→実施→評価→判定のサイクルを回す
- **L1（管理）セッション**と**L2（実行）セッション**の役割を分離し、AIが自律的かつ安全に動作できる構造を提供する
- テンプレートとルールを標準化することで、施策の品質と再現性を確保する

---

## セッション構成

```
L1セッション（管理AI）
├── バックログ管理（backlog/ideas.md）
├── 施策の優先度判定・フェーズゲート判定
├── L2セッションへの指示出し
└── 成果物の受け取り・承認

    L2セッション — 実施（Worker）
    ├── initiatives/<施策名>/02_tasks.md に従って実装
    ├── 作業ログを 03_work_log.md に記録
    └── 完了後に 04_work_report.md を生成

    L2セッション — 評価（Evaluator）
    ├── 04_work_report.md をインプットに評価
    ├── 05_eval_plan.md に沿って評価を実施
    └── 06_eval_report.md を生成して L1 に返却
```

---

## ディレクトリ構成

```
dev-process-improvement/
├── README.md                          ← このファイル
├── CLAUDE.md                          ← 全セッション共通ルール
├── .claude/rules/
│   ├── l1-manager.md                  ← L1セッション専用ルール
│   ├── l2-worker.md                   ← L2(実施)セッション専用ルール
│   └── l2-evaluator.md               ← L2(評価)セッション専用ルール
│
├── initiatives/                       ← 改善施策ごとのフォルダ
│   └── _template/                     ← ひな形（コピーして使う）
│       ├── 00_proposal.md             ← 施策提案
│       ├── 01_plan.md                 ← 実施計画
│       ├── 02_tasks.md                ← タスクリスト
│       ├── 03_work_log.md             ← 作業履歴
│       ├── 04_work_report.md          ← 作業レポート
│       ├── 05_eval_plan.md            ← 評価計画
│       ├── 06_eval_report.md          ← 評価レポート
│       ├── 07_issues.md               ← 課題管理
│       └── 08_gate_review.md          ← フェーズゲート判定
│
├── backlog/
│   └── ideas.md                       ← 施策候補のストック
├── templates/                         ← コピペ用プロンプト集
│   ├── l1-prompts.md
│   └── l2-prompts.md
└── docs/
    ├── workflow.md                    ← フロー全体図＋オーナーシップ表
    └── session-guide.md              ← セッション起動方法
```

---

## クイックスタート

### 新しい施策を開始する

```bash
# 1. _template をコピーして施策フォルダを作成
cp -r initiatives/_template initiatives/<施策名>

# 2. 00_proposal.md に施策提案を記入

# 3. L1セッションを起動して計画を立てる
#    → docs/session-guide.md を参照
```

### セッション起動

各セッションタイプの起動手順は [`docs/session-guide.md`](docs/session-guide.md) を参照してください。

---

## フロー概要

```
backlog/ideas.md
    ↓ L1が優先度判定
initiatives/<施策名>/00_proposal.md  → 01_plan.md → 02_tasks.md
    ↓ L2-worker が実施
03_work_log.md → 04_work_report.md
    ↓ L2-evaluator が評価
05_eval_plan.md → 06_eval_report.md
    ↓ L1がゲートレビュー
08_gate_review.md（次フェーズへ進む / 差し戻し / クローズ）
```

詳細は [`docs/workflow.md`](docs/workflow.md) を参照してください。

---

## ルールファイルの適用対象

| ファイル | 適用セッション |
|---|---|
| `CLAUDE.md` | すべてのセッション |
| `.claude/rules/l1-manager.md` | L1セッション起動時 |
| `.claude/rules/l2-worker.md` | L2（実施）セッション起動時 |
| `.claude/rules/l2-evaluator.md` | L2（評価）セッション起動時 |
