# タスクリスト: m6o-es-product-api ドキュメント移動実施

## 凡例

- ステータス: ⬜ 未着手 / 🔄 進行中 / ✅ 完了 / ⛔ ブロック
- 優先度: 🔴 高 / 🟡 中 / 🔵 低

---

## 実施ワーカー（L2-worker）タスク

### 前提情報

- **作業対象リポジトリ**: `/home/developer/projects/m6o-es-product-api_dev_process_improvement/m6o-es-product-api/`
- **設計書（マッピング表）**: `/home/developer/projects/m6o-es-product-api_dev_process_improvement/ai-driven-dev-patterns-fork/dev-process-improvement/initiatives/_archive/m6o-es-product-apiドキュメント整理/design.md`
  - セクション5.1〜5.14 に移動元→移動先の全86件が記載されている
  - **注意**: `04_work_report.md` 記載の73件は誤り。design.md の86件が正

### タスク一覧

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|----------|--------|-----------|
| T-001 | `m6o-es-product-api` リポジトリ内に新ディレクトリを作成する（`.claude/rules/`・`.claude/tools/`・`docs/design/`・`docs/process/`・`docs/re/`・`refs/poc/`・`refs/impl-history/`・`refs/process-history/`） | 8ディレクトリが存在する（各ディレクトリに `.gitkeep` を置く） | 🔴 | ✅ |
| T-002 | `design.md` のマッピング表（セクション5.1〜5.14）に従い、全86件のファイルを `git mv` で新パスへ移動する | `git status` で全86件の `renamed:` が確認できる | 🔴 | ✅ |
| T-003 | `.claude/rules/` に配置した4ファイルを kebab-case 英語名に改名する（セッション運用ガイド→`session-operation-guide.md`、ディレクトリ構成→`directory-structure.md`、プラグイン活用ガイド→`plugin-guide.md`、ワーカープロンプトテンプレート→`worker-prompt-templates.md`）※T-002 の移動時に同時に改名可 | `.claude/rules/` 配下に4ファイルが kebab-case 英語名で存在する | 🔴 | ✅ |
| T-004 | `m6o-es-product-api/CLAUDE.md` 内の `my_work/` パス参照（8箇所）を移動後の新パスへ更新する。対象行番号: 104, 123, 124, 136, 144, 145, 146, 156 | `grep my_work CLAUDE.md` の結果が0件 | 🔴 | ✅ |
| T-005 | 移動後の整合性を検証する（`my_work/` が空になっているか、新パスのファイル数が86件か、CLAUDE.md に `my_work` 残存がないか） | 全条件を満たすことを確認し、`03_work_log.md` に検証結果を記録する | 🔴 | ✅ |
| T-006 | `07_issues.md` の未転記課題を確認し、施策をまたぐ課題を `プロセス改善_課題管理.csv` へ転記する | 全課題に `[転記済 ISS-XXX]` または「転記不要」の判断が付いている | 🔴 | ✅ |

---

## 評価ワーカー（L2-evaluator）タスク

### 評価の前提

- L2-worker の `04_work_report.md` を読んで評価方針を立てること
- 評価結果は `06_eval_report.md` に記録すること

### タスク一覧

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|----------|--------|-----------|
| T-E-001 | 移動結果の全件照合（`design.md` マッピング表と実際の配置を比較） | 評価レポートに全86件の照合結果が記載されており、不一致件数が明確 | 🔴 | ✅ |
| T-E-002 | `CLAUDE.md` パス参照の評価（旧パスの残存がないか、新パスが正確か） | 評価レポートに検証結果が記載されている | 🔴 | ✅ |
| T-E-003 | kebab-case 改名の評価（4ファイルの命名が適切か） | 評価レポートに4ファイルの確認結果が記載されている | 🟡 | ✅ |
| T-E-004 | 評価中に発見した課題を `07_issues.md` へ起票し、施策をまたぐ課題を `プロセス改善_課題管理.csv` へ転記する | 全課題に `[転記済 ISS-XXX]` または「転記不要」の判断が付いている | 🔴 | ✅ |

---
**作成者**: L1
**最終更新**: 2026-03-02
