# セッション計画: design_ec-cart-api

## 壁打ち

### 目的
Go 言語による小規模 EC カート API の設計ドキュメントを OpenSpec フローに従って作成する。

### スコープ
- 対象: OpenSpec アーティファクト（proposal → specs → design → tasks）
- 対象ドメイン: プロダクト参照 / カート操作 / 注文確定
- 技術スタック: Go
- 成果物配置先: `openspec/changes/design-ec-cart-api/`

### 不明点の洗い出しと解消
- 認証・認可の要否 → 設計スコープ外とする（API 設計に集中）
- 決済連携の要否 → スコープ外（注文確定 = 在庫チェック + 注文レコード作成まで）
- DB 選定 → 設計段階では抽象化し、具体的な DB 製品は指定しない

---

## 実施計画

### やること
1. OpenSpec change `design-ec-cart-api` を作成する
2. proposal.md を作成する（Why / What / Capabilities / Impact）
3. specs を作成する（product, cart, order の3ドメイン）
4. design.md を作成する（アーキテクチャ図・データモデル・API エンドポイント設計）
5. tasks.md を作成する（DB / API / テスト カテゴリ）
6. 設計レビューを実施する

### やらないこと
- コードの実装（設計完了後に別セッションで着手）
- UI / フロントエンド設計
- 認証・認可・決済連携の設計
- インフラ・デプロイ設計

### 完了条件
- OpenSpec の4アーティファクト（proposal / specs / design / tasks）が作成されている
- design.md に mermaid 図が最低1つ含まれている
- specs に RFC 2119 キーワードが使用されている
- 設計レビューで Critical / High の指摘がない
