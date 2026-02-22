<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# この記事について、claudeの活用方法を参考にしたい。特に、並列での役割の与え方、並列での進捗管理の仕方などを取り入れたい。

https://www.anthropic.com/engineering/building-c-compiler

この記事のやり方を、日本語で「Claude活用の設計指針」として抽象化すると次のようになります。

## 全体像：何を真似するとよいか

取り入れると効果が大きいのは主に次の4点です。

- 無限ループ＋タスクキューで「止まらない」エージェントにすること
- テキストファイルベースのロックで、並列エージェントの競合を避けること
- 高品質テストとログ設計で「自律的に進捗判断」できる環境をつくること
- 役割を分けた専門エージェントを並列に走らせること

以下、それぞれを「役割の与え方」「進捗管理の仕組み」に分けて、あなたのプロジェクトに転用できる形でまとめます。

***

## 並列エージェントの役割設計

記事では、16体のClaudeを同じリポジトリ上で並列実行しつつ、役割を分けています。

### 1. ベースとなる「開発エージェント」

- 目的: 実際にコードを書く・バグを直す・新機能を実装するエージェント。
- 指示例（イメージ）:
    - 失敗しているテストを1つロックして担当する
    - そのテストが通るように最小限の変更を行う
    - テスト実行 → 成功したらコミット・プッシュ → ロック解除


### 2. 専門ロールの「サブエージェント」

記事で挙げられている専門ロールは次のようなものです。

- 重複コードの統合担当（リファクタリング・DRY化）
- コンパイラ自体の高速化担当（パフォーマンス改善）
- 生成コードの品質担当（出力コードの効率化）
- Rustエキスパート視点で設計レビューする担当（設計改善・モジュール分割）
- ドキュメント担当（READMEや進捗メモの整備）

あなたのプロジェクトでも同じ考え方で、例えば:

- 機能実装担当（タスクごとのチケットを消化）
- バグ修正担当（Failing test/Issue専用）
- リファクタリング担当（コード品質・一貫性）
- テスト整備担当（テスト追加・CI強化）
- ドキュメント担当（仕様書・変更履歴）

といったロールを、常に1〜数体ずつ走らせておく構成が取りやすいです。

***

## 並列タスクの割り当て・ロックの仕組み

記事のキモは「テキストファイルでタスクロックを管理する」という非常にシンプルな方式です。

### 1. タスクロックのやり方

記事でやっていること:

- 共有リポジトリに `current_tasks/` ディレクトリを用意
- 各エージェントは、着手したいタスク名でロックファイルを作成
    - 例: `current_tasks/parse_if_statement.txt`
- プッシュ時に、もし同名ロックファイルの競合が起きたら、後から来たエージェントが別タスクに切り替える
- 作業完了後は、最新をpull→マージ→pushし、ロックファイルを削除

これにより、

- 一つのタスクを同時に二つのエージェントが触らない
- 失敗しても、ロックファイルを見れば「今誰が何をやっているか」がわかる


### 2. あなたの環境での応用案

例えばGitHubリポジトリ前提なら:

- `tasks/` に「タスク候補」のリスト（YAML/Markdown）
- `locks/` に「担当中タスク」のロックファイル
    - ファイル名にタスクID、内容に担当エージェント名（またはUUID・コンテナ名）＋開始時刻
- 各Claudeインスタンスは:

1. `tasks/` から未ロックのタスクを1つ選ぶ
2. `locks/` に自分用のロックファイルを書いてコミット・プッシュ
3. 成功したタスクについてテストを実行
4. 成功したら、タスクの状態を`done`に更新しロック削除

ロールごとに「見るタスク一覧」を分けると、役割分担が自然に生まれます。

- 機能実装: `tasks/features/*.md` だけを見る
- バグ修正: `tasks/bugs/*.md` だけを見る
- ドキュメント: `tasks/docs/*.md` だけを見る

***

## 進捗管理の方法（テスト＆ログ）

この仕組みが機能する前提として、「Claude自身が進捗と正しさを判断できるテスト・ログが必須」と記事は強調しています。

### 1. 高品質テストを「単一の真実源」にする

記事でのポイント:

- テストが不完全だと、Claudeは「間違った問題」を一生懸命解く
- 途中から、既存機能を壊しやすくなったので、CIを導入して「既存テストが全部通らないとマージ不可」にした

転用のコツ:

- 「人間のレビュー」は、原則サブ的な安全弁にし、日常の判断はテストに任せる
- 失敗パターンを見つけたら、それを再現するテストを必ず1つ追加する
- 並列エージェントのCIでは:
    - `--fast`オプションのような部分テスト（記事では1%〜10%ランダムサンプル）を用意して高速チェックを回す
    - 全テストは定期バッチ or マージ前限定、など段階を分ける


### 2. Claude向けに「読みやすいログ」を設計する

記事で挙げている工夫:

- 出力をダラダラ流さず、重要情報はログファイルにまとめる
- 自動処理しやすいフォーマットにする（例: `ERROR <理由>` を1行で書く、集計結果を先に出しておく）
- 文脈ウィンドウを汚さないよう、コンソール出力は短く、詳細はファイルに逃がす

Claudeを使うときも、例えば:

- `logs/agentA/` 下に
    - `progress.md`（今日やったこと・次やること）
    - `errors.log`（1行1エラー、grepしやすい形式）
- 各ラウンドで「まずprogress.mdを読み、最後に更新する」という指示をプロンプトに含める

といった形にすると、あなたもClaudeも進捗を追いやすくなります。

***

## 「大きな1タスク」を並列化する工夫

Linuxカーネルのような巨大な「1つのタスク」は、そのままだと全エージェントが同じバグにぶつかって並列化できない、という問題が出ます。

記事での解決策:

- GCCを「正しさのオラクル」として利用し、
    - 多くのファイルはGCCでコンパイル
    - 残りの一部をClaudeコンパイラでコンパイル
- 壊れたら、その範囲をさらに絞り込む
- こうして「どのファイルでバグるか」を分解し、各エージェントが別ファイルを担当できるようにした

あなたのケースに一般化すると:

- 「モノリシックな1タスク」を、テストやオラクルを使って「問題のある部分集合」に切り分ける
- その部分集合を、ファイル単位・機能単位のタスクに分けて、ロック＋タスクキューで配分する

例:

- 大規模リファクタリングなら、「モジュールAのAPI整備」「モジュールBの型整理」などに切り出す
- その前段として、「影響範囲検出スクリプト」や「構造チェック用テスト」を整備しておく

***

## 実装するときのミニマム構成例

最後に、この記事を参考にしつつ、あなたがClaudeを並列活用する際の最小構成案をまとめます。

1. 共有Gitリポジトリを用意
2. `tasks/`, `locks/`, `logs/` ディレクトリを作る
3. テストと簡易CI（最低限、`pytest`や`cargo test`のようなコマンド）が通る状態にする
4. 各Claude用の「エージェントプロンプト」を1つ定義
    - プロジェクトの目的
    - 自分のロール（実装/バグ修正/ドキュメントなど）
    - タスクロックのプロトコル
    - テストとログ更新の手順
5. シェルスクリプトで、ロールごとに無限ループでClaudeを起動
    - 例: 「実装担当」を2体、「バグ修正」を1体、「ドキュメント」を1体など

こうすると、あなたは「タスクの棚卸しとテスト設計」に集中しつつ、実装や改善は並列のClaudeチームが自律的に進めてくれる形に近づきます。

もし、あなたの具体的なプロジェクト（例: Webサービス開発、社内ツール、研究コードなど）がわかれば、その前提で「役割の割り方」「ディレクトリ構成」「プロンプト雛形」まで落とし込んで提案できます。

---

# では必要な役割を一覧にして、まずはディレクトリ構成まとめて。

プロジェクトの種類によって最適な構成は変わりますが、記事の手法を汎用化した「並列Claudeチーム運用」のためのディレクトリ構成と役割一覧を提案します。

***

## 役割一覧

記事の実践から抽出した、汎用的に使える7つのロールです。すべてを常時稼働させる必要はなく、プロジェクトフェーズに応じて2〜4体から始めるのが現実的です。


| \# | ロール名 | 責務 | 見るタスクディレクトリ | 常駐 or 随時 |
| :-- | :-- | :-- | :-- | :-- |
| 1 | **Feature Builder** | 新機能の実装。タスクを1つロックし、テストが通るまで実装→コミット | `tasks/features/` | 常駐（1〜N体） |
| 2 | **Bug Fixer** | 失敗テスト・既知バグの修正。最小差分で直す | `tasks/bugs/` | 常駐（1体〜） |
| 3 | **Refactorer** | 重複コード統合、設計改善、DRY化。既存テストを壊さないことが絶対条件 | `tasks/refactor/` | 随時 |
| 4 | **Test Writer** | テストカバレッジの拡充、エッジケース追加、テストの品質改善 | `tasks/tests/` | 随時 |
| 5 | **Reviewer** | 直近のコミットを読み、設計問題・バグリスクを `tasks/bugs/` や `tasks/refactor/` に起票 | `logs/` + git log | 随時 |
| 6 | **Optimizer** | パフォーマンス改善、ビルド高速化、出力品質の向上 | `tasks/optimize/` | 随時 |
| 7 | **Documentarian** | README、CHANGELOG、設計ドキュメント、進捗サマリーの整備 | `tasks/docs/` | 随時 |


***

## ディレクトリ構成

```
project-root/
│
├── .claude/                        # Claude エージェント設定
│   ├── base_prompt.md              # 全エージェント共通の基本指示
│   ├── roles/                      # ロール別プロンプト
│   │   ├── feature_builder.md
│   │   ├── bug_fixer.md
│   │   ├── refactorer.md
│   │   ├── test_writer.md
│   │   ├── reviewer.md
│   │   ├── optimizer.md
│   │   └── documentarian.md
│   └── protocols/                  # 共通プロトコル定義
│       ├── lock_protocol.md        # タスクロックの取得・解放手順
│       ├── commit_protocol.md      # コミットメッセージ規約、push手順
│       └── test_protocol.md        # テスト実行・判定ルール
│
├── tasks/                          # タスクキュー（全タスクの定義）
│   ├── features/                   # 機能実装タスク
│   │   ├── 001_user_auth.md
│   │   ├── 002_api_endpoint.md
│   │   └── ...
│   ├── bugs/                       # バグ修正タスク
│   │   ├── 001_null_crash.md
│   │   └── ...
│   ├── refactor/                   # リファクタリングタスク
│   ├── tests/                      # テスト追加タスク
│   ├── optimize/                   # 最適化タスク
│   └── docs/                       # ドキュメントタスク
│
├── locks/                          # タスクロック（排他制御）
│   └── features__001_user_auth.lock
│   #   ファイル内容例:
│   #   agent: feature-builder-A
│   #   started: 2026-02-11T09:30:00+09:00
│   #   task: tasks/features/001_user_auth.md
│
├── logs/                           # エージェント活動ログ
│   ├── feature-builder-A/
│   │   ├── progress.md             # 完了タスク・次タスクの記録
│   │   └── errors.log              # 1行1エラー、grep可能
│   ├── bug-fixer-A/
│   │   └── ...
│   └── _summary.md                 # Documentarianが更新する全体進捗
│
├── done/                           # 完了タスクのアーカイブ
│   ├── features/
│   ├── bugs/
│   └── ...
│
├── src/                            # プロジェクト本体のソースコード
├── tests/                          # テストコード
├── ci/                             # CI/テスト関連スクリプト
│   ├── run_fast.sh                 # 高速チェック（ランダムサンプル or smoke test）
│   └── run_full.sh                 # フルテスト（マージ前に実行）
│
└── scripts/                        # エージェント起動・管理スクリプト
    ├── launch_agent.sh             # 1体のエージェントを無限ループで起動
    ├── launch_team.sh              # チーム一括起動（ロール×台数を定義）
    └── status.sh                   # locks/ と logs/ から現在の稼働状況を表示
```


***

## 各ディレクトリの設計意図

### `tasks/` — タスクキュー

各タスクは1つのMarkdownファイルで、以下を含みます：

```markdown
# タスク: ユーザー認証の実装

## ステータス: open
## 優先度: high

## 概要
JWT ベースのユーザー認証エンドポイントを実装する

## 完了条件
- [ ] POST /auth/login が正しいトークンを返す
- [ ] tests/test_auth.py の全テストが通る
- [ ] 既存テストが壊れていない

## 参考
- 設計ドキュメント: docs/auth_design.md
```

ステータスは `open` → `in_progress` → `done` で遷移し、`done` になったら `done/` へ移動します。

### `locks/` — 排他制御

- ファイル名でどのタスクかわかる（`{カテゴリ}__{タスクID}.lock`）
- 中身にエージェント名と開始時刻を書く
- push時にコンフリクトが出たら、**後から来たエージェントが引き下がって別タスクを探す**
- 長時間ロックされたままのタスクは `status.sh` で検出 → 人間が介入


### `logs/` — 自律的な進捗管理

- 各エージェントが自分の `progress.md` を毎ラウンド更新
- **Documentarian** が定期的に全エージェントの `progress.md` を読み、`_summary.md` に統合
- 人間はこの `_summary.md` を見るだけで全体の進捗がわかる


### `.claude/protocols/` — エージェント間の「共通言語」

記事の最大の教訓は、**エージェントに「何をするか」だけでなく「どうやるか」のプロトコルを明示する**ことです。特に重要な3つ：

- **lock_protocol.md**: ロックの取り方・解放の仕方・コンフリクト時の振る舞い
- **commit_protocol.md**: コミットメッセージのフォーマット、push前のpull手順、コンフリクト解消方法
- **test_protocol.md**: 変更後にどのテストを走らせるか、失敗時の判断基準

***

## 起動の最小構成（例）

まずは3体から始める場合：


| エージェント | ロール | 起動コマンド（イメージ） |
| :-- | :-- | :-- |
| Agent-A | Feature Builder | `./scripts/launch_agent.sh feature_builder A` |
| Agent-B | Feature Builder | `./scripts/launch_agent.sh feature_builder B` |
| Agent-C | Bug Fixer | `./scripts/launch_agent.sh bug_fixer A` |

安定してきたら Reviewer や Documentarian を追加し、テストやドキュメントの品質を底上げしていく流れです。

***

次のステップとして、**各ロールのプロンプト雛形**（`base_prompt.md` やロール別プロンプト）、あるいは **`launch_agent.sh` のスクリプト例** を作成できます。どちらから進めますか？

---

# 各ロールのプロンプト雛形作成

記事の手法をベースに、全11ファイル分のプロンプト雛形をまとめました。以下にそれぞれの設計意図を解説します。

***

## 全体構成

| ファイル | 内容 | 役割 |
| :-- | :-- | :-- |
| `base_prompt.md` | 全エージェント共通の基本指示 | プロジェクト情報、基本ループ、コミット規約、禁止事項 |
| `roles/feature_builder.md` | 機能実装担当 | タスク選定→実装→テスト→コミットの手順 |
| `roles/bug_fixer.md` | バグ修正担当 | 再現テスト→最小差分修正→回帰テストの手順 |
| `roles/refactorer.md` | リファクタリング担当 | 振る舞いを変えずにコード品質を改善 |
| `roles/test_writer.md` | テスト整備担当 | カバレッジ拡充、エッジケース発見 |
| `roles/reviewer.md` | レビュー担当 | コミット監視→問題発見→タスク起票（自分では直さない） |
| `roles/optimizer.md` | 最適化担当 | 計測→ボトルネック特定→改善→計測 |
| `roles/documentarian.md` | ドキュメント担当 | 全体進捗サマリー、README、CHANGELOG の維持 |
| `protocols/lock_protocol.md` | ロック手順 | タスク排他制御のルール |
| `protocols/commit_protocol.md` | コミット手順 | push前の手順、コンフリクト解消ルール |
| `protocols/test_protocol.md` | テスト手順 | 2段階テスト、失敗時の対応フロー |


***

## 設計上のポイント

### base_prompt が「憲法」、role prompt が「職務記述書」

記事では各Claudeに「何をするか」と「どうやるか」を明示することが成功の鍵でした。この構造を反映し：

- **base_prompt.md** は全エージェントが読む共通ルール（ループの回し方、コミット規約、禁止事項）
- **roles/*.md** はロールごとの判断基準と行動指針
- **protocols/*.md** はロール横断の「やり方」の定義

実際の起動時は `cat base_prompt.md roles/feature_builder.md protocols/*.md` のように結合してClaudeに渡します。

### 「やらないこと」を明記する

記事の並列Claudeでは、あるエージェントが「ついでにリファクタリング」して別エージェントとコンフリクトする問題が頻発していました。各ロールのプロンプトに**「やらないこと」セクション**を設けることで、ロール間の境界を明確にし、コンフリクトを減らします。

### Reviewer は「コードを直さない」

Reviewerが直接修正すると、Feature BuilderやBug Fixerと同じファイルを触って衝突します。Reviewerの仕事は「問題を発見してタスクとして起票する」ことに限定し、実際の修正は担当ロールに委ねます。これにより安全な分業が成立します。

### Documentarian が「情報ハブ」になる

記事で強調されていた「READMEやprogressファイルを頻繁に更新する」手法を、Documentarianロールの常時タスクとして組み込んでいます。全エージェントのログを集約して `logs/_summary.md` に書くことで、人間もエージェントも「今プロジェクト全体がどうなっているか」を1ファイルで把握できます。

### テストプロトコルの2段階設計

記事では `--fast` オプションで1〜10%のランダムサンプルを回す高速チェックと、フルテストを使い分けていました。これを `ci/run_fast.sh`（30秒以内）と `ci/run_full.sh`（5分以内）の2段階に形式化しています。高速チェックを毎コミット前に、フルテストをpush前に実行するルールです。

***

## 使い方の例

```bash
# エージェント起動時にプロンプトを結合して渡す
PROMPT=$(cat .claude/base_prompt.md .claude/roles/feature_builder.md .claude/protocols/*.md)

claude --dangerously-skip-permissions \
  -p "$PROMPT" \
  --model claude-opus-4-0-20250514
```

これを `scripts/launch_agent.sh` でラップし、記事と同じ無限ループで回します。

***

次のステップとして、**`launch_agent.sh` / `launch_team.sh` の実装**や、**特定プロジェクト向けにプロンプトをカスタマイズ**することもできます。何か具体的なプロジェクトがあれば、それに合わせて調整します。

---

# 無限ループはいらない。モデルはソネットで。起動用のシェル整理して。

4つのシェルスクリプトを整理しました。無限ループは使わず、**1回の起動 = 1回のタスク実行**で完結する設計です。

***

## スクリプト一覧

| スクリプト | 役割 |
| :-- | :-- |
| `init_project.sh` | ディレクトリ構成・CI雛形・タスクテンプレートを一括生成 |
| `launch_agent.sh` | 単一エージェントを1回起動 |
| `launch_team.sh` | チーム（複数エージェント）を並列で一括起動 |
| `status.sh` | locks / logs / tasks を読んで現在の稼働状況を表示 |


***

## 1. `init_project.sh` — 初期セットアップ

最初に一度だけ実行します。前回定義したディレクトリ構成（`.claude/`, `tasks/`, `locks/`, `logs/`, `done/`, `ci/`）を一括作成し、CIスクリプトの雛形とタスクテンプレートを配置します。既存ファイルは上書きしません。

```bash
chmod +x scripts/init_project.sh
./scripts/init_project.sh
```


***

## 2. `launch_agent.sh` — 単体起動

核となるスクリプトです。設計のポイント：

- **プロンプト自動結合**: `base_prompt.md` + `roles/{role}.md` + `protocols/*.md` を結合し、`--append-system-prompt-file` でClaudeの標準機能を保ったまま追加指示として渡します[^4_1][^4_2]
- **モデル固定**: `--model sonnet`（現在のSonnet 4.5）[^4_3]
- **セッション情報の注入**: agent_id、role、開始時刻をプロンプト末尾に自動付与。Claudeが「自分は誰か」を認識できる
- **タスク指定可能**: 第3引数でタスクファイルを直接指定可能。省略時はエージェントが自分で `tasks/` から選ぶ
- **ログ保存**: 全出力を `logs/{role}-{id}/session_YYYYMMDD_HHMMSS.log` に記録

```bash
# 基本: ロールとIDを指定して起動
./scripts/launch_agent.sh feature_builder A

# タスク指定: 特定タスクをやらせる
./scripts/launch_agent.sh bug_fixer A tasks/bugs/001_null_crash.md
```


***

## 3. `launch_team.sh` — チーム一括起動

`TEAM` 配列でチーム構成を定義し、全エージェントをバックグラウンドで並列起動します。

```bash
TEAM=(
  "feature_builder:A"
  "feature_builder:B"
  "bug_fixer:A"
  # "refactorer:A"       ← コメント解除で追加
  # "reviewer:A"
  # "documentarian:A"
)
```

- **`--dry-run`**: 実際には起動せず、実行されるコマンドだけ確認
- **起動間隔 2秒**: git push の競合を減らすためスタッガード起動
- **PID表示**: 起動後に全PIDを表示。`kill` で一括停止可能

```bash
# 確認
./scripts/launch_team.sh --dry-run

# 実行
./scripts/launch_team.sh
```


***

## 4. `status.sh` — 稼働状況の確認

人間が「今どうなっているか」をさっと確認するためのスクリプトです。

```
=== プロジェクト稼働状況 ===
  時刻: 2026-02-11 10:05:00

■ タスク状況
  features      未着手:   5  完了:   3
  bugs          未着手:   2  完了:   7
  refactor      未着手:   1  完了:   0
  ...

■ ロック中のタスク
  🔒 features__002_api_endpoint
     担当: feature-builder-A  開始: 2026-02-11T10:01:00+09:00

■ エージェントログ
  feature-builder-A: feat-002 実装中、認証ミドルウェア追加完了
  bug-fixer-A: (ログなし)
```


***

## 使い方の流れ

```
1.  ./scripts/init_project.sh          # 構成を初期化
2.  .claude/ のプロンプトをプロジェクトに合わせて編集
3.  ci/run_fast.sh, ci/run_full.sh を実装
4.  tasks/ にタスクを追加
5.  ./scripts/launch_team.sh --dry-run  # コマンド確認
6.  ./scripts/launch_team.sh            # チーム起動
7.  ./scripts/status.sh                 # 進捗確認
```

追加で起動したい場合は `launch_agent.sh` で個別に追加、チーム構成を変えたい場合は `launch_team.sh` の `TEAM` 配列を編集するだけです。
<span style="display:none">[^4_10][^4_11][^4_12][^4_13][^4_14][^4_15][^4_4][^4_5][^4_6][^4_7][^4_8][^4_9]</span>

<div align="center">⁂</div>

[^4_1]: https://code.claude.com/docs/en/cli-reference

[^4_2]: https://github.com/anthropics/claude-code/issues/19977

[^4_3]: https://code.claude.com/docs/en/model-config

[^4_4]: https://code.claude.com/docs/en/headless

[^4_5]: https://claudelog.com/faqs/what-is-dangerously-skip-permissions/

[^4_6]: https://aws.amazon.com/about-aws/whats-new/2025/06/amazon-q-developer-cli-claude-sonnet-4/

[^4_7]: https://www.claudelog.com/faqs/what-is-system-prompt-file-flag-in-claude-code/

[^4_8]: https://www.ksred.com/claude-code-dangerously-skip-permissions-when-to-use-it-and-when-you-absolutely-shouldnt/

[^4_9]: https://support.claude.com/en/articles/11940350-claude-code-model-configuration

[^4_10]: https://www.youtube.com/watch?v=4jmB_efkiRs

[^4_11]: https://note.com/ai__worker/n/n2c30ee488677

[^4_12]: https://www.reddit.com/r/ClaudeCode/comments/1o65jva/understanding_claude_codes_3_system_prompt/

[^4_13]: https://www.reddit.com/r/ClaudeAI/comments/1l45dcr/how_to_stop_claude_code_from_asking_for/

[^4_14]: https://qiita.com/makies/items/50abbd191705f2577314

[^4_15]: https://www.reddit.com/r/ClaudeAI/comments/1oj96xc/do_you_use_dangerouslyskippermissions_how_do_you/


---

# 複数起動した場合のターミナルはどう見える？

複数エージェントを同時に走らせたとき、ターミナルがどう見えるかは**起動方式によって3パターン**あります。

---

## 方式A: `launch_team.sh`（バックグラウンド並列）

先ほど作ったスクリプトの方式です。各エージェントをバックグラウンド（`&`）で起動するため、ターミナルに見えるのは**起動ログだけ**です。

```
=== Team Launch ===
  Agents: 3
=== Agent [feature-builder-A] 起動 ===
=== Agent [feature-builder-B] 起動 ===
=== Agent [bug-fixer-A] 起動 ===

全エージェント起動完了
  PIDs: 12345 12346 12347
  停止: kill 12345 12346 12347
```

各エージェントの出力はログファイル（`logs/feature-builder-A/session_*.log`）に流れるため、**ターミナル自体は静か**です。進捗を見たいときは：

- `./scripts/status.sh` でロック状況・進捗を一覧表示
- `tail -f logs/feature-builder-A/session_*.log` で特定エージェントの動きをリアルタイム監視

**メリット**: セットアップ不要、ヘッドレスなので軽い
**デメリット**: リアルタイムの視認性が低い

***

## 方式B: tmux split-pane（各エージェントが独立ペイン）

tmuxで画面を分割し、各ペインでエージェントを1体ずつ起動する方式です。多くの開発者がこの構成を使っています。[^5_1][^5_2][^5_3]

```
┌──────────────────┬──────────────────┬──────────────────┐
│ feature-builder-A│ feature-builder-B│ bug-fixer-A      │
│                  │                  │                  │
│ ● tasks/features │ ● tasks/features │ ● tasks/bugs/    │
│   /001 をロック中 │   /002 をロック中 │   001 を修正中   │
│                  │                  │                  │
│ > src/auth.py を │ > テスト実行中... │ > 再現テスト作成  │
│   編集中...      │   23/23 passed   │   中...          │
│                  │                  │                  │
└──────────────────┴──────────────────┴──────────────────┘
```

セットアップ例：

```bash
# tmuxセッション作成 + 3ペインに分割
tmux new-session -d -s agents
tmux split-window -h -t agents
tmux split-window -v -t agents

# 各ペインでエージェント起動
tmux send-keys -t agents:0.0 './scripts/launch_agent.sh feature_builder A' Enter
tmux send-keys -t agents:0.1 './scripts/launch_agent.sh feature_builder B' Enter
tmux send-keys -t agents:0.2 './scripts/launch_agent.sh bug_fixer A' Enter

# アタッチして見る
tmux attach -t agents
```

**メリット**: 全エージェントの動きをリアルタイムで同時に見える、個別に介入できる
**デメリット**: tmuxの操作知識が必要、ペインが多すぎると見づらい

***

## 方式C: Agent Teams（Claude Code公式機能）

Claude Code には公式の **Agent Teams** 機能（実験的）があり、Claudeに「チームを作って」と言うだけで並列エージェントを自動管理してくれます。[^5_4]

### 有効化

```json
// settings.json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```


### 表示モード：In-process

```
┌─────────────────────────────────────────────────────┐
│ Lead (あなたとの対話)                                 │
│                                                     │
│ 「PR #142 をレビューして。3人のチームで並列に。」      │
│                                                     │
│ Teammates:                                          │
│  🟢 security-reviewer  — src/auth/ を調査中          │
│  🟢 perf-reviewer      — クエリパフォーマンス分析中   │
│  🟡 test-reviewer      — アイドル（完了）             │
│                                                     │
│ [Shift+↑↓ でチームメイト選択、Enter で詳細表示]       │
└─────────────────────────────────────────────────────┘
```

- `Shift+↑↓` でチームメイトを選択、直接メッセージを送れる[^5_4]
- `Ctrl+T` でタスクリストを表示[^5_4]
- `Shift+Tab` でデリゲートモード（リードがコードを触らず指揮に専念）[^5_4]


### 表示モード：Split panes（tmux必須）

tmux と連携し、各チームメイトが自動的に別ペインに展開されます。設定：

```json
{ "teammateMode": "tmux" }
```

**メリット**: チームメイト間で直接メッセージをやり取りできる、タスクの依存関係を自動管理、プロンプト設計が最小限で済む[^5_4]
**デメリット**: 実験的機能、トークン消費が大きい、セッション復帰に制限あり[^5_4]

***

## どれを選ぶか

| 観点 | 方式A: バックグラウンド | 方式B: tmux手動 | 方式C: Agent Teams |
| :-- | :-- | :-- | :-- |
| セットアップ | 不要 | tmux | 環境変数1つ |
| 視認性 | ログファイル経由 | 全ペイン同時に見える | in-process or split |
| 介入しやすさ | 低（ログ読んで再起動） | 高（ペインに直接入力） | 高（メッセージ送信） |
| エージェント間通信 | なし（Git経由のみ） | なし（Git経由のみ） | あり（メールボックス） |
| タスク管理 | 自作（locks/） | 自作（locks/） | 公式タスクリスト |
| トークン効率 | 良い（`-p`で最小限） | 普通 | 高コスト |
| 安定性 | 高 | 高 | 実験的 |

**おすすめの使い分け**：

- **方式A** → 夜間バッチ的に回す、大量タスクを自動消化させたい場合
- **方式B** → 開発中にリアルタイムで監視しながら進めたい場合
- **方式C** → エージェント同士が議論・協調する必要がある場合（レビュー、デバッグ仮説検証など）

先ほど作ったプロンプト・ディレクトリ構成は**方式A・Bのどちらでもそのまま使えます**。方式Cを使う場合は、`locks/` による排他制御の代わりにAgent Teamsの公式タスクリストが使えるため、プロトコルを簡略化できます。
<span style="display:none">[^5_10][^5_11][^5_12][^5_13][^5_14][^5_15][^5_5][^5_6][^5_7][^5_8][^5_9]</span>

<div align="center">⁂</div>

[^5_1]: https://willness.dev/blog/run-multiple-claude-code-sessions

[^5_2]: https://www.reddit.com/r/ClaudeCode/comments/1p5bbui/whats_your_best_setup_to_run_multiple_claude/

[^5_3]: https://zenn.dev/kazuph/articles/beb87d102bd4f5

[^5_4]: https://code.claude.com/docs/en/agent-teams

[^5_5]: https://www.reddit.com/r/ClaudeAI/comments/1kkqj9z/claude_code_multiagents/

[^5_6]: https://www.reddit.com/r/ClaudeCode/comments/1qa6pzm/how_to_run_multiple_claude_code_sessions_at_once/nz14uve/

[^5_7]: https://www.reddit.com/r/ClaudeAI/comments/1l4jocr/psa_claude_code_can_parallelize_agents/

[^5_8]: https://www.reddit.com/r/ClaudeCode/comments/1p24u40/run_2_or_even_more_instances_of_claude_code_in/

[^5_9]: https://www.reddit.com/r/ClaudeAI/comments/1q2zl06/running_multiple_ai_coding_agents_in_parallel/

[^5_10]: https://www.reddit.com/r/ClaudeAI/comments/1l80jd4/i_built_ccmanager_a_tmuxfree_way_to_manage/

[^5_11]: https://www.reddit.com/r/ClaudeCode/comments/1nfx61v/best_interface_to_run_multiple_claude_code/

[^5_12]: https://code.claude.com/docs/en/best-practices

[^5_13]: https://www.reddit.com/r/ClaudeAI/comments/1qf9xms/how_do_you_manage_multiple_claude_code_cli/

[^5_14]: https://code.claude.com/docs/en/headless

[^5_15]: https://zenn.dev/aun_phonogram/articles/5bbc0c5ca40df5


---

# 方式Bを採用したい。

`launch_team.sh` を tmux 方式に書き換えました。

***

## 主な変更点

| 項目 | 旧（バックグラウンド） | 新（tmux） |
| :-- | :-- | :-- |
| 表示 | ログファイルに流れる | 各ペインにリアルタイム表示 |
| 監視 | `tail -f` で個別確認 | 画面を見るだけ |
| 介入 | 不可（再起動が必要） | ペインに移動して直接操作 |
| 停止 | `kill PID` | `--kill` or `Ctrl+B → D` で切断 |


***

## 自動レイアウト

エージェント数に応じてペイン配置を自動で切り替えます。

```
3体（デフォルト）:
┌─────────┬─────────┐
│         │ feat-B  │
│ feat-A  ├─────────┤
│         │ bug-A   │
└─────────┴─────────┘

4体:
┌─────────┬─────────┐
│ feat-A  │ feat-B  │
├─────────┼─────────┤
│ bug-A   │ refact  │
└─────────┴─────────┘

6体:
┌───────┬───────┬───────┐
│feat-A │feat-B │bug-A  │
├───────┼───────┼───────┤
│refact │test   │review │
└───────┴───────┴───────┘
```

各ペインの上部にはロール名がボーダーに表示されるので、どのペインがどのエージェントかひと目でわかります。

***

## 操作方法

```bash
# 起動（自動でアタッチされる）
./scripts/launch_team.sh

# コマンド確認だけ
./scripts/launch_team.sh --dry-run

# 停止
./scripts/launch_team.sh --kill
```

tmux 内での操作：


| 操作 | キー |
| :-- | :-- |
| ペイン移動 | `Ctrl+B` → `矢印キー` |
| ペイン内スクロール | `Ctrl+B` → `[` → 矢印/PgUp |
| 切断（バックグラウンド継続） | `Ctrl+B` → `D` |
| 再接続 | `tmux attach -t agents` |
| 特定ペインをズーム | `Ctrl+B` → `Z`（もう一度で戻る） |

特定のエージェントに集中したいときは、そのペインに移動して `Ctrl+B` → `Z` でフルスクリーンにできます。終わったらもう一度押せば元のレイアウトに戻ります。

***

## 起動の流れ（まとめ）

```
1.  ./scripts/init_project.sh            # 初回のみ
2.  tasks/ にタスクを追加
3.  ./scripts/launch_team.sh --dry-run   # 確認
4.  ./scripts/launch_team.sh             # 起動 → tmux画面に切替
5.  ペインを見ながら進捗を確認
6.  Ctrl+B → D で離脱（エージェントは動き続ける）
7.  ./scripts/status.sh で進捗確認
8.  tmux attach -t agents で再接続
9.  ./scripts/launch_team.sh --kill で停止
```


---

# 進捗や作業をログ出力する機能は残っているか？作業内容をトレースしたいが。

はい、残っています。`launch_agent.sh` の最終行で全出力を `tee` でログファイルに記録しています：

```bash
claude -p "$INSTRUCTION" \
  --model sonnet \
  --append-system-prompt-file "$PROMPT_FILE" \
  --dangerously-skip-permissions \
  2>&1 | tee "$LOGS_DIR/session_$(date +%Y%m%d_%H%M%S).log"
```

つまり、**tmuxペインにリアルタイム表示されると同時に、ログファイルにも全く同じ内容が残る**構成です。

***

## 現状のログ体系（3層構造）

| 層 | 何が残るか | 場所 | 誰が書くか |
| :-- | :-- | :-- | :-- |
| **①セッションログ** | Claudeの全入出力（生ログ） | `logs/{role}-{id}/session_YYYYMMDD_HHMMSS.log` | `tee` が自動記録 |
| **②進捗ログ** | やったこと・次やること（構造化メモ） | `logs/{role}-{id}/progress.md` | 各エージェントが自主更新 |
| **③全体サマリー** | プロジェクト全体の進捗 | `logs/_summary.md` | Documentarianロールが更新 |

### ①セッションログ（自動・完全）

Claudeが何を考え、何を実行し、何を出力したかがすべて残ります。トレースには一番確実ですが、**量が多く読みづらい**のが難点です。

### ②進捗ログ（エージェントが自主記録）

`base_prompt.md` で「毎ラウンドの最後に `progress.md` を更新せよ」と指示しています。フォーマット：

```markdown
## 2026-02-11T10:15:00+09:00
- タスク: tasks/features/001_user_auth.md
- ステータス: 完了
- やったこと:
  - POST /auth/login エンドポイント実装
  - JWT トークン生成ロジック追加
  - テスト5件追加、全パス
- 次にやること:
  - 次の未ロックタスクを選択
```

ただし、これは**Claudeが指示通りに書いてくれることが前提**です。書き忘れるリスクがあります。

### ③全体サマリー

Documentarianロールを起動していれば自動更新されますが、起動していなければ更新されません。

***

## 弱点と改善案

現状の仕組みには2つの弱点があります：

1. **セッションログは巨大すぎて追いづらい** — grep しないと必要な情報にたどり着けない
2. **進捗ログはClaudeの自主性に依存** — 書き忘れや形式崩れが起きうる

トレース目的であれば、`status.sh` を強化して**セッションログから構造化された情報を自動抽出**できるようにするのが効果的です。具体的には：

- `git log` から各エージェントのコミット履歴を抽出
- `locks/` の現在状態
- セッションログから `ERROR` 行の抽出

この方向で `status.sh` を強化するか、あるいは別の仕組み（例えばコミットフックで自動記録するなど）を入れるか、どちらがいいですか？

---

# コミットフックで自動記録などの仕組みで進捗ログの書き忘れ防止したい。

status.shからセッションをトレースする必要はない。必要に応じて、人間が調査するつもり。
セッションログは適切な量で廃棄したいが方法はある？例えばロールごとに10セッションの履歴保持など。

3つのスクリプトを作成しました。それぞれの役割と仕組みを説明します。

***

## 1. post-commit フック — 進捗ログの書き忘れ防止

コミットが発生するたびに **Git が自動実行** するフックです。Claudeの自主性に一切依存せず、コミットした事実から機械的にログを生成します。

### 記録される内容

```markdown
---
### 2026-02-11T10:25:00+09:00
- **commit**: `a3f8c1d`
- **message**: [feature-builder-A] feat-001: ユーザー認証エンドポイント追加
- **details**:
  POST /auth/login を実装
  JWT トークン生成ロジックを追加
- **変更規模**: +142 / -3
- **変更ファイル**:
  - src/auth/login.py
  - src/auth/jwt.py
  - tests/test_auth.py
- **🔒 ロック取得**: locks/features__001_user_auth.lock
```


### 自動検出する3つのイベント

| イベント | 検出方法 | 記録 |
| :-- | :-- | :-- |
| **通常のコミット** | コミットメッセージの `[role]` プレフィックス | 変更内容・規模・ファイル一覧 |
| **タスク完了** | `done/` へのファイル移動を検出 | 🎉 タスク完了マーク |
| **ロック操作** | `locks/*.lock` の追加/削除を検出 | 🔒取得 / 🔓解放 |

### ロール名がないコミット（人間のコミット）は無視

コミットメッセージが `[feature-builder-A] ...` の形式でなければ何もしません。人間が直接コミットしてもログが汚れません。

### 配置先

```
project-root/
├── .claude/
│   └── hooks/
│       └── post-commit    ← ここにソースを置く
└── .git/
    └── hooks/
        └── post-commit    ← setup_hooks.sh がここにコピー
```


***

## 2. rotate_logs.sh — セッションログの自動廃棄

各ロールのセッションログを**新しい順にN件だけ保持**し、残りを削除します。

```bash
# デフォルト: 各ロール10セッション保持
./scripts/rotate_logs.sh

# 5件に変更
./scripts/rotate_logs.sh 5

# 削除対象の確認だけ
./scripts/rotate_logs.sh --dry-run
```

出力例：

```
=== セッションログ ローテーション ===
  保持件数: 各ロール 10 セッション

  feature-builder-A: 23件 → 10件に縮小（13件削除）
    削除: session_20260201_091500.log
    削除: session_20260201_103000.log
    ...
  bug-fixer-A: 8件 — 削除なし

--- 結果 ---
  削除: 13 ファイル
  解放: 48M
```

定期実行したければ crontab に入れるだけです：

```bash
# 毎日深夜3時にローテーション
0 3 * * * /path/to/project/scripts/rotate_logs.sh 10
```


***

## 3. setup_hooks.sh — フックのインストール

`.claude/hooks/post-commit` を `.git/hooks/post-commit` にコピーして実行権限を付与します。`init_project.sh` の後に一度だけ実行してください。

```bash
./scripts/setup_hooks.sh
```

`.git/hooks/` は Git 管理対象外なので、リポジトリをクローンした人は再度このスクリプトを実行する必要があります。

***

## 更新後のディレクトリ構成（差分）

```
project-root/
├── .claude/
│   ├── hooks/                  ← NEW
│   │   └── post-commit         ← フックのソース
│   ├── roles/
│   └── protocols/
├── scripts/
│   ├── launch_agent.sh
│   ├── launch_team.sh
│   ├── status.sh
│   ├── setup_hooks.sh          ← NEW
│   └── rotate_logs.sh          ← NEW
└── logs/
    └── feature-builder-A/
        ├── progress.md          ← post-commit が自動更新
        ├── session_20260211_1015.log  ← 保持
        ├── session_20260211_1030.log  ← 保持
        └── (古いものは rotate で削除)
```


***

## セットアップ手順の流れ（最新版）

```
1.  ./scripts/init_project.sh        # 構成初期化
2.  ./scripts/setup_hooks.sh         # フックインストール
3.  .claude/ のプロンプトを編集
4.  tasks/ にタスクを追加
5.  ./scripts/launch_team.sh         # チーム起動
6.  ./scripts/status.sh              # 進捗確認
7.  ./scripts/rotate_logs.sh         # 定期的にログ廃棄
```

`base_prompt.md` の「毎ラウンド progress.md を更新せよ」という指示は**削除して構いません**。フックが自動でやるので、Claudeにはコミットメッセージを規約通り書くことだけ守らせれば十分です。

