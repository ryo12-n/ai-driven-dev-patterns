## Why

本リポジトリは「Claude Code + OpenSpec を前提とした仕様駆動開発のテンプレート」であるが、
`src/` ディレクトリにはまだ実際のアプリケーションコードが存在しない。
OpenSpec の変更サイクル（new → continue → apply → verify → archive）が実コード生成で機能するかを検証するため、
サンプルアプリケーションとして「マークダウンファイルの見出し一覧を出力する Go CLI ツール」を実装する。

## What Changes

- `src/` ディレクトリに Go CLI ツールのソースコードを新規作成する
- マークダウンファイルのパスを引数として受け取り、見出し（`#` で始まる行）を解析して一覧出力する CLI を実装する
- `go.mod` によるモジュール管理を導入する
- ユニットテストを追加して品質を担保する

## Capabilities

### New Capabilities

- `md-heading-cli`: マークダウンファイルの見出し一覧を出力する Go CLI ツール

### Modified Capabilities

なし（既存機能への影響なし）

## Impact

- `src/` 以下に Go ソースコード・テストコード・go.mod を新規追加
- 既存のドキュメント・設定ファイルへの影響なし
- OpenSpec の実コード生成プロセス検証という副次効果がある
