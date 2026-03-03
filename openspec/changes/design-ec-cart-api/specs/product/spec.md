## ADDED Requirements

### Requirement: プロダクト一覧の取得
API はプロダクト一覧を返すエンドポイントを提供しなければならない（MUST）。

#### Scenario: 正常なプロダクト一覧取得
- **GIVEN** データストアにプロダクトが1件以上登録されている
- **WHEN** クライアントが `GET /products` をリクエストする
- **THEN** API はプロダクトの一覧（ID・名前・価格・在庫数）を JSON 配列で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: プロダクトが0件の場合
- **GIVEN** データストアにプロダクトが1件も登録されていない
- **WHEN** クライアントが `GET /products` をリクエストする
- **THEN** API は空の JSON 配列を返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

---

### Requirement: プロダクト詳細の取得
API は個別プロダクトの詳細情報を返すエンドポイントを提供しなければならない（MUST）。

#### Scenario: 存在するプロダクトの詳細取得
- **GIVEN** データストアに ID が `{product_id}` のプロダクトが存在する
- **WHEN** クライアントが `GET /products/{product_id}` をリクエストする
- **THEN** API はそのプロダクトの詳細情報（ID・名前・説明・価格・在庫数）を JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 200 を返さなければならない（MUST）

#### Scenario: 存在しないプロダクトの詳細取得
- **GIVEN** データストアに ID が `{product_id}` のプロダクトが存在しない
- **WHEN** クライアントが `GET /products/{product_id}` をリクエストする
- **THEN** API はエラーメッセージを JSON で返さなければならない（MUST）
- **AND** HTTP ステータスコード 404 を返さなければならない（MUST）
