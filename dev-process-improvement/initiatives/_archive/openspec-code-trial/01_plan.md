# 実施計画: openspec-code-trial

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | 環境準備・openspec チェンジ作成（proposal → specs → design → tasks） | openspec/changes/ に change ディレクトリが作成され、4成果物（proposal.md, specs/, design.md, tasks.md）が揃っている |
| 2 | コード実装・検証（apply → verify → archive） | `src/` に Go コードが実装済み、テストが通り、change がアーカイブされている |

## スケジュール

```
フェーズ1: 環境準備・openspec チェンジ作成
  └─ T-001: Go 環境の確認
  └─ T-002: /opsx:new で change を作成
  └─ T-003: /opsx:continue（または /opsx:ff）で成果物一式を生成
  └─ フェーズゲート → L2 が成果物の整合性を自己確認

フェーズ2: コード実装・検証
  └─ T-004: /opsx:apply で Go コードを実装
  └─ T-005: ビルド・テスト実行で動作確認
  └─ T-006: /opsx:verify で整合性検証
  └─ T-007: /opsx:archive で delta spec マージ・アーカイブ
  └─ T-008: プロセス知見の記録
  └─ T-009: 07_issues.md の課題を CSV へ転記
```

## 成功基準（全体）

1. openspec の変更サイクル（new → continue → apply → verify → archive）が1回完遂している
2. `src/` に Go のサンプルアプリケーションが存在し、`go build` と `go test` が成功する
3. `openspec/specs/` に delta spec がマージされている
4. プロセスの有効性・課題に関する知見が `04_work_report.md` に記録されている

## リソース・前提条件

- Go 1.21 以上が利用可能であること
- openspec skills（`/opsx:new`, `/opsx:continue`, `/opsx:apply`, `/opsx:verify`, `/opsx:archive`）が動作すること
- `openspec/config.yaml` が正しく設定されていること（既に整備済み）

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| Go 環境が未インストール | 中 | 高 | T-001 で早期確認し、未インストールなら報告して対応方針を決定 |
| openspec apply が実コード生成で不具合を起こす | 中 | 中 | 手動で実装を補完し、スキル改善点として記録する |
| サンプルアプリのスコープが大きすぎる | 低 | 中 | 要件を2-5個に限定し、CLI ツール程度の規模に抑える |
| specs の記述粒度がコード生成に不十分 | 中 | 中 | 検証中に specs の改善点を 07_issues.md に記録する |

---
**作成者**: L1
**作成日**: 2026-02-28
**最終更新**: 2026-02-28
