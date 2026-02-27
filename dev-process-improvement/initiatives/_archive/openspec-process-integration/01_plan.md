# 実施計画: openspec-process-integration

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1A | CLI 統合（`openspec init` でコマンド・スキルを自動生成） | `.claude/commands/opsx/` と `.claude/skills/` が生成され、生成物を確認済み |
| 1B | 基盤文書整備（`project.md` / `AGENTS.md`） | 両ファイルに実用的な内容が記載され、L1 レビューを通過している |
| 2 | コマンド確認・カスタマイズ（init 生成コマンドの動作検証） | 4コマンドが Claude Code で実行可能であることを確認済み |
| 3 | 試験運用・評価 | サンプル change が1サイクル完了し、評価レポートで推奨「進む」が得られる |

## スケジュール

```
フェーズ1A: CLI 統合
  └─ T-000: npm install -g @fission-ai/openspec@latest（バージョン記録）
  └─ T-001: openspec init を実行（Claude Code 向け設定を選択）
  └─ 生成物確認: .claude/commands/opsx/ と .claude/skills/ の内容を検証

フェーズ1B: 基盤文書整備
  └─ T-002: openspec/project.md を記載
  └─ T-003: openspec/AGENTS.md を記載
  └─ フェーズゲート1 → L1 が 1A 生成物 + 1B 文書をレビュー・承認

フェーズ2: コマンド確認・カスタマイズ
  └─ T-004: 生成コマンド（new/continue/apply/archive）の動作確認
  └─ T-005: このリポジトリ向けにカスタマイズが必要な箇所を修正
  └─ フェーズゲート2 → 4コマンドの動作確認完了

フェーズ3: 試験運用・評価
  └─ T-006: サンプル change の選定と /opsx:new 実行
  └─ T-007: /opsx:continue でドキュメント一式を生成
  └─ T-008: /opsx:apply でコード実装（モックレベル可）
  └─ T-009: /opsx:archive で delta spec をマージ
  └─ フェーズゲート3（最終）→ 評価レポートで総合判定
```

## 成功基準（全体）

1. `openspec init` によって `.claude/commands/opsx/` にコマンドが自動生成されている
2. `openspec/AGENTS.md` に変更サイクル4フェーズ（new / continue / apply / archive）の
   手順と禁止操作が過不足なく記載されている
3. 生成コマンド（opsx:new・opsx:continue・opsx:apply・opsx:archive）が
   Claude Code でスラッシュコマンドとして呼び出し可能
4. `openspec/changes/<sample>/` にサンプル change が完了形で存在し、
   `openspec/specs/` に delta spec がマージ済み

## リソース・前提条件

- Node.js v20.19.0 以上（環境: v22.22.0 ✅）および npm（環境: v10.9.4 ✅）
- Claude Code が `.claude/commands/` ディレクトリのスラッシュコマンドを読み込める環境
- L2 ワーカーが openspec ディレクトリを読み書き可能
- inbox の `openspec_process_improvement.md` を一次ソースとして参照する

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| `openspec init` の生成物が既存の openspec/ 構造と競合する | 中 | 中 | init 前に既存ファイルを git commit し、init 後の差分を確認してから進める |
| AGENTS.md の粒度が粗くAIが誤解する | 中 | 高 | 試験 run 中に随時修正し、コマンドとの整合性を確認する |
| CLI バージョンアップで生成コマンドの仕様が変わる | 低 | 中 | インストール時のバージョンを記録し、package.json 等でピン留めを検討する |
| サンプル change が複雑すぎて試験 run が完遂できない | 低 | 中 | テーマは小規模なもの（単一エンティティ・1〜2エンドポイント程度）に限定する |

---
**作成者**: L1
**作成日**: 2026-02-21
**最終更新**: 2026-02-21（CLI統合をスコープに追加し計画を改訂）
