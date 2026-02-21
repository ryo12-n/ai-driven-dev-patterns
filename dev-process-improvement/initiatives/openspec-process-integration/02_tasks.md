# タスクリスト: openspec-process-integration

## 凡例

- ステータス: ⬜ 未着手 / 🔄 進行中 / ✅ 完了 / ⛔ ブロック
- 優先度: 🔴 高 / 🟡 中 / 🔵 低

---

## フェーズ1 タスク（基盤文書整備）

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-001 | `openspec/project.md` を記載する | リポジトリの目的・ディレクトリ構成・命名規約が AIエージェント向けに記述されている | 🔴 | ⬜ |
| T-002 | `openspec/AGENTS.md` を記載する | new / continue / apply / archive の各手順、spec差分の扱い方、禁止操作が記述されている | 🔴 | ⬜ |

**フェーズゲート1**: L1 が T-001・T-002 の内容をレビューし通過判定を行う

---

## フェーズ2 タスク（コマンド定義）

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-003 | `.claude/commands/opsx-new.md` を作成する | コマンドが新規 `openspec/changes/<name>/` フォルダを作成し、`proposal.md` 雛形を生成できる | 🔴 | ⬜ |
| T-004 | `.claude/commands/opsx-continue.md` を作成する | コマンドが現在の change フォルダの状態を読んで次ドキュメント（proposal → spec → design → tasks）を生成できる | 🔴 | ⬜ |
| T-005 | `.claude/commands/opsx-apply.md` を作成する | コマンドが `tasks.md` を読んでコード実装フェーズを開始できる | 🟡 | ⬜ |
| T-006 | `.claude/commands/opsx-archive.md` を作成する | コマンドが delta spec を `openspec/specs/` にマージし、`changes/` フォルダをアーカイブできる | 🟡 | ⬜ |

**フェーズゲート2**: 4コマンドが Claude Code で呼び出し可能であることを確認（手動実行で検証）

---

## フェーズ3 タスク（試験運用）

<!-- フェーズ2 のゲート通過後に詳細化する -->

| ID | タスク | 完了条件 | 優先度 | ステータス |
|----|--------|---------|--------|-----------|
| T-007 | サンプル change のテーマを選定し `/opsx:new` を実行する | `openspec/changes/<sample>/proposal.md` が生成されている | 🔴 | ⬜ |
| T-008 | `/opsx:continue` を繰り返しドキュメント一式を生成する | `proposal.md`・`specs/<domain>/spec.md`・`design.md`・`tasks.md` が揃っている | 🔴 | ⬜ |
| T-009 | `/opsx:apply` でコード実装フェーズを実行する（モックレベル可） | `tasks.md` の全タスクに着手記録があり、主要タスクが完了している | 🟡 | ⬜ |
| T-010 | `/opsx:archive` で delta spec をマージしアーカイブする | `openspec/specs/` に delta が反映され、`changes/<sample>/` がアーカイブ済みになっている | 🟡 | ⬜ |

**フェーズゲート3（最終）**: L2 評価レポートを受けて L1 が総合判定を行う

---

**作成者**: L1
**最終更新**: 2026-02-21
