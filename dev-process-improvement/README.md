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
├── .claude/rules/                       # セッション別 Claude ルール（AIの動作仕様・SOT）
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
└── docs/                                # 運用ドキュメント（人間向け）
    ├── workflow.md                       # プロセス仕様書（.claude/rules/ の人間向け可視化）
    └── implementation.md                 # 実装ノート・補足
```

---

## セッション種別と起動方法

| 種別 | 目的 | 頻度 | 使用ルール | 成果物の場所 |
|------|------|------|-----------|------------|
| **L1 マネージャー** | 調査・計画立案・タスク作成・ゲート判定 | 施策ごと | `l1-manager.md` | `initiatives/<施策名>/` |
| **L2 ワーカー（実施）** | タスク実行・作業記録・レポート作成 | 施策ごと | `l2-worker.md` | `initiatives/<施策名>/` |
| **L2 ワーカー（評価）** | 成果物の品質評価・評価レポート作成 | 施策ごと | `l2-evaluator.md` | `initiatives/<施策名>/` |
| **トリアージ** | inbox・backlog・CSV の定期整理 | 任意 | `triage.md` | `triage/YYYYMMDD/` |

### 1. イニシアティブセッション

改善施策を実際に進めるセッション。L1（マネージャー）と L2（ワーカー/評価）の3セッション体制で動く。

```
L1 マネージャー      : 計画・タスク作成・ゲート判定
L2 ワーカー（実施）  : タスク実行・作業記録・レポート作成
L2 ワーカー（評価）  : 成果物の品質評価
```

プロセスの詳細フローとファイルオーナーシップは [`docs/workflow.md`](docs/workflow.md) を参照。

#### 起動方法

**マネージャー・ワーカー方式**

L1セッションを1つ起動し、以下のプロンプトを与える。
L1がサブエージェント（Taskツール）としてL2を順番に起動・管理する。

**新施策を開始する**

```
dev-process-improvement/.claude/rules/l1-manager.md に従う
backlog: <施策名>
```

**既存施策を継続する**

```
dev-process-improvement/.claude/rules/l1-manager.md に従う
施策: initiatives/<フォルダ名>/
```

> - L2はL1が自律的に起動する。人間は介在しない。
> - 唯一の人間チェックポイントは `08_gate_review.md` のレビューのみ。
> - L2の起動順序・渡すコンテキストの詳細はL1が判断する（`l1-manager.md` 参照）。

---

### 2. トリアージセッション

inbox・backlog・課題管理CSVを走査・整理する定期メンテナンスセッション。
施策を「作る・動かす」のではなく、積み上がったアイテムを「捌く・整理する」ことが目的。

```bash
cd dev-process-improvement
claude
# → 「あなたはトリアージセッションです。.claude/rules/triage.mdに従ってください。」
```

---

## ドキュメントマップ

### 人間向けドキュメント

| ドキュメント | 役割 | 備考 |
|------------|------|------|
| **このREADME** | エントリーポイント。セッション起動方法・全体マップ | - |
| [`docs/workflow.md`](docs/workflow.md) | プロセス全体の仕様書（フロー図・ファイルオーナーシップ・課題管理フロー） | `.claude/rules/` の人間向け可視化。ルール変更時は合わせて更新する |

### AI 向けルールファイル（Source of Truth）

| ルールファイル | 対応セッション | workflow.md との関係 |
|--------------|--------------|---------------------|
| [`.claude/rules/l1-manager.md`](.claude/rules/l1-manager.md) | L1 マネージャー | workflow.md のイニシアティブフロー（L1部分）の実行仕様 |
| [`.claude/rules/l2-worker.md`](.claude/rules/l2-worker.md) | L2 ワーカー（実施） | workflow.md のイニシアティブフロー（L2実施部分）の実行仕様 |
| [`.claude/rules/l2-evaluator.md`](.claude/rules/l2-evaluator.md) | L2 ワーカー（評価） | workflow.md のイニシアティブフロー（L2評価部分）の実行仕様 |
| [`.claude/rules/triage.md`](.claude/rules/triage.md) | トリアージ | workflow.md のトリアージフローの実行仕様 |

> **整合性の原則**: `.claude/rules/*.md` が正の情報源（SOT）。`docs/workflow.md` はその人間向け要約。
> ルールを変更したら `workflow.md` も合わせて更新すること。

### その他

| 知りたいこと | 参照先 |
|------------|--------|
| 施策のひな形・各ファイルの書き方 | [`initiatives/_template/`](initiatives/_template/) |
| トリアージのひな形・手順 | [`triage/_template/`](triage/_template/) |
| 課題の一覧・ステータス | [`プロセス改善_課題管理.csv`](プロセス改善_課題管理.csv) |
| 施策候補・バックログ | [`backlog/ideas.md`](backlog/ideas.md) |
