# 長文 rules のコンテキストコスト最適化

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 🟡 中 |
| **ステータス** | 候補 |
| **対象リポジトリ** | 横断 |
| **起票日** | 2026-03-06 |

## 課題・背景

`.claude/rules/` 配下のファイルは `paths` フロントマターの有無で読み込みタイミングが変わるが、大きなファイルを rules に置くとコンテキストを常時圧迫する。現状、両リポジトリに500行超の rules ファイルが存在し、セッション開始時から常時コンテキストに乗っている。

### 挙動の整理

| 状況 | 読み込みタイミング | コンテキスト常駐 |
|------|------------------|-----------------|
| `paths` **なし** | セッション開始時に全文読み込み | 常時 |
| `paths` **あり** | マッチするファイルにアクセスしたとき | 一度読まれたら常駐（セッション中消えない） |

### 重要な知見

- `paths` ありでも、一度読み込まれたルールはその後マッチしないファイルに移動してもコンテキストから消えない
- そのため `paths` は「大きなドキュメントの読み込み制御」には向かず、「短いパス固有ルール」（10行程度）に使うのがベスト
- 大きなドキュメントは skills 化して `disable-model-invocation: true` にするのが確実な解決策
- skills 化すれば、セッション開始時は description（1行）だけがロードされる
- `context: fork` を併用すればメインコンテキストも汚染しない

## 期待効果

- コンテキストウィンドウの圧迫軽減（長文ガイドがオンデマンド読み込みになる）
- Claude の応答精度向上（不要なコンテキストの排除）
- 両リポジトリで一貫した rules/skills の使い分け基準が確立される

## 補足・参考情報

### 改善パターン例

```diff
.claude/
├── rules/
-   ├── claude-directory-guide.md    # 常時読み込み（重い）
│   ├── code-in-docs.md
│   └── ...
+└── skills/
+    └── directory-guide/
+        └── SKILL.md                 # /directory-guide で呼び出し専用
```

- `disable-model-invocation: true` で手動呼び出し専用にする
- 小さいルール（commit-message.md, code-in-docs.md 等）はそのまま rules に置いて常時適用で問題ない

### 関連施策

- `backlog/claude-directory最適化(ai-driven-dev-patterns).md` — ai-driven-dev-patterns 側の具体的な最適化施策
- `backlog/claude-directory最適化.md` — dev-process-improvement 側の具体的な最適化施策

### inbox 原文

本施策は `inbox/長文のrulesの扱い.md` を施策化したもの。

### 参考リンク

- [CLAUDE.mdの肥大化を防ぐ！.claude/rules/で動的にルールを読み込む方法](https://zenn.dev/tmasuyama1114/articles/claude_code_dynamic_rules)
- [Claude Code v2.0.64の新機能「.claude/rules/」](https://qiita.com/NaokiIshimura/items/c10436a599df39615eed)
- [Claude があなたのプロジェクトを記憶する方法](https://code.claude.com/docs/ja/memory)
- [Claude Code のスキル拡張](https://code.claude.com/docs/ja/skills)
- [一度読み込まれた rules が消えない挙動の検証](https://zenn.dev/trust_delta/articles/claude-code-rules-scope-bug)
- [CLAUDE.mdの肥大化を防ぐ(Qiita)](https://qiita.com/tomada/items/cb05d3a7aa00cb35c486)
- [なぜあなたのClaude Codeはコンテキストを無視するのか？](https://qiita.com/ktdatascience/items/f3600fc1399e6394b888)
- [Best Practices for Claude Code](https://code.claude.com/docs/en/best-practices)
