リポジトリ一式を生成しました。全体像と各ファイルの使い方を整理します。

***

## ディレクトリ全体構成

```
dev-process-improvement/
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
├── backlog/ideas.md                   ← 施策候補のストック
├── templates/                         ← コピペ用プロンプト集
│   ├── l1-prompts.md
│   └── l2-prompts.md
└── docs/
    ├── workflow.md                    ← フロー全体図＋オーナーシップ表
    └── session-guide.md              ← セッション起動方法
```

***

## L1 / L2 の分担とファイルのオーナーシップ

ここが一番重要な設計ポイントです。**「誰がどのファイルを書き、誰は読むだけか」**をルールとして明確にしています。



| ファイル | L1（マネージャー） | L2（実施） | L2（評価） |
|---------|:---:|:---:|:---:|
| 00_proposal | ✏️ 作成 | 👁️ 読取 | 👁️ 読取 |
| 01_plan | ✏️ 作成 | 👁️ 読取 | 👁️ 読取 |
| 02_tasks | ✏️ 作成 | ☑️ チェック更新 | 👁️ 読取 |
| 03_work_log | 👁️ 読取 | ✏️ 追記 | 👁️ 読取 |
| 04_work_report | 👁️ 読取 | ✏️ 作成 | 👁️ 読取 |
| 05_eval_plan | 👁️ 読取 | 👁️ 読取 | ✏️ 作成 |
| 06_eval_report | 👁️ 読取 | 👁️ 読取 | ✏️ 作成 |
| 07_issues | 📝 コメント | ✏️ 起票 | ✏️ 起票 |
| 08_gate_review | ✏️ 作成 | 👁️ 読取 | 👁️ 読取 |

この分担は `.claude/rules/` の各ルールファイルで強制しています。Claudeがルール外のファイルを編集しようとしたときに自動的にブレーキがかかる仕組みです。

***

## 改善サイクル1周の流れ

### ステップ1: L1 — 調査・計画・タスク作成

L1セッションで `initiatives/_template/` をコピーし、新しい施策フォルダを作ります。





proposal（何を・なぜ） → plan（どう進めるか・成功基準） → tasks（L2への具体的指示）の順に埋めます。

### ステップ2: L2（実施） — 作業実施・記録・レポート

L2（実施）セッションが `02_tasks.md` を読み、タスクを1つずつ実行。作業はすべて `03_work_log.md` にタイムスタンプ付きで記録し、完了後に `04_work_report.md` をまとめます。




### ステップ3: L2（評価） — 評価計画・評価実施・レポート

L2（評価）セッションが `01_plan.md` の成功基準と `04_work_report.md` を読み、`05_eval_plan.md` → `06_eval_report.md` を作成します。




### ステップ4: 課題起票（L2共通）

実施中・評価中に発見した課題はすべて `07_issues.md` に起票します。L1への「計画変更提案」もここに書きます。



### ステップ5: L1 — ゲート判定・計画修正

L1セッションが `04_work_report.md` + `06_eval_report.md` + `07_issues.md` を読み、`08_gate_review.md` にフェーズゲート判定（通過 / 条件付き通過 / 差し戻し）を書きます。



***

## ルールの強制の仕組み

### `CLAUDE.md` — 全セッション共通



全セッションに常時読み込まれる基本ルールです。L1/L2の責務分離、ファイル命名規則、禁止事項を定義しています。

### `.claude/rules/` — セッション別の条件付きルール





各ルールファイルは `paths:` ヘッダーでトリガー条件を指定しており、**該当ファイルを操作するときだけ自動で読み込まれます**。例えば `l2-worker.md` は `03_work_log.md` や `04_work_report.md` を触るときにだけ発動します。[1][2]

***

## セッション起動方法



3つの方法を用意しています：

1. **Claude Code Agent Teams（推奨）** — L1をリード、L2 2名をチームメイトとして1コマンドで起動。plan approval機能でL1がL2の計画を承認してから実施に入る流れも使えます。[3]

2. **手動3セッション** — 3つのターミナルでそれぞれClaude Codeを起動し、冒頭でロールを伝える。

3. **Claude Projects（Web版）** — 3つのプロジェクトを作り、カスタム指示にルールを設定。

***

## プロンプトテンプレート

実際にセッションで使うコピペ用プロンプトも用意しています。




***

## GitHubに上げる手順

```bash
cd dev-process-improvement
git init
git add .
git commit -m "初期構成: L1/L2マルチセッション開発プロセス改善フレームワーク"
git remote add origin https://github.com/<your-username>/dev-process-improvement.git
git push -u origin main
```

push後、Claude Codeでこのリポジトリを開けばそのまま使い始められます。最初の施策を始めるときは、L1セッションで「`initiatives/_template/` をコピーして新しい施策を開始して」と伝えるだけでOKです。

情報源
[1] Claude Code v2.0.64の新機能「.claude/rules/」で ... - Qiita https://qiita.com/NaokiIshimura/items/c10436a599df39615eed
[2] 効果的なCLAUDE.mdの書き方 https://zenn.dev/farstep/articles/how-to-write-a-great-claude-md
[3] Orchestrate teams of Claude Code sessions https://code.claude.com/docs/en/agent-teams
[4] Managing Multiple AI Agent Sessions Without Losing Your Mind https://agents-ui.com/blog/managing-multiple-ai-agent-sessions/
[5] Why Autonomous Infrastructure is the future: From intent ... https://www.cncf.io/blog/2025/10/17/why-autonomous-infrastructure-is-the-future-from-intent-to-self-operating-systems/
[6] How I Built a Multi-Agent Orchestration System with Claude ... https://www.reddit.com/r/ClaudeAI/comments/1l11fo2/how_i_built_a_multiagent_orchestration_system/
[7] AI Agent Orchestration Patterns - Azure Architecture Center https://learn.microsoft.com/en-us/azure/architecture/ai-ml/guide/ai-agent-design-patterns
[8] Go Microservices for AI/ML Orchestration - Rost Glukhov https://www.glukhov.org/post/2025/11/go-microservices-for-ai-ml-orchestration-patterns/
[9] Claude Code Task Completion System - Multi-Agent Workflow for Production-Ready Features https://www.reddit.com/r/ClaudeAI/comments/1n4yjtj/claude_code_task_completion_system_multiagent/
[10] Orchestrating Multi-Agent Systems: Technical Patterns for ... https://www.linkedin.com/pulse/orchestrating-multi-agent-systems-technical-patterns-complex-kiran-b8o2f
[11] AI-RAN: Telecom Infrastructure for the Age of AI https://www.softbank.jp/corp/set/data/technology/research/story-event/Whitepaper_Download_Location/pdf/SoftBank_AI_RAN_Whitepaper_December2024.pdf
[12] Claude Code's Hidden Multi-Agent System https://paddo.dev/blog/claude-code-hidden-swarm/
[13] Orchestrating Human-AI Teams: The Manager Agent as a ... https://arxiv.org/html/2510.02557v1
[14] AI Slop to Production Code - Orchestre https://orchestre.dev/blog/multi-llm-orchestration-patterns
[15] Design Patterns for Agentic AI and Multi-Agent Systems https://appstekcorp.com/staging/8353/blog/design-patterns-for-agentic-ai-and-multi-agent-systems/
[16] “Taste driven” multi-agent system for Microsoft 365 Copilot https://techcommunity.microsoft.com/blog/microsoft365copilotblog/office-agent-%E2%80%93-%E2%80%9Ctaste-driven%E2%80%9D-multi-agent-system-for-microsoft-365-copilot/4457397
[17] Three-Tier Model Strategy https://github.com/wshobson/agents
