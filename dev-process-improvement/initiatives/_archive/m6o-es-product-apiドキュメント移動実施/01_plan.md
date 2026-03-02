# 実施計画: m6o-es-product-api ドキュメント移動実施

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | ファイル移動・改名・CLAUDE.md更新 | 全86件移動完了、CLAUDE.md パス参照0件 |
| 評価 | 移動結果の評価（evaluator） | 全件照合完了、課題ゼロまたは軽微 |

## 成功基準（全体）

1. `m6o-es-product-api/my_work/` 配下のファイルが全件 `git mv` により新ディレクトリへ移動され、`my_work/` が空になっている
2. `m6o-es-product-api/CLAUDE.md` 内の `my_work/` パス参照が0件になっている（`grep my_work CLAUDE.md` で確認）
3. `.claude/rules/` に配置した4ファイルが kebab-case 英語名に改名されている
4. evaluator による全件照合で、`design.md` との不一致が0件

## リソース・前提条件

- 作業対象リポジトリ: `/home/developer/projects/m6o-es-product-api_dev_process_improvement/m6o-es-product-api/`
- 設計書: `dev-process-improvement/initiatives/_archive/m6o-es-product-apiドキュメント整理/design.md`（マッピング表 86件）
- 前提: フェーズ1（ドキュメント整理）のゲート判定が「通過」済み

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| ファイル移動漏れ | 低 | 高 | T-005 で整合性検証、evaluator で全件照合 |
| CLAUDE.md パス更新漏れ | 低 | 中 | T-004 後に grep で残存確認（T-005 に含む） |
| git mv 誤操作 | 低 | 中 | 移動後 `git diff --stat` で件数確認 |
| m6o-es-product-api の未コミット変更との衝突 | 低 | 中 | 作業前に `git status` で確認 |

---
**作成者**: L1
**作成日**: 2026-03-02
**最終更新**: 2026-03-02
