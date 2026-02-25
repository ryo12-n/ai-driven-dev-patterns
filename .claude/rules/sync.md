# upstream 同期ルール

## このルールファイルの用途

upstream（外部リポジトリ）から origin（社内リポジトリ）へ同期する作業を依頼された際に参照すること。
通常の開発作業では参照不要。

## リポジトリの構成

本リポジトリは **外部リポジトリ(upstream)を社内リポジトリ(origin)へ疑似フォークして運用**している。

| リモート名 | URL | 役割 |
|-----------|-----|------|
| `upstream` | `https://github.com/ryo12-n/ai-driven-dev-patterns.git` | 取り込み元（外部） |
| `origin` | `https://github.com/ryo-nagata_monotaro/ai-driven-dev-patterns-fork.git` | 社内管理先 |

## 保護対象ディレクトリ（upstream から同期しない）

以下の4ディレクトリは origin 固有の作業実績であり、upstream の変更で上書きしてはならない。

- `dev-process-improvement/backlog/`
- `dev-process-improvement/inbox/`
- `dev-process-improvement/initiatives/`
- `dev-process-improvement/triage/`

## 同期手順

### 前提条件

- 実行前にすべての変更がコミット済みであること
- リポジトリルートで実行すること

### 実行コマンド

```bash
cd ~/projects/m6o-es-product-api_dev_process_improvement/ai-driven-dev-patterns
bash scripts/sync-upstream.sh
```

### スクリプトの処理内容

1. 未コミット変更の検出 → あれば中断
2. 保護対象4ディレクトリを一時バックアップ
3. `git fetch upstream`
4. `git merge upstream/main`（保護対象のコンフリクトは自動で ours を採用）
5. 保護対象ディレクトリをバックアップから復元
6. 復元による差分があればコミット
7. 完了メッセージ表示（push はしない）

### 同期後の確認と push

スクリプト完了後、ユーザーに以下を確認してもらってから push すること。
**push は自動実行しない。必ずユーザーの確認を待つこと。**

```bash
git log --oneline -5     # コミット履歴の確認
git diff origin/main     # push 前の差分確認
git push origin main     # ユーザー承認後に実行
```

## トラブルシューティング

### 保護対象外のコンフリクトが発生した場合

スクリプトはエラーで中断する。対象ファイルを手動でコンフリクト解消してから以下を実行:

```bash
git add <解消したファイル>
git commit --no-edit
bash scripts/sync-upstream.sh  # 再実行（冪等）
```

### 未コミット変更がある場合

```bash
git add .
git commit -m "作業内容の説明"
bash scripts/sync-upstream.sh
```
