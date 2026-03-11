---
name: triage
description: 'トリアージセッションを実行する。inbox・backlog・CSV の定期整理を行い、マネージャー→ワーカー→評価者の3ロール体制で走査・レポートを作成する。'
user-invocable: true
allowed-tools: ["Read", "Write", "Edit", "Bash", "Glob", "Grep", "Agent", "TodoWrite"]
---
# トリアージセッション

トリアージセッションを開始します。以下のロール定義に従って作業を進めてください。

## ロール定義（補助ファイル）

本スキルディレクトリ内の以下のファイルを参照すること。

| ファイル | 役割 |
|---------|------|
| `triage-manager.md` | マネージャー: 事前調査・計画・ワーカーディスパッチ・集約レポート |
| `triage-worker.md` | ワーカー: TGタスクの走査実行・スキャンレポート作成 |
| `triage-evaluator.md` | 評価者: ワーカー走査結果の品質評価 |

## セッション開始時のブランチ整理

セッション開始時、作業フローに入る前に `.claude/skills/dispatcher/session-start-branch-cleanup.md` のルールに従ってブランチ整理を実施すること。

## 起動方法

マネージャーとして起動し、`triage-manager.md` の作業フローに従う。
ワーカー・評価者はマネージャーがサブエージェントとして起動する。

## 引数

`$ARGUMENTS` が指定された場合、その内容をトリアージの重点事項として扱う。
