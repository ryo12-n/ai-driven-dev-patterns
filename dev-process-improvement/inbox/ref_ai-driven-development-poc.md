# 参照物ポインター: ai-driven-development-poc

## 対象
`refs/ai-driven-development-poc/`

## 概要
AI駆動開発のPoC（Proof of Concept）リポジトリ。複数AIエージェントが並列動作する際の協調プロトコル設計・ロール別エージェント構成のサンプル実装を含む。

主な内容:
- ロール別エージェントプロンプト（`.claude/roles/`）: bug_fixer / feature_builder / reviewer / refactorer / optimizer / test_writer / documentarian
- 協調プロトコル（`.claude/protocols/`）: commit_protocol / lock_protocol / test_protocol
- エージェント起動スクリプト（`scripts/`）: launch_agent / launch_team / setup_hooks
- CI実行スクリプト（`ci/`）: run_fast / run_full

## 今後の扱い方針

**参照のみ保持**。他に参考になる構成・情報がないか引き続き確認する。

- ロール別プロンプト設計の参考として「ロール別エージェントプロンプト整備」施策実施時に参照する
- 協調プロトコル設計の参考として「協調プロトコル整備（commit/lock/test）」施策実施時に参照する
- 削除は施策実施・参照完了後に改めて判断する

## 起票日
2026-02-24

## 起票元
トリアージセッション 2026-02-24
