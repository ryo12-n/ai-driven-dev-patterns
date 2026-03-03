# PR 作成失敗時のフォールバック

## 適用対象

全セッション共通。`gh pr create` を使用する全ての場面に適用する。

## ルール

`gh pr create` が失敗した場合（`command not found`、ネットワークエラー等）、以下のフォールバック手順を**必ず**実行すること。

### 1. GitHub の PR 作成 URL を表示する

```
https://github.com/<owner>/<repo>/pull/new/<branch-name>
```

- `<owner>/<repo>` は `git remote get-url origin` から取得する
- `<branch-name>` は `git branch --show-current` から取得する

### 2. PR タイトルと本文を提示する

URL と合わせて、以下の情報をユーザーに提示する。

- **PR タイトル**: セッションルールで定められた形式のタイトル
- **PR 本文**: Summary・変更内容の要約（ユーザーが GitHub 上でコピー＆ペーストできる形式）

### 3. push 済みであることを確認する

PR 作成 URL を表示する前に、対象ブランチが remote に push 済みであることを確認する。未 push の場合は先に push を実施する。
