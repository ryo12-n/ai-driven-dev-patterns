# 改善施策提案: organize-readme

## 背景・課題

ai-driven-dev-patterns リポジトリの README が OpenSpec ディレクトリ構成と `/opsx:*` 開発フローのみを扱っており、以下の資産が完全に不可視の状態にある:

- dispatcher スキル（メインエントリーポイント）
- dev_manager オーケストレーター
- 8つの専門ロール（feature_builder, test_writer, reviewer, bug_fixer, documentarian, refactorer, optimizer, openspec_specialist）
- 5シナリオ分類（要件定義〜設計 / 実施計画〜開発実施 / 独立評価 / ドキュメント整合性 / リファクタリング・最適化）

初見ユーザーがリポジトリの本質的な価値（マルチエージェントセッションシステム）を把握できない状態になっている。

## 目標

README を人間向けエントリーポイントとして再構成し、「何ができるか」「どう始めるか」を5分以内で把握できるようにする。

## スコープ

### やること

- README.md の全面書き直し（簡潔なエントリーポイントとして ~150行）
- docs/session-guide.md の新規作成（詳細セッション情報の移管先 ~200-300行）
- initiative ファイル群（00〜08）の作成

### やらないこと

- 既存ロール定義ファイル（roles/*.md）の変更
- 既存スキルファイル（.claude/skills/）の変更
- 設計書（docs/design/）の変更

## 期待される効果

- 初見ユーザーのオンボーディング時間短縮
- マルチエージェントセッションシステムの可視性向上
- コピー可能なプロンプト例の提供によるユーザー自律性向上

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| 既存 README リンクの破損 | 低 | 削除ではなく移動のみ。既存外部リンクは doc URL 変更で対応 |
| docs/session-guide.md とロール定義の重複 | 中 | 詳細はロール定義を参照先として明示し、session-guide は概要のみ記載 |

## 壁打ちの背景

- フルリライト + ドキュメント分離方針を選択（詳細は README ではなく docs/ に分離）
- dev-process-improvement/README.md をスタイル参考モデルとして採用
- branch: claude/organize-ai-dev-patterns-2uaCD で作業

---
**起票者**: L1
**起票日**: 2026-03-04
**ステータス**: 実施中
