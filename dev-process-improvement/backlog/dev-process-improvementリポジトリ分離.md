# dev-process-improvement リポジトリ分離

## メタ情報

| 項目 | 内容 |
|------|------|
| **優先度** | 🟡 中 |
| **ステータス** | 候補 |
| **起票日** | 2026-03-02 |

## 課題・背景

dev-process-improvement ディレクトリを独立リポジトリ（https://github.com/ryo12-n/dev-process-improvement）へ分離したい。

### 実現可能性評価結果（2026-03-02 トリアージ時点）

**独立度 95%** — 技術的障壁なし。

| 観点 | 結果 |
|------|------|
| 内部参照の完結性 | `.claude/rules/`、`initiatives/`、`backlog/`、`docs/`、`refs/` すべて内部パスのみ参照 |
| 外部依存 | コード依存ゼロ。全コンテンツは Markdown + CSV |
| 親リポからの参照 | 2箇所のみ（ルート CLAUDE.md の collab-log パス、README.md の sync 除外リスト）。いずれもドキュメント的参照で機能的依存なし |
| Git 構成 | サブモジュールなし。通常ディレクトリ管理 |
| .claude/ 設定 | 自前の rules/ を持ち、親の .claude/ とは独立 |

### 分離手順（概要）

1. `git subtree split` で履歴付き分離（または単純コピー）
2. `https://github.com/ryo12-n/dev-process-improvement` へ push
3. 親リポの CLAUDE.md・README.md・rules/ の参照を更新
4. 親リポから `dev-process-improvement/` を削除

## 期待効果

- プロセス改善の関心事が独立し、リポジトリの責務が明確になる
- ai-driven-dev-patterns リポジトリがパターン集としての本来の役割に集中できる

## 補足・参考情報

- 元 inbox: `dev-process-improvementを別リポジトリとして独立させたい.md`
- 分離後の検討事項:
  - collab-log 記録先の決定（新リポ側 or 親リポ側に新設）
  - role-format-guide.md の適用対象から dev-process-improvement のロールが外れる点の整理
