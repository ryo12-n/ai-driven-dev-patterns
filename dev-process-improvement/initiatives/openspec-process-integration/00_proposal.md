# 改善施策提案: openspec-process-integration

## 背景・課題

`openspec/` ディレクトリには骨格（`specs/`, `changes/`, `project.md`, `AGENTS.md`）が存在するが、
`project.md` および `AGENTS.md` はともに空のテンプレートのままである。

一方、`dev-process-improvement/inbox/openspec_process_improvement.md` には
OpenSpec の具体的な利用方法（変更サイクルの4ステップ・ファイル構成・コマンド体系）が
詳細に記載されており、この知識が openspec 本体に反映されていない状態にある。

結果として、以下の課題が生じている：

- AIエージェントがどのように変更サイクルを開始・進行・アーカイブすればよいかを判断できない
- `/opsx:new`・`/opsx:continue`・`/opsx:apply`・`/opsx:archive` に相当する
  Claude Code コマンドが存在しないため、開発者が手順をその都度口頭で指示する必要がある
- openspec の変更サイクルが属人化しており、再現性のある形で回しにくい

## 目標

1. `openspec/project.md` を整備し、このリポジトリの前提情報を AIエージェントが参照できる状態にする
2. `openspec/AGENTS.md` を整備し、AIエージェントが自律的に変更サイクルを実行できるルールを定義する
3. Claude Code スラッシュコマンド（`/opsx:new`・`/opsx:continue`・`/opsx:apply`・`/opsx:archive`）を
   `.claude/commands/` に作成し、コマンド一発で各フェーズを開始できるようにする
4. サンプルの変更サイクルを1回実施して、プロセスの実用性を確認する

## スコープ

### やること

- `openspec/project.md` の記載（リポジトリ目的・ディレクトリ構成・命名規約）
- `openspec/AGENTS.md` の記載（変更サイクル手順・spec 差分の扱い・禁止操作）
- `.claude/commands/opsx-new.md` の作成（新規 change フォルダ作成と proposal 雛形生成）
- `.claude/commands/opsx-continue.md` の作成（次ドキュメント生成：proposal → spec → design → tasks）
- `.claude/commands/opsx-apply.md` の作成（tasks.md に従ったコード実装の開始）
- `.claude/commands/opsx-archive.md` の作成（delta spec の specs/ へのマージとアーカイブ）
- サンプル change による試験運用（inbox の add-user-profile とは別テーマで実施）

### やらないこと

- 外部 OpenSpec CLI ツールとの実際の統合
- 他プロジェクトへの展開・横展開
- openspec の仕様設計自体の変更（上流仕様は inbox の内容を参照）
- CI/CD パイプラインへの組み込み

## 期待される効果

- AIエージェントが openspec の変更サイクルを自律的に実行できるようになる
- 開発者がコマンド指定だけで spec から実装までを一貫して流せるようになる
- openspec のテンプレートが他の change でも再利用しやすい状態になる
- プロセスのドキュメント化により、チーム内での onboarding コストが下がる

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| AGENTS.md の記述が曖昧でAIが誤操作する | 高 | サンプル試験 run 中に随時修正し、第三者レビューを挟む |
| スラッシュコマンドの動作が Claude Code バージョンで変わる | 中 | コマンドの構造をシンプルに保ち、外部依存を最小化する |
| project.md の記載がリポジトリの実態と合わない | 中 | L1 が記載内容をレビューし、実態に合わせて修正する |
| 試験 change のテーマ選定が不適切で検証が浅くなる | 低 | テーマは inbox 例と同程度の複雑さのものを選ぶ |

---
**起票者**: L1
**起票日**: 2026-02-21
**ステータス**: 起票
