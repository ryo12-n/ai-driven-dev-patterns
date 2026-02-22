# 参照物: ai-driven-development-poc

## 起票日
2026-02-22

## 参照先
`refs/ai-driven-development-poc/`

## 概要
別リポジトリで試作したパラレルエージェントフレームワークのディレクトリ構成・実装物。
開発プロセス改善の参照として持ち込んだ。

## 主なコンテンツ
- `.claude/roles/` — 役割別エージェントのプロンプト（bug_fixer, refactorer, reviewer など）
- `.claude/protocols/` — commit / lock / test の協調プロトコル
- `.claude/base_prompt.md` — ベースプロンプト
- `scripts/` — エージェント起動・チーム編成スクリプト
- `docs/reference.md` — 設計ドキュメント

## トリアージへの問い
- このフレームワークのどの部分がこのリポジトリの改善施策として取り込めるか？
- initiatives として立案すべき施策があるか？（例: ロール別エージェント設計の整備、プロトコル整備）
- 参照として保持し続けるか、施策化後に `refs/` から削除するか？
