## Why

README.md が OpenSpec v1 以前の構成（`AGENTS.md` / `project.md`）を前提に記述されており、
`openspec init` による新アーキテクチャ（`config.yaml` / Skills）と乖離している。
リポジトリの入口として正確な情報を提供するため、今このタイミングで修正する。

## What Changes

- `openspec/AGENTS.md` と `openspec/project.md` の説明を削除し、`openspec/config.yaml` の説明に置き換える
- `.claude/` ディレクトリの説明に `commands/opsx/` と `skills/` を追記する
- 開発フロー概要を OpenSpec v1 コマンド（`/opsx:new` 等）ベースの記述に更新する
- OpenSpec v1 では `openspec init` がコマンド・スキルを自動生成することを明記する

## Capabilities

### New Capabilities

なし（既存ファイルの更新のみ）

### Modified Capabilities

- `readme`: リポジトリのトップレベル説明文書。OpenSpec v1 の構成に合わせてディレクトリ構成表と開発フロー説明を更新する

## Impact

- `README.md`（更新対象ファイル）
- ドキュメント読者（リポジトリを参照する開発者・AIエージェント）が正確な構成を把握できるようになる
- コード・実装への影響なし
