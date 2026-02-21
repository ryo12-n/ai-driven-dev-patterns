## 1. ディレクトリ構成表の更新

- [x] 1.1 `openspec/AGENTS.md` の行を `openspec/config.yaml`（スキーマ・プロジェクトコンテキスト設定ファイル）の説明行に置き換える
- [x] 1.2 `openspec/project.md` の行を削除する（config.yaml の説明に統合済みのため）
- [x] 1.3 `.claude/` のサブアイテムとして `commands/opsx/` と `skills/` の説明行を追加する

## 2. ディレクトリ役割説明セクションの更新

- [x] 2.1 `openspec/` セクションのファイル/ディレクトリ役割表から `AGENTS.md` 行と `project.md` 行を削除し、`config.yaml` 行を追加する
- [x] 2.2 `.claude/` セクションの役割表に `commands/opsx/` と `skills/` の行を追加する
- [x] 2.3 `openspec init` が実行によりコマンドとスキルを自動生成することを注記として追加する

## 3. 開発フロー概要の更新

- [x] 3.1 開発フローのステップを OpenSpec v1 コマンド（`/opsx:new`・`/opsx:continue`・`/opsx:apply`・`/opsx:archive`）ベースの記述に更新する
- [x] 3.2 「`openspec/changes/<feature>/ にサイクル用フォルダを作成」という手動手順の記述を、`/opsx:new` コマンドによる自動作成の記述に置き換える
