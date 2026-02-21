新機能追加ケースを例に、OpenSpecの典型的なファイルを書き起こします。実際には `openspec/changes/add-user-profile/` みたいなフォルダがAIによって作られます。[1][2]

例の前提:  
「ユーザーにプロフィール編集機能（表示名・自己紹介・アイコン画像）を追加する」

***

## ディレクトリ構成イメージ

```text
openspec/
  project.md              # プロジェクト共通ルール（ここでは省略）
  specs/                  # すでに実装済みの現在仕様
    user/
      spec.md
  changes/
    add-user-profile/     # 今回の“変更”のサイクル
      proposal.md
      design.md
      tasks.md
      specs/
        user/
          spec.md         # 「差分仕様（delta）」としての変更点
```


***

## proposal.md（変更提案）

```markdown
# Change Proposal: add-user-profile

## Summary
Webアプリに、ユーザー自身がプロフィール情報（表示名・自己紹介・アイコン画像）を編集できる機能を追加する。

## Motivation
現在のアプリでは、ユーザーはログインしても自分の情報をほとんど編集できず、
サービスへの愛着や継続利用の動機が弱い。
プロフィール編集機能を提供することで、ユーザー体験の向上と再訪率の向上を狙う。

## Scope

### In Scope
- ログイン中ユーザーのプロフィール編集画面の追加
- 以下項目の編集・保存
  - 表示名（最大50文字）
  - 自己紹介（最大500文字）
  - アイコン画像（1MB以下のPNG/JPEG）
- プロフィール閲覧用の公開ページ（ログイン不要）

### Out of Scope
- SNS連携によるアイコン画像の取得
- カバー画像や追加フィールド（所在地、リンク等）
- モバイルネイティブアプリでの画面実装

## Success Criteria
- 既存ユーザーの30%以上が1ヶ月以内にプロフィールを1回以上更新する。
- プロフィール閲覧ページのPVが、リリース後3ヶ月で全PVの10%以上を占める。
```

***

## specs/user/spec.md（差分仕様）

```markdown
# Spec Delta: add-user-profile / user

## Overview
このファイルは、ユーザー機能に対する「プロフィール編集・閲覧」の仕様追加分を定義する。
既存の `openspec/specs/user/spec.md` に対する差分として解釈される。

## New Profile Fields

### Data Model
- `display_name`: string, 必須, 最大50文字
- `bio`: string, 任意, 最大500文字
- `avatar_url`: string, 任意, 画像URL。アップロード後のCDNパスを保存する。

### Validation Rules
- display_name
  - 空文字禁止
  - 先頭・末尾の空白は保存前にトリムする
- bio
  - 500文字を超える場合はバリデーションエラー
- avatar
  - 受け付けるMIMEタイプ: image/png, image/jpeg
  - 最大サイズ: 1MB
  - 正方形でなくてもよいが、表示時に正方形でトリミングする

## API: Update Profile

### Endpoint
- `PATCH /api/v1/me/profile`

### Request Body (JSON)
| フィールド      | 型      | 必須 | 説明                     |
|-----------------|---------|------|--------------------------|
| display_name    | string  | 任意 | 新しい表示名             |
| bio             | string  | 任意 | 新しい自己紹介           |
| avatar_upload_id| string  | 任意 | 事前アップロードIDへの参照|

### Responses

#### 200 OK
- 内容: 更新後のプロフィールを返却する。

#### 400 Bad Request
- 条件: バリデーションエラー（文字数超過、サイズ超過など）。
- 本文: エラーコードとフィールド単位のエラーメッセージ。

#### 401 Unauthorized
- 条件: 未ログイン。

## UI Behavior (概要レベル)
- 設定画面から「プロフィール編集」画面へ遷移できる。
- 保存成功時は「プロフィールを更新しました」とトースト表示。
- エラー時は各フィールドの下にエラーメッセージを表示する。
```

***

## design.md（技術設計）

```markdown
# Design: add-user-profile

## Overview
このドキュメントは、「プロフィール編集・閲覧」機能を実装する際の技術的な方針を定義する。

## Architecture

### Backend
- 既存の `User` テーブルに以下カラムを追加する。
  - `display_name` (varchar(50), not null, default: '')
  - `bio` (text, nullable)
  - `avatar_url` (varchar(255), nullable)
- 認証済みユーザーの情報は既存のセッション/トークン機構を利用する。
- 画像アップロードは既存のファイルアップロードサービス（S3互換API）を使用する。

### Frontend
- `/settings/profile` にSPAの新規画面を追加。
- フォームライブラリとして既存の `react-hook-form` を利用する。
- 画像は一旦ローカルプレビューを表示し、サーバーにアップロード後、返却されたURLを`avatar_url`として保存する。

## Data Flow (High-level)

1. ユーザーがプロフィール編集画面を開く。
2. フロントエンドが `GET /api/v1/me` で現在のプロフィールを取得。
3. ユーザーがフォームを編集し、保存ボタンを押下。
4. 画像が新規アップロードの場合:
   - `POST /api/v1/files` に画像を送信し、`avatar_upload_id` を取得。
5. フロントエンドが `PATCH /api/v1/me/profile` を呼び出す。
6. バックエンドがバリデーション・保存を行い、更新後プロフィールを返却。
```

***

## tasks.md（実装タスク）

```markdown
# Tasks: add-user-profile

## 1. Database

- [ ] 1.1 `users` テーブルに `display_name`, `bio`, `avatar_url` カラムを追加する。
- [ ] 1.2 既存ユーザーに対して `display_name` の初期値をメールアドレスのローカル部から生成する。

## 2. Backend API

- [ ] 2.1 `GET /api/v1/me` のレスポンスに `display_name`, `bio`, `avatar_url` を含める。
- [ ] 2.2 `PATCH /api/v1/me/profile` エンドポイントを追加する。
- [ ] 2.3 バリデーションロジック（文字数・MIMEタイプ・サイズ）の実装。
- [ ] 2.4 エラー時のレスポンスフォーマットを既存APIと合わせる。

## 3. Frontend

- [ ] 3.1 `/settings/profile` 画面コンポーネントの追加。
- [ ] 3.2 フォームUI（表示名・自己紹介・アイコン画像アップロード）の実装。
- [ ] 3.3 画像プレビュー処理の実装。
- [ ] 3.4 成功・失敗時のトースト/バリデーション表示の実装。

## 4. Tests

- [ ] 4.1 `PATCH /api/v1/me/profile` のユニットテスト追加。
- [ ] 4.2 フロントエンドのフォームバリデーションのテスト。
- [ ] 4.3 画像アップロード失敗時のエラーハンドリングテスト。

## 5. Docs & Migration

- [ ] 5.1 既存ユーザー向けリリースノートへの追記。
- [ ] 5.2 DBマイグレーション手順書の更新。
```

***

## Claude / AIエージェントとのやり取りイメージ

OpenSpecを使うツールでは、だいたい次のようなコマンドでこの一式が自動生成されます。[2][3]

```text
You: /opsx:new add-user-profile
You: /opsx:continue  # proposal.md を作る
You: /opsx:continue  # specs/user/spec.md (delta) を作る
You: /opsx:continue  # design.md を作る
You: /opsx:continue  # tasks.md を作る

(人間が中身をレビュー・修正)

You: /opsx:apply add-user-profile
  → AIが tasks.md に従ってコードを実装していく

You: /opsx:archive add-user-profile
  → delta spec を openspec/specs/ にマージしてアーカイブ
```


***

この例を、あなたのプロジェクト・スタック（言語やフレームワーク）に合わせてカスタマイズするひな形にしてしまうと運用しやすいです。  

今の開発言語とフロント/バックの構成（例: Next.js + Node / Rails / Laravel など）を教えてもらえれば、そのスタック向けに上の4ファイルをもう少し具体化した形に書き直します。

情報源
[1] OpenSpec で始める仕様駆動開発 - Zenn https://zenn.dev/ashita_team/articles/openspec-spec-driven-development
[2] Fission-AI/OpenSpec: Spec-driven development for AI ... https://github.com/Fission-AI/OpenSpec
[3] OpenSpec - Spec-Driven Development for AI Coding Assistants ... https://openspec.pro
[4] Open Specを使った気楽なSpec Codingのやり方 - note https://note.com/brave_quince241/n/n6d4bb3ee0a12
[5] OpenSpecの導入と開発サイクルの回し方に関して - Zenn https://zenn.dev/tanipotato/articles/e99613ba053189
[6] OpenSpec早見表 #ClaudeCode - Qiita https://qiita.com/y-hirakaw/items/6e7e181f87fbe65cb891
[7] もうAIに振り回されない！OpenSpecで実現する予測可能なAI開発 https://tech-lab.sios.jp/archives/50546
[8] 【OpenSpec v1.x】メジャーアップデートまとめ：日本語対応と検証 ... https://zenn.dev/z_maruhira/articles/53e9bf5f68bc1a
[9] OpenSpec Changes Everything — No More Vibe Coding! (Full Step-by-Step) | AI | AI Agent | LLM https://www.youtube.com/watch?v=xwpmPP4mNBQ
[10] 仕様書がコードを生む時代：話題のSDDを試してみた https://tech.algomatic.jp/entry/2025/09/22/143931
[11] OpenSpec Changes Everything - No More Vibe Coding (Full Tutorial) https://www.youtube.com/watch?v=5oUmpdpbejk
[12] 仕様駆動型開発を簡単に導入できる「OpenSpec」を利用して一貫性のあるコードを生成する方法 https://news.livedoor.com/article/detail/29858981/
[13] 次世代の開発組織は変わるか？ GitHub初  仕様駆動開発ツール ... - note https://note.com/right_avocet5550/n/nd8abb01b1bb8
[14] 仕様駆動型開発を簡単に導入できる「OpenSpec」を利用して一貫性 ... https://gigazine.net/news/20251026-openspec/
[15] 仕様駆動開発の理想と現実、そして向き合い方 - Speaker Deck https://speakerdeck.com/gotalab555/shi-yang-qu-dong-kai-fa-noli-xiang-toxian-shi-sositexiang-kihe-ifang
