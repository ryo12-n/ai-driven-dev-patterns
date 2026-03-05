# .claude/ ディレクトリ用途最適化（dev-process-improvement）

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 中 |
| **ステータス** | 候補 |
| **対象リポジトリ** | dev-process-improvement |
| **起票日** | 2026-03-05 |

## 課題・背景

文書分類ポリシーの導入により rules / skills の使い分け基準が明確になった。しかし dev-process-improvement の `.claude/rules/` 配下のファイルは全て常時読み込みされており、最適化の余地がある。

具体的な課題：
- `rules/l1-manager.md`, `l2-worker.md`, `l2-evaluator.md` はそれぞれ特定セッション時のみ必要だが、全セッションで常時読み込みされている
- `rules/triage.md` も同様にトリアージ時のみ必要
- `rules/commit-message.md` は常時参照が妥当だが、他のルールは skills 化でオンデマンド読み込みにできる
- ルート側の skills/triage/ への移動が先行事例として存在するが、dev-process-improvement 側のトリアージルール（triage.md）との整合性が未整理

## 期待効果

- コンテキストウィンドウの圧迫軽減（セッション種別に無関係なルールの読み込みを排除）
- 文書分類ポリシーに準拠した一貫性のあるディレクトリ構成
- セッション起動時に必要なルールだけが読み込まれる効率的な構成

## 補足・参考情報

- 文書分類ポリシー: ルート `CLAUDE.md` および `dev-process-improvement/CLAUDE.md` の「文書分類ポリシー」セクション
- 先行事例: ルート側トリアージルールの rules → skills/triage 移動
- リポジトリ分離を見据えた設計が必要（将来 `claude --add-dir` でルート参照する運用になる）
