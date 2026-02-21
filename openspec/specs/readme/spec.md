# readme Specification

## Purpose
TBD - created by archiving change update-readme-for-v1. Update Purpose after archive.
## Requirements
### Requirement: ディレクトリ構成の正確性
README.md のディレクトリ構成表は、現時点でリポジトリに存在するファイル・ディレクトリと一致していなければならない（MUST）。

#### Scenario: openspec/ セクションの記載
- **WHEN** 読者が README の `openspec/` ディレクトリの説明を読む
- **THEN** `config.yaml`（スキーマ・コンテキスト設定ファイル）の説明を含んでいなければならない（MUST）。廃止された `AGENTS.md` および `project.md` の記述を含んではならない（MUST NOT）

#### Scenario: .claude/ セクションの記載
- **WHEN** 読者が README の `.claude/` ディレクトリの説明を読む
- **THEN** `commands/opsx/`（opsx スラッシュコマンド群）と `skills/`（OpenSpec スキル群）の説明を含んでいなければならない（MUST）

### Requirement: 開発フロー説明の正確性
README.md の「開発フロー」セクションは、OpenSpec v1 の実際のコマンド体系と一致していなければならない（MUST）。

#### Scenario: コマンド名の記載
- **WHEN** 読者が開発フローの手順を読む
- **THEN** `/opsx:new`・`/opsx:continue`・`/opsx:apply`・`/opsx:archive` のコマンド名を使用していなければならない（MUST）。さらに `openspec init` の実行でコマンドとスキルが自動生成されることを明記していなければならない（MUST）

