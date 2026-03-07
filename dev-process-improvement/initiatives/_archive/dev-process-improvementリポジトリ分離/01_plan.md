# 実施計画: dev-process-improvement リポジトリ分離

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | 新リポ作成・コンテンツ移行・親リポ参照更新・削除 | 新リポにコンテンツが存在し、親リポから dev-process-improvement/ が削除され、全参照が更新済み |

## 実施順序

単一フェーズで以下の順に実施する。

1. **新リポの作成と初期化**: GitHub に `ryo12-n/dev-process-improvement` リポを作成し、コンテンツをコピー・push
2. **親リポの collab-log 新設**: `docs/collab-log.md` を親リポ内に作成し、既存の collab-log 内容を移設
3. **親リポの参照更新**: 8ファイルの参照を更新
4. **親リポから dev-process-improvement/ を削除**: `git rm -r` で削除

## 成功基準（全体）

1. `https://github.com/ryo12-n/dev-process-improvement` にコンテンツが存在し、README.md からセッション起動方法が分かる
2. 親リポの 8 ファイルすべてで dev-process-improvement への参照が更新済み
3. 親リポに `docs/collab-log.md` が存在し、CLAUDE.md のパスが更新済み
4. 親リポから `dev-process-improvement/` が削除済み

## リソース・前提条件

- `gh` CLI で `ryo12-n/dev-process-improvement` リポジトリを作成できること
- GitHub の push 権限があること

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| `gh repo create` 権限不足 | 中 | 高 | タスク実行時に権限確認を最初に行い、不可なら手動作成を依頼 |
| 参照更新漏れ | 低 | 中 | 事前洗い出し済みの8ファイルをチェックリスト化 |
| 新リポの CLAUDE.md / README.md のパス不整合 | 低 | 中 | コピー後にパス参照の `dev-process-improvement/` プレフィックスを一括検索・修正 |

---
**作成者**: L1
**作成日**: 2026-03-02
**最終更新**: 2026-03-02
