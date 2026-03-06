以下の内容について現在の状況を再確認して、最適化の余地を評価する
また、重要な知見なので、クロード管理のガイドラインの目につく箇所へ追記しておきたい。
readmeなどにも追記しておきたい。両方のディレクトリの。

このリポジトリ、かなりちゃんと整備されてますね。`.claude/rules/` の使い方として**とても良い構成例**です。

## 良いポイント

- **`claude-directory-guide.md`**（25KB）があって、プロジェクト全体の `.claude` 構成をドキュメント化している。
- トピックごとに小さく分割している（`code-in-docs.md`、`commit-message.md`、`design-doc.md`、`parallel-dev.md` など）。
- `openspec-development.md`（7KB）、`role-format-guide.md`（6KB）のような、やや大きめのドメイン固有ルールも rules で管理している。

## コンテキスト圧迫について

`claude-directory-guide.md` が約25KB（推定約800行弱）とかなり大きいので、これはコンテキストに常時乗る可能性が高いです。

ドキュメント内でも「CLAUDE.md + rules は約500行以内が推奨」「参照資料は skills に移動してオンデマンド読み込み」と書いてある通り、 `claude-directory-guide.md` のような長文ガイドは **skills として切り出して、必要なときだけ `/` コマンドで呼び出す形にするほうが効率的**です。

### 改善案

```diff
.claude/
├── rules/
-   ├── claude-directory-guide.md    # 常時読み込み（重い）
│   ├── code-in-docs.md
│   ├── commit-message.md
│   ├── design-doc.md
│   └── ...
+└── skills/
+    └── directory-guide/
+        └── SKILL.md                 # /directory-guide で呼び出し専用
```

こうすると：
- `claude-directory-guide` は YAML フロントマターで `disable-model-invocation: true` にする。
- セッション開始時は説明（description）だけが読み込まれる。
- 「ディレクトリ構成どうだっけ？」となったときだけ `/directory-guide` で全文を取り寄せる。

他の小さいルール（`commit-message.md` や `code-in-docs.md`）はそのまま rules に置いて、常時効かせる運用で問題ないと思います。


非常に良い質問です。ここは**挙動が複雑**で、実際に混乱しやすいポイントです。 [zenn](https://zenn.dev/tmasuyama1114/articles/claude_code_dynamic_rules)

## 結論

`.claude/rules/` 配下のファイルは**すべて自動読み込み対象**ですが、`paths` フロントマターの有無で**読み込みタイミング**が変わります。 [qiita](https://qiita.com/NaokiIshimura/items/c10436a599df39615eed)

| 状況 | 読み込みタイミング | コンテキスト常駐 |
|------|------------------|-----------------|
| `paths` **なし** | セッション開始時に全文読み込み | ✅ **常時** |
| `paths` **あり** | マッチするファイルにアクセスしたとき | 一度読まれたら常駐（❗重要） |

## つまり

- `paths` なしの rules は CLAUDE.md と同じで、起動時に即ロードされて**毎リクエスト常駐**します。 [code.claude](https://code.claude.com/docs/ja/memory)
- `paths` ありの rules は、対象パスのファイルを触るまで**読み込まれない**（遅延読み込み）。 [note](https://note.com/ai_driven/n/n1160202e5e42)
- **ただし、一度読み込まれたらそのセッション中はずっとコンテキストに残る**という挙動が報告されています。 [zenn](https://zenn.dev/trust_delta/articles/claude-code-rules-scope-bug)

## 実際の挙動（注意点）

公式ドキュメントには「マッチするファイルで作業するときだけ適用」と書いてありますが、 実際には**一度読み込まれたルールは、その後マッチしないファイルに移動してもコンテキストから消えない**という挙動が検証されています。 [note](https://note.com/ai_driven/n/n1160202e5e42)

例：
1. `src/api/user.ts` を編集 → `paths: "src/api/**/*.ts"` のルールが読み込まれる
2. その後 `README.md` を編集 → API ルールはコンテキストに**残ったまま**

## あなたのリポジトリの場合

`claude-directory-guide.md` に `paths` を付けても、`.claude/` 配下のファイルを一度でも触ったらそのセッション中ずっとコンテキストに乗り続けるので、**コンテキスト圧迫の根本解決にはなりません**。 [zenn](https://zenn.dev/trust_delta/articles/claude-code-rules-scope-bug)

やはり**skills 化して `disable-model-invocation: true`** にするのが確実です。 これなら：
- セッション開始時は description（1行）だけがロードされる
- `/directory-guide` と明示的に呼ばない限り全文は読み込まれない
- 呼んだ後もサブコンテキスト（`context: fork`）で処理すればメインコンテキストを汚染しない

`paths` は「本当にそのパス専用の短いルール」（例：`src/api/**/*.ts` 向けに10行程度の API 規約）に使うのがベストで、大きなドキュメントの読み込み制御には向いていません。 [zenn](https://zenn.dev/tmasuyama1114/articles/claude_code_dynamic_rules)

