# タスクリスト: dev-process-improvement リポジトリ分離

## 凡例
- ステータス: ⬜ 未着手 / 🔄 進行中 / ✅ 完了 / ⛔ ブロック
- 優先度: 🔴 高 / 🟡 中 / 🔵 低

## フェーズ1 タスク

### 新リポ作成・コンテンツ移行

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-001 | `gh repo create ryo12-n/dev-process-improvement --public` で新リポを作成する。作成不可の場合は L1 に報告して停止する | GitHub 上にリポジトリが存在する | 🔴 | ⛔ |
| T-002 | `dev-process-improvement/` 配下のコンテンツを一時ディレクトリにコピーし、新リポとして `git init` → 初回コミット → push する。コピー時に `initiatives/_template/` と `initiatives/_archive/` を含める。`initiatives/dev-process-improvementリポジトリ分離/` は除外する（本施策は親リポ側で管理中のため） | 新リポの main ブランチにコンテンツが存在する | 🔴 | ⛔ |
| T-003 | 新リポ内のファイルで `dev-process-improvement/` プレフィックスのパス参照を検索し、ルート相対パスに修正する（例: `dev-process-improvement/docs/` → `docs/`）。README.md のセッション起動パスも修正する | `grep -r "dev-process-improvement/" .` で不要なプレフィックス参照が 0 件 | 🔴 | ⛔ |

### 親リポの参照更新

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-004 | `dev-process-improvement/docs/collab-log.md` の内容を `docs/collab-log.md`（親リポ直下）に移設する。ファイルが存在しない場合は新規作成する | `docs/collab-log.md` が存在し、既存エントリが保持されている | 🔴 | ✅ |
| T-005 | 親リポ `CLAUDE.md` の「自己改善ループ」セクションの collab-log パスを `dev-process-improvement/docs/collab-log.md` → `docs/collab-log.md` に変更する | CLAUDE.md 内の collab-log パスが `docs/collab-log.md` を指している | 🔴 | ✅ |
| T-006 | 親リポ `README.md` の sync 除外リストから `dev-process-improvement/` の4行を削除する。セクション全体が不要になる場合はセクションごと削除する | README.md に `dev-process-improvement/` への参照がない | 🔴 | ✅ |
| T-007 | `.claude/rules/role-format-guide.md` の「適用対象」から `dev-process-improvement/.claude/rules/*.md` の記述を除去する | role-format-guide.md に dev-process-improvement の適用対象記述がない | 🟡 | ✅ |
| T-008 | `.claude/rules/claude-directory-guide.md` の「現状構成」セクションから dev-process-improvement の記述を除去する | claude-directory-guide.md に dev-process-improvement の記述がない | 🟡 | ✅ |
| T-009 | `docs/git-worktree-guideline.md` の参照テーブルから dev-process-improvement のエントリを除去する | git-worktree-guideline.md に dev-process-improvement の参照がない | 🔵 | ✅ |
| T-010 | `docs/design/dev-workflow-overview.md` の dev-process-improvement への言及を「外部リポジトリで管理」等の記述に更新する | dev-workflow-overview.md の記述が分離後の状態を反映している | 🔵 | ✅ |
| T-011 | `roles/_base/common.md` のディレクトリ構成コメントから dev-process-improvement 行を除去する | common.md に dev-process-improvement の記述がない | 🔵 | ✅ |
| T-012 | `openspec/config.yaml` から dev-process-improvement のコメント行を除去する | config.yaml に dev-process-improvement の記述がない | 🔵 | ✅ |

### 親リポからの削除

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-013 | 親リポから `dev-process-improvement/` を `git rm -r` で削除する。ただし本施策の `initiatives/dev-process-improvementリポジトリ分離/` 配下の成果物は先に `08_gate_review.md` が完成するまで保持する（L1 の指示に従う） | `dev-process-improvement/` ディレクトリが親リポに存在しない | 🔴 | ⬜ |

### レポート・知見記録（固定タスク）

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-014 | 作業中に発見した知見を `04_work_report.md` の「作業中の知見」セクションに記録する。「ルール化候補」と「参考情報」に分類し、各テーブルに最低1行記載する（該当なしの場合は「なし — 理由: ○○」と記載） | 「ルール化候補」「参考情報」の両テーブルに最低1行の記載がある | 🔴 | ✅ |
| T-015 | `07_issues.md` の未転記課題を確認し、施策をまたぐ課題を `プロセス改善_課題管理.csv` へ転記する | 全課題に `[転記済 ISS-XXX]` または「転記不要」の判断が付いている | 🔴 | ✅ |

---
**作成者**: L1
**最終更新**: 2026-03-02
