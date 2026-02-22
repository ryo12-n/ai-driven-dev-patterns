# dev-process-improvement

開発プロセス改善サイクルを管理するディレクトリ。
**イニシアティブセッション**（施策の計画・実施・評価）と**トリアージセッション**（inbox・backlog の定期整理）の2種類のセッションで運用する。

## ディレクトリ構成

```
dev-process-improvement/
│
├── CLAUDE.md                            # 全セッション共通の Claude ルール
├── プロセス改善_課題管理.csv             # 全施策横断の課題管理（単一ソース・オブ・トゥルース）
│
├── .claude/rules/                       # セッション別 Claude ルール
│   ├── l1-manager.md                    # L1（マネージャー）セッション用
│   ├── l2-worker.md                     # L2（実施ワーカー）セッション用
│   ├── l2-evaluator.md                  # L2（評価ワーカー）セッション用
│   └── triage.md                        # トリアージセッション用
│
├── initiatives/                         # 改善施策ごとのフォルダ
│   ├── _template/                       # 新規施策のひな形
│   │   ├── 00_proposal.md               # 施策提案
│   │   ├── 01_plan.md                   # 実施計画
│   │   ├── 02_tasks.md                  # タスク一覧
│   │   ├── 03_work_log.md               # 作業履歴
│   │   ├── 04_work_report.md            # 作業レポート
│   │   ├── 05_eval_plan.md              # 評価計画
│   │   ├── 06_eval_report.md            # 評価レポート
│   │   ├── 07_issues.md                 # 施策内一時メモ（完了時に CSV へ転記）
│   │   └── 08_gate_review.md            # フェーズゲート判定
│   └── <施策名>/                        # 実施中・完了施策（_template と同構成）
│
├── triage/                              # トリアージセッションの成果物
│   ├── _template/                       # トリアージセッションのひな形
│   │   ├── 00_pre_investigation.md      # 事前調査
│   │   ├── 01_plan.md                   # 実施計画
│   │   ├── 02_work_log.md               # 作業履歴・粒度の粗いメモ置き場
│   │   └── 03_report.md                 # 振り返りレポート（PR として提出）
│   └── YYYYMMDD/                        # セッションごとのフォルダ（_template をコピーして使う）
│
├── inbox/                               # 未処理アイテムの投入口
│   └── <ファイル名>.md                  # 検討候補・気づき・外部インプット
│
├── backlog/                             # 施策候補・アイデアのストック
│   └── ideas.md                         # 優先度付きアイデア一覧
│
├── templates/                           # セッション起動プロンプトのひな形
│   ├── l1-prompts.md
│   └── l2-prompts.md
│
└── docs/                                # 運用ドキュメント
    ├── workflow.md                       # フロー全体の説明・図
    ├── session-guide.md                  # セッション運用ガイド（起動方法・チェックリスト）
    └── implementation.md                 # 実装ノート・補足
```

## セッション種別

| 種別 | 目的 | 使用ルール | 成果物の場所 |
|------|------|-----------|------------|
| L1 マネージャー | 調査・計画立案・タスク作成・ゲート判定 | `l1-manager.md` | `initiatives/<施策名>/` |
| L2 ワーカー（実施） | タスク実行・作業記録・レポート作成 | `l2-worker.md` | `initiatives/<施策名>/` |
| L2 ワーカー（評価） | 成果物の品質評価・評価レポート作成 | `l2-evaluator.md` | `initiatives/<施策名>/` |
| トリアージ | inbox・backlog・CSV の定期整理 | `triage.md` | `triage/YYYYMMDD/` |

起動方法・チェックリストの詳細 → [`docs/session-guide.md`](docs/session-guide.md)

## ドキュメントマップ

| 知りたいこと | 読むファイル |
|------------|------------|
| フロー全体の流れ・図 | [`docs/workflow.md`](docs/workflow.md) |
| セッションの起動方法・チェックリスト | [`docs/session-guide.md`](docs/session-guide.md) |
| Claude に与えるルールの詳細 | [`.claude/rules/`](.claude/rules/)（種別ごとの `.md`） |
| 施策のひな形・各ファイルの書き方 | [`initiatives/_template/`](initiatives/_template/) |
| トリアージのひな形・手順 | [`triage/_template/`](triage/_template/) と `.claude/rules/triage.md` |
| 課題の一覧・ステータス | [`プロセス改善_課題管理.csv`](プロセス改善_課題管理.csv) |
| 施策候補・バックログ | [`backlog/ideas.md`](backlog/ideas.md) |
