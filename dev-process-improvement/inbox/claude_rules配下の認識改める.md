以下の仕様らしいので、現在のreadmeやclaudeに記載されている情報を改める必要がある。
また、.claude/配下の編集を行う場合のガイドラインへ追記しておく。

`.claude/rules` 配下には、「プロジェクト用の細かいルールを分割した Markdown ファイル」を置くのが基本です。[1][2][3]

## 置くべきファイルのイメージ

例えば、以下のようにトピックごと・領域ごとに分割します。[2][3][1]

```text
your-project/
  .claude/
    CLAUDE.md           # 全体方針・基本ルール
    rules/
      code-style.md     # コーディング規約
      testing.md        # テスト方針
      security.md       # セキュリティ方針
      frontend/
        react.md        # フロントエンド固有ルール
        styles.md       # CSS/デザイン指針
      backend/
        api.md          # API設計ルール
        database.md     # DB設計・マイグレーション方針
```

- 各ファイルは Markdown（`.md`）で書く。[1][2]
- 大きな「CLAUDE.md」を役割別の小さなルールファイルに分割するイメージ。[4][2]
- サブディレクトリを掘って、frontend / backend / infra など領域別に整理するのが推奨されている。[3][1]

## YAMLフロントマターでの絞り込み（必要なら）

Claude Rules 対応バージョンでは、ファイルの先頭に YAML フロントマターを書いて「どのパスにだけ効かせるか」を指定できます。[2][4]

```md
---
paths:
  - "src/frontend/**"
  - "src/shared/ui/**"
---

# フロントエンドのコードスタイル

- JSX では…（以下ルール）
```

- `paths` でマッチしたファイルを編集しているときだけ、そのルールが適用される。[4][2]
- 逆に全体に効かせたいルールは `paths` なしで書いておけばよい。[2][4]

## CLAUDE.md との役割分担

- `CLAUDE.md`：プロジェクト全体に共通する方針や大枠のルール。[5][6][1]
- `.claude/rules/*.md`：言語別・レイヤ別・チーム別など、より細かい**局所**ルール。[3][1][2]

まずは以下から始めるのがおすすめです。[5][1][2]

1. プロジェクトルートに `CLAUDE.md`（全体方針）
2. `.claude/rules/code-style.md`（コード規約）
3. `.claude/rules/testing.md`（テスト方針）
4. あとから必要に応じて `frontend/` や `backend/` ディレクトリを追加

どういう種類のプロジェクト（Web、モバイル、バックエンド API など）で使う想定か教えてもらえると、そのプロジェクト向けの具体的な `rules/` 構成例を書きます。

情報源
[1] CLAUDE.mdファイルはどこに置くべき？｜ぽぽっちょ - note https://note.com/popo__cho/n/n48d778f742be
[2] Claude Code v2.0.64の新機能「.claude/rules/」で ... - Qiita https://qiita.com/NaokiIshimura/items/c10436a599df39615eed
[3] 【保存版】Claude Codeの新機能Claude Rulesの使い方と4つの公式 ... https://note.com/masa_wunder/n/n60c2ec107c52
[4] Claude Code入門 #2: CLAUDE.mdの書き方と育て方 - Qiita https://qiita.com/dai_chi/items/8d9d3ac82cbd3c05c883
[5] 【Claude Code】結局CLAUDE.mdはどこに置けばいいの？読み込み ... https://zenn.dev/76hata/articles/6744b16d2241ad
[6] Claude があなたのプロジェクトを記憶する方法 https://code.claude.com/docs/ja/memory
[7] Claude Code メモリ運用の教科書 – 迷わないフォルダ階層と ... - Zenn https://zenn.dev/caphtech/articles/claude-code-memory-guide
[8] 会社全体で Claude Code のルールを整理するにはどうすればよい ... https://www.reddit.com/r/ClaudeAI/comments/1qt8eqi/how_to_organize_claude_code_rules_for_the_whole/
[9] Claude Code の基本的な使い方のまとめ - Zenn https://zenn.dev/to4iki/articles/58a4a64ea97865
[10] Claude Code の settings.json は設定した方がいい - じゃあ https://syu-m-5151.hatenablog.com/entry/2025/06/05/134147
[11] Claudeフォルダ設定ガイド：AIコード生成を最適化する10分 ... https://note.com/genaird/n/nbc1b2d0dd605
[12] うさぎでもわかる  Claude Code .claudeフォルダ設定読み込みの謎 https://note.com/taku_sid/n/ne13246f35bad
[13] 【Claude Code】CLAUDE.mdとフォルダ構成で ... - DevelopersIO https://dev.classmethod.jp/articles/claude-code-directory-autonomy/
[14] CLAUDE.md vs .clau… - SIOS Tech Lab https://tech-lab.sios.jp/archives/51064
[15] Claude Code でローカルLLMを使う完全ガイド — コスト削減 ... - note https://note.com/zephel01/n/nadbdb2194e4b



`.claude/rules` 配下のファイルは「常に全部が読み込まれる」わけではなく、条件次第で動的に読み込まれるので、設計次第でコンテキスト圧迫をかなり抑えられます。[1][2][3]

## ざっくり挙動

- `paths` なしの rules ファイル  
  - セッション開始時に即ロードされ、会話中ずっとコンテキストを消費します。[2][3]
  - 巨大にすると CLAUDE.md と同じように圧迫要因になります。[3]

- `paths` ありの rules ファイル  
  - 対象パターンにマッチするファイルを Claude が読む・編集するタイミングで**そのときだけ**コンテキストに追加されます。[1][2]
  - ロード後はコンテキスト使用量が増えますが、同じルールが何度も重複ロードされないようになっています。[2]

## コンテキスト圧迫を避けるベストプラクティス

- グローバルに効かせたい最小限だけを `paths` なし（または CLAUDE.md）に置く。[3][2]
- 言語別・ディレクトリ別の詳細ルールは、必ず `paths` 付き rules として分割する。[1][2]
- 「特定のタスクでだけ必要な長文ガイド」は rules ではなく Skills にして、呼び出し時だけ読み込ませる。[4][1]

## イメージ例

- `.claude/rules/general.md`（paths なし・短く）：全体で必須の最小限ルールだけ。[2][3]
- `.claude/rules/typescript.md`（`paths: "src/**/*.ts"`）：TypeScript を触る時だけ追加でロード。[5][2]

この運用なら「よく使うコアな指針＋今触っている領域のルール」だけが乗る形になるので、rules をちゃんと分割しておけば、むしろ CLAUDE.md 1 ファイル運用より圧迫は少なくできます。[3][2]

今のプロジェクトでは、rules ファイルはだいたい何個くらい・合計でどれくらいの行数になりそうですか？

情報源
[1] Claude Codeでセッションを超えてコンテキストを受け渡す手法 ... https://zenn.dev/kayato/articles/227b072a84d6b2
[2] CLAUDE.mdの肥大化を防ぐ！.claude/rules/で動的にルールを読み込む方法 https://zenn.dev/tmasuyama1114/articles/claude_code_dynamic_rules
[3] CLAUDE.mdの肥大化を防ぐ！.claude/rules/で動的にルールを ... - Qiita https://qiita.com/tomada/items/cb05d3a7aa00cb35c486
[4] なぜあなたのClaude Codeはコンテキストを無視するのか？ - Qiita https://qiita.com/ktdatascience/items/f3600fc1399e6394b888
[5] Claude Code v2.0.64の新機能「.claude/rules/」で ... - Qiita https://qiita.com/NaokiIshimura/items/c10436a599df39615eed
[6] Claude があなたのプロジェクトを記憶する方法 https://code.claude.com/docs/ja/memory
[7] Claude Codeの真価を引き出す「コンテキストエンジニアリング ... https://note.com/t_miyamoto_60/n/n281188662cde
[8] I Didn't Know These Claude Code Rules (Big Mistake) https://www.youtube.com/watch?v=ynVfOd_ioDg
[9] Claude Code の仕組み - Claude Code Docs https://code.claude.com/docs/ja/how-claude-code-works
[10] Best Practices for Claude Code https://code.claude.com/docs/en/best-practices
[11] 【保存版】Claude Codeの新機能Claude Rulesの使い方と4 ... https://note.com/masa_wunder/n/n60c2ec107c52
[12] 【Claude Code】Agent Team時代の .claude/rules/ 徹底解説 ... - Zenn https://zenn.dev/happy_elements/articles/46b5d3df0fea8f
[13] I give Claude instructions automatically based on how much context ... https://www.reddit.com/r/ClaudeCode/comments/1riucx2/i_give_claude_instructions_automatically_based_on/
[14] Claude Codeのコンテキストウィンドウを完全に理解する - gihyo.jp https://gihyo.jp/article/2025/12/get-started-claude-code-05
[15] Mastering Claude Code: 6 Rules for Effective Context ... https://www.linkedin.com/posts/sumitpathak91_softwareengineering-claudecode-ai-activity-7430185817299636224-WCt9
