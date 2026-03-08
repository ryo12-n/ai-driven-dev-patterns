# OpenSpec ライフサイクルと既存ロールの統合

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 中 |
| **ステータス** | 候補 |
| **起票日** | 2026-03-07 |

## 課題・背景

既存の7ロール（feature_builder, test_writer, reviewer, bug_fixer, refactorer, optimizer, documentarian）に OpenSpec 連携部分の TODO が残存している（roles/ 内に計12箇所）。openspec_specialist のロール定義は整備済みだが、既存ロールとの連携プロトコルが未定義のため、仕様駆動開発の一貫したフローが確立されていない。

課題管理.csv の ISS-006（プロセス改善_課題管理.csv 側）と ISS-002（ai-driven-dev-patterns 側）に関連。

## 期待効果

- 仕様作成 → 実装 → 検証 → アーカイブの一貫したフローが確立される
- 各ロールの openspec 連携 TODO が解消される
- dev_manager の OpenSpec 委譲判断がより具体的になる

## 補足・参考情報

- `roles/dev_manager.md` のセクション 3.5 に OpenSpec 連携判断の基本フレームワークは定義済み
- `docs/design/dev-workflow-overview.md` §5.1 の ISS-006 と対応
- openspec_specialist の仕様→実装連携フロー（dev_manager.md 内）を基に各ロールの TODO を埋める形で実装可能
