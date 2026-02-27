# 評価計画: openspec-process-integration

## 評価対象

OpenSpec v1.1.1 を前提とした成果物一式。
当初計画（`project.md` / `AGENTS.md`）は v1.1.1 のアーキテクチャ変更により廃止され、
`config.yaml` + Skills（`.claude/skills/openspec-*/SKILL.md`）に置き換わっている。
本計画はその実態に合わせて評価項目を設定する。

## 評価項目

| # | 評価項目 | 評価方法 | 判定基準（合格ライン） |
|---|---------|---------|---------------------|
| 1 | `openspec/config.yaml` の充足度 | ファイル内容のレビュー | `context:` にリポジトリ前提情報が記載され、`rules:` にアーティファクト別ルールが記載されている |
| 2 | Skills（SKILL.md × 10）の充足度 | ファイル内容のレビュー | 変更サイクル4フェーズ（new/continue/apply/archive）の手順・Guardrails が各SKILLに記載されている |
| 3 | opsx コマンド（10種）の存在確認 | `.claude/commands/opsx/` の内容確認 | 10ファイルすべてが存在し、Claude Code のスラッシュコマンドとして呼び出し可能な形式になっている |
| 4 | サンプル change の完遂 | `openspec/changes/archive/` および `openspec/specs/` の状態確認 | 変更サイクルが new → archive まで一通り完了し、delta spec が specs/ にマージされている |

## 評価スケジュール

- L2（実施）による作業完了後に実施

## 前提・制約

- サンプル change のコード実装はモックレベルで可（動作確認より手順確認を重視）
- `project.md` / `AGENTS.md` は OpenSpec v1.1.1 で廃止済みのため評価対象外とする

---
**作成者**: L2（評価）
**作成日**: 2026-02-23
