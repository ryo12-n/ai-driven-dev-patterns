## ADDED Requirements

### Requirement: カート内容の取得
API はカートの現在の内容を返すエンドポイントを提供しなければならない（MUST）。

#### Scenario: 商品が入っているカートの取得
- **GIVEN** カート `{cart_id}` に1件以上の商品が追加されている
- **WHEN** クライアントが `GET /carts/{cart_id}` をリクエストする
- **THEN** API はカート内の全商品（プロダクトID・商品名・数量・単価・小計）と合計金額を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: 空のカートの取得
- **GIVEN** カート `{cart_id}` に商品が1件も追加されていない
- **WHEN** クライアントが `GET /carts/{cart_id}` をリクエストする
- **THEN** API は空の商品リストと合計金額 0 を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: 存在しないカートの取得
- **GIVEN** カート `{cart_id}` が存在しない
- **WHEN** クライアントが `GET /carts/{cart_id}` をリクエストする
- **THEN** API はエラーメッセージを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 404 を返さなければならない（MUST）

---

### Requirement: カートの自動生成
指定された `{cart_id}` のカートが存在しない場合、商品追加リクエスト時にカートを自動生成しなければならない（MUST）。
クライアントはカートIDを自ら生成して指定する（UUID 形式を推奨（SHOULD））。

#### Scenario: 存在しないカートへの初回商品追加
- **GIVEN** カート `{cart_id}` が存在しない
- **AND** プロダクト `{product_id}` がデータストアに存在する
- **WHEN** クライアントが `POST /carts/{cart_id}/items` に `product_id` と `quantity` を送信する
- **THEN** API はカート `{cart_id}` を新規作成し、指定プロダクトを追加しなければならない（MUST）
- **AND** 作成されたカートの内容を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 201 を返さなければならない（MUST）

---

### Requirement: カートへの商品追加
API はカートに商品を追加するエンドポイントを提供しなければならない（MUST）。

#### Scenario: 新規商品の追加
- **GIVEN** カート `{cart_id}` が存在し、プロダクト `{product_id}` がカート内に存在しない
- **WHEN** クライアントが `POST /carts/{cart_id}/items` に `product_id` と `quantity` を送信する
- **THEN** API は指定されたプロダクトを指定数量でカートに追加しなければならない（MUST）
- **AND** 更新後のカート内容を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 201 を返さなければならない（MUST）

#### Scenario: 既存商品への数量加算
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が既に存在する
- **WHEN** クライアントが `POST /carts/{cart_id}/items` に同じ `product_id` と `quantity` を送信する
- **THEN** API は既存の数量に指定数量を加算しなければならない（MUST）
- **AND** 更新後のカート内容を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: 存在しないプロダクトの追加
- **GIVEN** プロダクト `{product_id}` がデータストアに存在しない
- **WHEN** クライアントが `POST /carts/{cart_id}/items` に存在しない `product_id` を送信する
- **THEN** API はエラーメッセージを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 404 を返さなければならない（MUST）

#### Scenario: 数量が0以下の追加リクエスト
- **GIVEN** カート `{cart_id}` が存在する
- **WHEN** クライアントが `POST /carts/{cart_id}/items` に `quantity` が 0 以下の値を送信する
- **THEN** API はバリデーションエラーを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 400 を返さなければならない（MUST）

---

### Requirement: カート内商品の数量変更
API はカート内の商品の数量を変更するエンドポイントを提供しなければならない（MUST）。

#### Scenario: 正常な数量変更
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が存在する
- **WHEN** クライアントが `PUT /carts/{cart_id}/items/{product_id}` に新しい `quantity` を送信する
- **THEN** API は指定プロダクトの数量を指定値に更新しなければならない（MUST）
- **AND** 更新後のカート内容を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: 数量を0に変更
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が存在する
- **WHEN** クライアントが `PUT /carts/{cart_id}/items/{product_id}` に `quantity: 0` を送信する
- **THEN** API はそのプロダクトをカートから削除しなければならない（MUST）
- **AND** 更新後のカート内容を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: カートに存在しない商品の数量変更
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が存在しない
- **WHEN** クライアントが `PUT /carts/{cart_id}/items/{product_id}` をリクエストする
- **THEN** API はエラーメッセージを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 404 を返さなければならない（MUST）

---

### Requirement: カートからの商品削除
API はカートから商品を削除するエンドポイントを提供しなければならない（MUST）。

#### Scenario: 正常な商品削除
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が存在する
- **WHEN** クライアントが `DELETE /carts/{cart_id}/items/{product_id}` をリクエストする
- **THEN** API はそのプロダクトをカートから削除しなければならない（MUST）
- **AND** HTTP ステータスコード 204 を返さなければならない（MUST）

#### Scenario: カートに存在しない商品の削除
- **GIVEN** カート `{cart_id}` にプロダクト `{product_id}` が存在しない
- **WHEN** クライアントが `DELETE /carts/{cart_id}/items/{product_id}` をリクエストする
- **THEN** API はエラーメッセージを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 404 を返さなければならない（MUST）
