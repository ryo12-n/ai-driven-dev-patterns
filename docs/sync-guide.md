# 双方向同期ガイド

## 背景

origin と upstream の main ブランチは**常に同一コミットを維持する（完全同期）**。

| リモート名 | 役割 |
|-----------|------|
| `upstream` | 外部リポジトリ (ryo12-n/ai-driven-dev-patterns) |
| `origin` | 社内リポジトリ (ryo-nagata_monotaro/ai-driven-dev-patterns-fork) |

設定済みのリモートは `git remote -v` で確認できる。

---

## 運用ルール

- **origin と upstream で同時に PR をマージしない**
- PR マージ後は速やかにもう片方へ同期する
- 同時マージが発生した場合は `.claude/rules/sync.md` の対処手順を参照

---

## 手動で同期する場合

### 前提条件

- 実行前にすべての変更をコミットしておくこと
- リポジトリルート（`ai-driven-dev-patterns/`）で実行すること

---

### パターン A: upstream → origin（upstream で PR マージした場合）

```bash
# 1. 同期スクリプトを実行
bash scripts/sync.sh upstream-to-origin

# 2. 結果を確認
git log --oneline -5
git diff origin/main

# 3. 問題なければ push
git push origin main
```

---

### パターン B: origin → upstream（origin で PR マージした場合）

```bash
# 1. 同期スクリプトを実行（ryo12-n へのアカウント切り替えも自動実行）
bash scripts/sync.sh origin-to-upstream

# 2. 結果を確認
git log --oneline -5
git diff upstream/main

# 3. 問題なければ push
git push upstream main

# 4. アカウントを元に戻す
gh auth switch --user ryo-nagata_monotaro
```

---

## Claude に依頼する場合

### 依頼フレーズ（自由な日本語で OK）

- 「upstream を同期して」（upstream → origin）
- 「origin の変更を upstream に反映して」（origin → upstream）
- 「upstream に push して」（origin → upstream）

### 推奨プロンプトテンプレート

```
.claude/rules/sync.md に従って [upstream-to-origin / origin-to-upstream] で同期してください。
```

> **補足**: このプロンプトにより Claude は `.claude/rules/sync.md` を読んでから作業を開始する。

---

## トラブルシューティング

### 未コミット変更があってスクリプトが中断した

```bash
git add .
git commit -m "変更内容の説明"
bash scripts/sync.sh <パターン>
```

### fast-forward できなかった（同時マージ）

スクリプトがエラーメッセージを表示して中断する。
`.claude/rules/sync.md` の「同時マージが発生した場合の対処」を参照。
