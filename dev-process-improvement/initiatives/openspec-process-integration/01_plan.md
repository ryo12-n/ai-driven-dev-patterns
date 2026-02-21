# 実施計画: openspec-process-integration

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | 基盤文書整備（`project.md` / `AGENTS.md`） | 両ファイルに実用的な内容が記載され、L1 レビューを通過している |
| 2 | コマンド定義（`.claude/commands/` に opsx 系4コマンド追加） | 4コマンドが Claude Code で実行可能であることを確認済み |
| 3 | 試験運用・評価 | サンプル change が1サイクル完了し、評価レポートで推奨「進む」が得られる |

## スケジュール

```
フェーズ1: 基盤文書整備
  └─ T-001: openspec/project.md を記載
  └─ T-002: openspec/AGENTS.md を記載
  └─ フェーズゲート1 → L1 が内容をレビュー・承認

フェーズ2: コマンド定義
  └─ T-003: /opsx:new コマンド作成
  └─ T-004: /opsx:continue コマンド作成
  └─ T-005: /opsx:apply コマンド作成
  └─ T-006: /opsx:archive コマンド作成
  └─ フェーズゲート2 → コマンド動作確認

フェーズ3: 試験運用・評価
  └─ T-007: サンプル change の選定と new 実行
  └─ T-008: continue × 4 でドキュメント一式を生成
  └─ T-009: apply でコード実装（モックレベル可）
  └─ T-010: archive で delta spec をマージ
  └─ フェーズゲート3（最終）→ 評価レポートで総合判定
```

## 成功基準（全体）

1. `openspec/AGENTS.md` に変更サイクル4フェーズ（new / continue / apply / archive）の
   手順と禁止操作が過不足なく記載されている
2. `.claude/commands/opsx-new.md`・`opsx-continue.md`・`opsx-apply.md`・`opsx-archive.md` が
   存在し、Claude Code でスラッシュコマンドとして呼び出し可能
3. `openspec/changes/<sample>/` にサンプル change が完了形で存在し、
   `openspec/specs/` に delta spec がマージ済み

## リソース・前提条件

- Claude Code が `.claude/commands/` ディレクトリのスラッシュコマンドを読み込める環境
- L2 ワーカーが openspec ディレクトリを読み書き可能
- inbox の `openspec_process_improvement.md` を一次ソースとして参照する

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| AGENTS.md の粒度が粗くAIが誤解する | 中 | 高 | 試験 run 中に随時修正し、コマンドとの整合性を確認する |
| コマンド定義と AGENTS.md が重複・矛盾する | 低 | 中 | コマンドは「AGENTS.md を参照して実行する」構成にし、ルールを一元化する |
| サンプル change が複雑すぎて試験 run が完遂できない | 低 | 中 | テーマは小規模なもの（単一エンティティ・1〜2エンドポイント程度）に限定する |

---
**作成者**: L1
**作成日**: 2026-02-21
**最終更新**: 2026-02-21
