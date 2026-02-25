# upstream 同期ガイド

## 背景

本リポジトリは外部リポジトリ(upstream)を社内リポジトリ(origin)へ疑似フォークして運用している。
upstream の最新変更を定期的に取り込みながら、社内固有の作業実績ディレクトリは upstream の変更で上書きしない仕組みを整備している。

| リモート名 | 役割 |
|-----------|------|
| `upstream` | 取り込み元（外部リポジトリ） |
| `origin` | 自組織の管理先リポジトリ |

設定済みのリモートは `git remote -v` で確認できる。

---

## 保護対象ディレクトリ

以下の4ディレクトリは **origin 固有の作業実績** であり、upstream の変更で上書きしない。

| ディレクトリ | 理由 |
|-------------|------|
| `dev-process-improvement/backlog/` | 社内の施策候補・アイデアを管理 |
| `dev-process-improvement/inbox/` | 社内の未処理アイテムを管理 |
| `dev-process-improvement/initiatives/` | 社内の進行中・完了済み施策を管理 |
| `dev-process-improvement/triage/` | 社内のトリアージセッション成果物を管理 |

upstream 側にも独自コンテンツが存在するが、取り組む内容が別々であるため同期しない。

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
> 保護対象ディレクトリ・スクリプトパス・push前確認ポリシーがルールファイルに記載されている。

### どのディレクトリから依頼してもよい

以下どちらのディレクトリから `claude` を起動した場合でも、上記プロンプトで対応できる。

- `ai-driven-dev-patterns/`（リポジトリルート）
- このリポジトリの親ディレクトリ

---

## トラブルシューティング

### 未コミット変更があってスクリプトが中断した

```bash
git add .
git commit -m "変更内容の説明"
bash scripts/sync-upstream.sh
```

### 保護対象外のコンフリクトが発生した

スクリプトがコンフリクトファイルのパスを表示して中断する。
該当ファイルを手動で解消してから以下を実行:

```bash
git add <解消したファイル>
git commit --no-edit
bash scripts/sync-upstream.sh
```

### 保護対象ディレクトリが upstream の内容で上書きされた（スクリプトを使わなかった場合）

```bash
# origin/main の状態に戻す
git checkout origin/main -- dev-process-improvement/backlog dev-process-improvement/inbox dev-process-improvement/initiatives dev-process-improvement/triage
git commit -m "Restore origin-only directories"
```
