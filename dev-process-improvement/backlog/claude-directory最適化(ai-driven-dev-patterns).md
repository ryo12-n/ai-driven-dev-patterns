# .claude/ ディレクトリ用途最適化

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 中 |
| **ステータス** | 候補 |
| **起票日** | 2026-03-05 |

## 課題・背景

文書分類ポリシー（CLAUDE.md）の導入により、rules / skills / agents の使い分け基準が明確になった。しかし既存の `.claude/` 配下のファイル配置は歴史的経緯で最適化されていない。

具体的な課題：
- `rules/claude-directory-guide.md` が約500行あり、毎リクエスト読み込みでコンテキストを圧迫している（オンデマンド参照で十分な内容）
- `rules/role-format-guide.md` もロール作成時のみ必要だが常時読み込みされている
- `rules/parallel-dev.md` は並列開発時のみ必要だが常時読み込みされている
- `roles/` 配下のロール定義が `.claude/agents/` に移行できる可能性がある
- `settings.json` に `$schema` や deny ルールが未設定

## 期待効果

- コンテキストウィンドウの圧迫軽減（rules/ の常時読み込み量を削減）
- 文書分類ポリシーに準拠した一貫性のあるディレクトリ構成
- Claude の応答精度向上（不要なコンテキストの排除）

## 補足・参考情報

- 文書分類ポリシー: `CLAUDE.md` の「文書分類ポリシー」セクション
- 標準構成ガイド: `.claude/rules/claude-directory-guide.md` セクション4（差異分析・改善方針）
- 今回のトリアージルール移動（rules → skills/triage）が先行事例

### rules 配下の配置基準（知見整理）

`.claude/rules` 配下には「プロジェクト用の細かいルールを分割した Markdown ファイル」を置くのが基本。

- 各ファイルは Markdown（`.md`）で書く
- 大きな「CLAUDE.md」を役割別の小さなルールファイルに分割するイメージ
- サブディレクトリを掘って領域別に整理するのが推奨（`frontend/`、`backend/` 等）
- YAML フロントマター `paths:` で「どのパスにだけ効かせるか」を指定可能
- `paths` ありはマッチしたファイル編集時のみ適用。全体に効かせたいルールは `paths` なしで記述

**CLAUDE.md との役割分担**:
- `CLAUDE.md`: プロジェクト全体に共通する方針や大枠のルール
- `.claude/rules/*.md`: 言語別・レイヤ別・チーム別など、より細かい局所ルール

### 参考リンク

- [CLAUDE.mdファイルはどこに置くべき？](https://note.com/popo__cho/n/n48d778f742be)
- [Claude Code v2.0.64の新機能「.claude/rules/」](https://qiita.com/NaokiIshimura/items/c10436a599df39615eed)
- [【保存版】Claude Codeの新機能Claude Rulesの使い方と4つの公式ベストプラクティス](https://note.com/masa_wunder/n/n60c2ec107c52)
- [Claude Code入門 #2: CLAUDE.mdの書き方と育て方](https://qiita.com/dai_chi/items/8d9d3ac82cbd3c05c883)
- [【Claude Code】結局CLAUDE.mdはどこに置けばいいの？](https://zenn.dev/76hata/articles/6744b16d2241ad)
- [Claude があなたのプロジェクトを記憶する方法](https://code.claude.com/docs/ja/memory)
