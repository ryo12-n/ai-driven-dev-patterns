## 1. プロジェクト初期化

- [ ] 1.1 `src/ec-cart-api/` ディレクトリに `go.mod` を作成する（モジュール名: `ec-cart-api`）
- [ ] 1.2 パッケージディレクトリ構成を作成する（handler / service / repository / store / model）

## 2. DB（データモデル・ストア）

- [ ] 2.1 `model/product.go` に Product 構造体を定義する（ID, Name, Description, Price, Stock）
- [ ] 2.2 `model/cart.go` に Cart, CartItem 構造体を定義する
- [ ] 2.3 `model/order.go` に Order, OrderItem 構造体を定義する
- [ ] 2.4 `repository/product.go` に ProductRepository インターフェースを定義する（FindAll, FindByID, DecrementStock）
- [ ] 2.5 `repository/cart.go` に CartRepository インターフェースを定義する（FindByID, Save, Clear）
- [ ] 2.6 `repository/order.go` に OrderRepository インターフェースを定義する（Save）
- [ ] 2.7 `model/error.go` に ErrorResponse 構造体を定義する（Error string, Details []string）
- [ ] 2.8 `store/memory.go` にインメモリ実装を作成する（sync.RWMutex によるストア全体の排他制御を含む）
- [ ] 2.9 インメモリストアにサンプルプロダクトデータを初期投入する関数を作成する

## 3. API（ハンドラー・サービス）

- [ ] 3.1 `handler/product.go` にプロダクト一覧取得ハンドラーを実装する（GET /products）
- [ ] 3.2 `handler/product.go` にプロダクト詳細取得ハンドラーを実装する（GET /products/{product_id}）
- [ ] 3.3 `handler/cart.go` にカート取得ハンドラーを実装する（GET /carts/{cart_id}）
- [ ] 3.4 `handler/cart.go` にカート商品追加ハンドラーを実装する（POST /carts/{cart_id}/items、カート自動生成を含む）
- [ ] 3.5 `handler/cart.go` にカート数量変更ハンドラーを実装する（PUT /carts/{cart_id}/items/{product_id}）
- [ ] 3.6 `handler/cart.go` にカート商品削除ハンドラーを実装する（DELETE /carts/{cart_id}/items/{product_id}）
- [ ] 3.7 `handler/order.go` に注文確定ハンドラーを実装する（POST /orders）
- [ ] 3.8 `service/product.go` にプロダクトサービスを実装する（一覧取得・詳細取得）
- [ ] 3.9 `service/cart.go` にカートサービスを実装する（取得・商品追加・数量変更・削除）
- [ ] 3.10 `service/order.go` に注文サービスを実装する（CartRepository, ProductRepository, OrderRepository の3つを注入。在庫チェック・在庫減算・注文作成・カートクリア）
- [ ] 3.11 `main.go` にエントリポイントを実装する（DI 設定・ルーター登録・サーバー起動）

## 4. テスト

- [ ] 4.1 `model/` の各構造体に対する基本的なテストを作成する
- [ ] 4.2 `store/memory_test.go` にインメモリストアのユニットテストを作成する（CRUD 操作・排他制御）
- [ ] 4.3 `service/product_test.go` にプロダクトサービスのテストを作成する
- [ ] 4.4 `service/cart_test.go` にカートサービスのテストを作成する（追加・数量変更・削除・バリデーション）
- [ ] 4.5 `service/order_test.go` に注文サービスのテストを作成する（正常系・在庫不足・空カート・同時注文）
- [ ] 4.6 `handler/` の各ハンドラーに対する HTTP テストを作成する（httptest.NewServer 使用）
- [ ] 4.7 `go build ./...` でビルドが成功することを確認する
- [ ] 4.8 `go test ./...` で全テストがパスすることを確認する
