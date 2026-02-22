# セッション運用ガイド

## セッション種別の概要

このプロジェクトには **2種類のセッション** があります。

| 種別 | 目的 | 頻度 | 担当ファイル |
|------|------|------|------------|
| **イニシアティブセッション** | 改善施策を計画・実施・評価する | 施策ごと | `initiatives/<施策名>/` |
| **トリアージセッション** | inbox・backlog・CSVを走査・整理する | 任意（気が向いたとき） | `triage/YYYYMMDD/` |

---

## 1. イニシアティブセッション

改善施策を実際に進めるセッションです。L1（マネージャー）と L2（ワーカー/評価）の
3セッション体制で動きます。

```
L1 マネージャー      : 計画・タスク作成・ゲート判定
L2 ワーカー（実施）  : タスク実行・作業記録・レポート作成
L2 ワーカー（評価）  : 成果物の品質評価
```

詳細なフローとファイル構成は [workflow.md](workflow.md) を参照してください。

### 起動方法

**方法1: Claude Code Agent Teams（推奨）**

L1セッションを1つ起動し、以下のプロンプトを与える。
L1がサブエージェント（Taskツール）としてL2を順番に起動・管理する。

```
あなたはL1（マネージャー）セッションです。
CLAUDE.md と .claude/rules/l1-manager.md のルールに従ってください。

対象施策: initiatives/[施策名]/

00_proposal.md・01_plan.md・02_tasks.md を確認し、
l1-manager.md の「L2サブエージェントの起動・オーケストレーション」に従って
L2-worker → L2-evaluator の順で起動してください。
全L2の完了後、08_gate_review.md を作成してください。
```

> **ポイント**
> - L2はL1が自律的に起動する。人間は介在しない。
> - 唯一の人間チェックポイントは `08_gate_review.md` のレビューのみ。
> - L2の起動順序・渡すコンテキストの詳細はL1が判断する（`l1-manager.md` 参照）。

**方法2: 手動で3セッション起動**

```bash
# ターミナル1: L1 マネージャー
cd dev-process-improvement
claude
# → 「あなたはL1（マネージャー）セッションです。CLAUDE.mdと.claude/rules/l1-manager.mdに従ってください。」

# ターミナル2: L2 ワーカー（実施）
cd dev-process-improvement
claude
# → 「あなたはL2（実施）セッションです。.claude/rules/l2-worker.mdに従ってください。」

# ターミナル3: L2 ワーカー（評価）
cd dev-process-improvement
claude
# → 「あなたはL2（評価）セッションです。.claude/rules/l2-evaluator.mdに従ってください。」
```

**方法3: Claude Projects（Web版）**

Claude Projectsで3つのプロジェクトを作成し、各プロジェクトのカスタム指示に
CLAUDE.md + 該当するルールファイルの内容を設定する。

---

## 2. トリアージセッション

inbox・backlog・課題管理CSVを走査・整理する定期メンテナンスセッションです。
施策を「作る・動かす」のではなく、積み上がったアイテムを「捌く・整理する」ことが目的です。

詳細なフローは [workflow.md](workflow.md) を参照してください。

### 起動方法

```bash
cd dev-process-improvement
claude
# → 「あなたはトリアージセッションです。.claude/rules/triage.mdに従ってください。」
```
