# タスクリスト: .claude/ ディレクトリ用途最適化

## 凡例
- ステータス: ⬜ 未着手 / 🔄 進行中 / ✅ 完了 / ⛔ ブロック
- 優先度: 🔴 高 / 🟡 中 / 🔵 低

## フェーズ1 タスク

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-001 | `rules/session-flow-policy.md` を `skills/session-flow-policy/SKILL.md` に移行する。YAML フロントマター（`name: session-flow-policy`, `description: '新セッションタイプの作成・.claude/skills/ 配下のスキル/エージェント構成の変更時に参照するポリシー'`, `user-invocable: false`）を先頭に追加し、元ファイルの内容をそのまま Markdown 本文として配置する。元の `rules/session-flow-policy.md` は削除する | `skills/session-flow-policy/SKILL.md` が存在し、YAML フロントマターが正しく設定され、本文が元ファイルと同一。`rules/session-flow-policy.md` が存在しない | 🔴 | ✅ |
| T-002 | `rules/triage-standard-policy-guideline.md` を `skills/triage-standard-policy/SKILL.md` に移行する。YAML フロントマター（`name: triage-standard-policy`, `description: 'トリアージ走査（TG-008）・ペアリング検証・ライフサイクル準拠チェック時に参照するガイドライン'`, `user-invocable: false`）を先頭に追加し、元ファイルの内容をそのまま Markdown 本文として配置する。元の `rules/triage-standard-policy-guideline.md` は削除する | `skills/triage-standard-policy/SKILL.md` が存在し、YAML フロントマターが正しく設定され、本文が元ファイルと同一。`rules/triage-standard-policy-guideline.md` が存在しない | 🔴 | ✅ |
| T-003 | `l1-manager` SKILL.md に session-flow-policy スキルへの参照を追記する。「新セッションタイプを作成する際は session-flow-policy スキルを参照すること」という旨を適切なセクション（「ルール」または新セクション）に追加する | `l1-manager` SKILL.md に session-flow-policy への参照記述が存在する | 🔴 | ✅ |
| T-004 | `triage-manager` SKILL.md 内の `.claude/rules/triage-standard-policy-guideline.md` への参照パス（2箇所: 178行目付近と221行目付近）を `.claude/skills/triage-standard-policy/SKILL.md` に更新する。また、triage-standard-policy スキルを参照する旨の記述を追加する | 旧パス `.claude/rules/triage-standard-policy-guideline.md` への参照が存在せず、新パスに更新されている | 🔴 | ✅ |
| T-005 | `triage-worker.md`（`skills/triage-manager/agents/triage-worker.md`）内の `.claude/rules/triage-standard-policy-guideline.md` への参照パス（2箇所: 153行目付近と167行目付近）を `.claude/skills/triage-standard-policy/SKILL.md` に更新する | 旧パスへの参照が存在せず、新パスに更新されている | 🔴 | ✅ |
| T-006 | `session-flow-policy` の本文内にある `triage-standard-policy-guideline.md` への参照（132行目付近）を新パスに更新する | 旧パスへの参照が存在せず、新パスに更新されている | 🟡 | ✅ |
| T-007 | `docs/workflow.md` 内の `.claude/rules/triage-standard-policy-guideline.md` への参照（97行目付近）を新パスに更新する。また、ディレクトリ構成の説明がある場合は skills/ の追加を反映する | `docs/workflow.md` 内の参照パスが更新されている | 🟡 | ✅ |
| T-008 | `rules/commit-message.md` が rules/ に残っていることを確認する（誤移行されていないことの検証） | `rules/commit-message.md` が存在し、内容が変更されていない | 🟡 | ✅ |
| T-009 | 作業中に発見した知見を `04_work_report.md` の「作業中の知見」セクションに記録する。「ルール化候補」と「参考情報」に分類し、各テーブルに最低1行記載する（該当なしの場合は「なし — 理由: ○○」と記載） | 「ルール化候補」「参考情報」の両テーブルに最低1行の記載がある | 🔴 | ✅ |
| T-010 | `07_issues.md` の未転記課題を確認し、施策をまたぐ課題を `プロセス改善_課題管理.csv` へ転記する | 全課題に `[転記済 ISS-XXX]` または「転記不要」の判断が付いている | 🔴 | ✅ |

---
**作成者**: L1
**最終更新**: 2026-03-06
