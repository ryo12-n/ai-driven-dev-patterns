# triage.md に「関連ファイル一覧」セクションを追加

## 概要

triage.md のルールを変更した場合に連動して更新が必要なファイルの対応関係を、ルールファイル自体に明文化する。

## 背景

- backlog-relationship-analysis 施策（ISS-029）で L2-worker と L2-evaluator が独立して同一の知見に到達
- triage.md を変更する際、以下のファイルの同時更新が必要だが明文化されていない:
  - `triage/_template/00_pre_investigation.md`
  - `triage/_template/01_plan.md`
  - `triage/_template/03_report.md`
  - `docs/workflow.md`

## 提案

triage.md の冒頭またはセクション末尾に「関連ファイル一覧」を追加し、ルール変更時に連動更新が必要なファイルを明記する。

## 起票元

- 施策: backlog-relationship-analysis
- 08_gate_review.md 次施策候補
- 関連課題: ISS-029

---
**起票日**: 2026-03-04
