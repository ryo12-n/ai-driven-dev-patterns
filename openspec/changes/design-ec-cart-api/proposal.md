## Why

EC サイトにおけるカート機能は最も基本的かつ重要なドメインの一つである。
本変更では、Go 言語を用いた小規模な EC カート API を設計する。
プロダクト参照・カート操作・注文確定の3ドメインに絞り、
シンプルかつ実用的な REST API の設計パターンを確立する。

認証・認可、決済連携、配送管理などは意図的にスコープ外とし、
カートドメインの核心であるプロダクト → カート → 注文のフローに集中する。

## What Changes

- EC カート API の仕様（specs）を新規作成する（product / cart / order の3ドメイン）
- API の技術設計書（design.md）を作成する（データモデル・エンドポイント・シーケンス図）
- 実装タスク一覧（tasks.md）を作成する

## Capabilities

### New Capabilities

- `product`: プロダクト一覧取得・詳細取得の API
- `cart`: カートへの商品追加・数量変更・削除・カート内容取得の API
- `order`: 在庫チェックを含む注文確定の API

### Modified Capabilities

なし（新規設計）

## Success Criteria

- 3ドメイン（product / cart / order）の specs が RFC 2119 キーワードを使用して定義されている
- design.md にアーキテクチャ図とシーケンス図が含まれている
- tasks.md に実装可能な粒度のタスクが列挙されている
- 設計レビューで Critical / High の指摘がない

## Impact

- `src/` 以下に Go のソースコードを新規追加する想定（実装は別セッション）
- `openspec/specs/` に product / cart / order の3仕様を追加
- 既存のドキュメント・設定ファイルへの影響なし
