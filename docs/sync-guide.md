# upstream 同期ガイド

## 背景

本リポジトリは外部リポジトリ(upstream)を社内リポジトリ(origin)へ疑似フォークして運用している。
upstream の最新変更を定期的に取り込み、完全同期を維持する。

| リモート名 | 役割 |
|-----------|------|
| `upstream` | 取り込み元（外部リポジトリ） |
| `origin` | 自組織の管理先リポジトリ |

設定済みのリモートは `git remote -v` で確認できる。

---

## 手動で同期する場合

### 前提条件

- 実行前にすべての変更をコミットしておくこと
- リポジトリルート（`ai-driven-dev-patterns/`）で実行すること

### 実行手順

```bash
cd <このリポジトリのローカルパス>

# 1. 未コミット変更がないことを確認
git status

# 2. 同期スクリプトを実行
bash scripts/sync-upstream.sh

# 3. 結果を確認
git log --oneline -5
git diff origin/main

# 4. 問題なければ push（スクリプトは push しない）
git push origin main
```

---

## Claude に依頼する場合

### 依頼フレーズ（自由な日本語で OK）

以下のような表現で依頼できる。

- 「upstream を同期して」
- 「upstream の最新を取り込んで」
- 「外部リポジトリの変更を取り込んで」

### 推奨プロンプトテンプレート

Claude に依頼する際は、以下のプロンプトを使うとルールファイルを確実に参照させることができる。

```
.claude/rules/sync.md に従って upstream を同期してください。
```

> **補足**: このプロンプトにより Claude は `.claude/rules/sync.md` を読んでから作業を開始する。
> スクリプトパス・push前確認ポリシーがルールファイルに記載されている。

### どのディレクトリから依頼してもよい

以下どちらのディレクトリから `claude` を起動した場合でも、上記プロンプトで対応できる。

- `ai-driven-dev-patterns/`（リポジトリルート）
- このリポジトリの親ディレクトリ

---

## upstream への push

origin の変更を upstream にも反映したい場合の手順。
`gh` CLI でアカウントを切り替えてから push する。

### 前提

- upstream のリポジトリオーナーアカウントが `gh auth status` に登録済みであること
- 未登録の場合は `gh auth login` で追加する（ブラウザ認証はシークレットウィンドウで対象アカウントにログインしてから行う）

### 手順

```bash
# 1. 登録済みアカウントを確認
gh auth status

# 2. upstream オーナーアカウントに切り替え
gh auth switch --user <upstream-owner-account>

# 3. upstream に push
git push upstream main

# 4. 元のアカウントに戻す
gh auth switch --user <origin-account>
```

### Claude に依頼する場合

```
.claude/rules/sync.md に従って upstream に push してください。
```

---

## トラブルシューティング

### 未コミット変更があってスクリプトが中断した

```bash
git add .
git commit -m "変更内容の説明"
bash scripts/sync-upstream.sh
```

### コンフリクトが発生した

スクリプトがコンフリクトファイルのパスを表示して中断する。
該当ファイルを手動で解消してから以下を実行:

```bash
git add <解消したファイル>
git commit --no-edit
bash scripts/sync-upstream.sh
```
