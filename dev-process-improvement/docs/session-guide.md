# セッション運用ガイド

## セッションの起動方法

### 方法1: Claude Code Agent Teams（推奨）

Claude Code の Agent Teams 機能を使い、L1をリード、L2をチームメイトとして起動する。

```
# Claude Code を起動し、以下のように指示:

あなたはL1（マネージャー）です。
以下のチームを作成してください:

1. L2-worker（実施セッション）: タスクの実行と作業記録を担当
2. L2-evaluator（評価セッション）: 作業成果の評価を担当

initiatives/[施策名]/ のファイルに従って作業を進めてください。
L2にはplan approvalを要求してください。
```

### 方法2: 手動で3セッション起動

別々のターミナル（またはtmuxペイン）で3つのClaude Codeセッションを起動する。

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

### 方法3: Claude Projects（Web版）

Claude Projectsで3つのプロジェクトを作成し、各プロジェクトのカスタム指示に
CLAUDE.md + 該当するルールファイルの内容を設定する。

## 施策の進め方チェックリスト

### 開始時
- [ ] initiatives/_template/ をコピーして initiatives/<施策名>/ を作成
- [ ] L1: 00_proposal.md を記入
- [ ] L1: 01_plan.md を記入
- [ ] L1: 02_tasks.md を記入
- [ ] L2セッションを起動

### 実施中
- [ ] L2(実施): 03_work_log.md に実施計画サマリを記載
- [ ] L2(実施): タスクを実施し、作業ログを追記
- [ ] L2(実施): 04_work_report.md を作成
- [ ] L2(評価): 05_eval_plan.md を作成
- [ ] L2(評価): 06_eval_report.md を作成
- [ ] L2(実施/評価): 課題があれば 07_issues.md に起票

### ゲート判定
- [ ] L1: 04, 06, 07 を確認
- [ ] L1: 08_gate_review.md に判定を記入
- [ ] L1: 必要に応じて 01_plan.md, 02_tasks.md を修正
- [ ] 判定結果に応じて次フェーズへ or 差し戻し

---

## トリアージセッション

### 概要

inbox・backlog・課題管理CSVを走査・整理する定期メンテナンスセッション。
頻度はユーザー任意（気が向いたとき）。

### セッション起動方法

```bash
cd dev-process-improvement
claude
# → 「あなたはトリアージセッションです。.claude/rules/triage.mdに従ってください。」
```

### トリアージセッション フロー

```
1. 事前調査      → triage/YYYYMMDD/00_pre_investigation.md を埋める
2. 実施計画作成  → triage/YYYYMMDD/01_plan.md を作成（今回の重点を決める）
3. 実施          → inbox / backlog / CSV を走査・分類
4. 作業履歴      → triage/YYYYMMDD/02_work_log.md に記録
5. レポート作成  → triage/YYYYMMDD/03_report.md を作成 → PR として提出
6. ユーザーレビュー待ち
7. backlog反映確認 → ユーザー承認後に backlog/ideas.md を更新
8. 課題起票（あれば）→ triage/YYYYMMDD/04_issues.md
```

### トリアージ チェックリスト

#### 開始時
- [ ] triage/_template/ をコピーして triage/YYYYMMDD/ を作成
- [ ] 00_pre_investigation.md の穴埋めを実施

#### 実施中
- [ ] 01_plan.md を作成（重点を決める）
- [ ] 各タスクを実施し、02_work_log.md に追記
- [ ] 03_report.md を作成

#### 完了時
- [ ] 03_report.md を PR として作成
- [ ] ユーザーにレビューを依頼
- [ ] レビュー承認後、backlog への変更をユーザーに確認
- [ ] 課題があれば 04_issues.md に起票・必要に応じて CSV に転記
