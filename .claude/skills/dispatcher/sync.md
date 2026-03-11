# 双方向同期ルール

## このルールファイルの用途

origin（社内リポジトリ）と upstream（外部リポジトリ）の双方向同期を依頼された際に参照すること。
通常の開発作業では参照不要。

## 基本方針

origin と upstream の main ブランチは**常に同一コミットを維持する（完全同期）**。

**競合回避の核心原則**: 「片方で PR マージ → もう片方へ fast-forward push」

- origin と upstream で同時に PR をマージしない
- PR マージ後は速やかにもう片方へ同期する
- 同時マージが発生した場合は下記「同時マージが発生した場合の対処」を参照

## リポジトリの構成

| リモート名 | 役割 |
|-----------|------|
| `upstream` | 外部リポジトリ (ryo12-n/ai-driven-dev-patterns) |
| `origin` | 社内リポジトリ (ryo-nagata_monotaro/ai-driven-dev-patterns-fork) |

設定されているリモートは `git remote -v` で確認できる。

## 同期手順

### 前提条件

- 実行前にすべての変更がコミット済みであること
- リポジトリルートで実行すること

### パターン A: upstream → origin（upstream で PR マージした場合）

```bash
bash scripts/sync.sh upstream-to-origin
```

スクリプトの処理:
1. 未コミット変更の確認
2. `git fetch upstream`
3. `git merge --ff-only upstream/main`
4. 完了メッセージ表示（push はしない）

同期後の確認と push:
```bash
git log --oneline -5
git diff origin/main
git push origin main   # ユーザー承認後に実行
```

### パターン B: origin → upstream（origin で PR マージした場合）

```bash
bash scripts/sync.sh origin-to-upstream
```

スクリプトの処理:
1. 未コミット変更の確認
2. `git fetch origin`
3. `git merge --ff-only origin/main`
4. `gh auth switch --user ryo12-n`（push 用アカウントに切り替え）
5. 完了メッセージ表示（push はしない）

同期後の確認と push:
```bash
git log --oneline -5
git diff upstream/main
git push upstream main                    # ユーザー承認後に実行
gh auth switch --user ryo-nagata_monotaro # push 後にアカウントを元に戻す
```

**push は自動実行しない。必ずユーザーの確認を待つこと。**

## 同時マージが発生した場合の対処

万一、両方のリポジトリで同時に PR をマージしてしまい fast-forward できない場合:

```bash
# 1. どちらか一方をベースに merge コミットを作成
git fetch upstream
git fetch origin
git merge upstream/main   # コンフリクトがあれば手動解消

# 2. 解消後、両方のリモートに push して同期を回復
git push origin main
gh auth switch --user ryo12-n
git push upstream main
gh auth switch --user ryo-nagata_monotaro
```

merge コミットが生まれることを許容する。

## gh アカウントの確認

```bash
gh auth status
```

`ryo12-n` が `Active account: false` で登録済みであることを確認する。
未登録の場合は `gh auth login` で追加する（ブラウザ認証はシークレットウィンドウで対象アカウントにログインしてから行う）。

## トラブルシューティング

### 未コミット変更があってスクリプトが中断した

```bash
git add .
git commit -m "変更内容の説明"
bash scripts/sync.sh <パターン>
```

### fast-forward できなかった（同時マージ）

スクリプトがエラーで中断する。上記「同時マージが発生した場合の対処」を参照。

### gh auth switch が失敗した（アカウント未登録）

```bash
gh auth login   # シークレットウィンドウで ryo12-n アカウントにログインして認証
bash scripts/sync.sh origin-to-upstream
```
