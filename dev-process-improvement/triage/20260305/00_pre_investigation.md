# トリアージ事前調査: 2026-03-05

## inbox 確認

- [x] 未処理アイテム数：9 件
- [x] 最古アイテムの日付：2026-02-24（ref_ai-driven-development-poc.md）
- [x] 注目すべきアイテム（タイトル列挙）：
  - `backlogの一覧資料とbacklog同士の関連性の可視化.md` — 内容が1行のみ、stub状態
  - `dev-workflow-detail-escalation-l1-refs.md` — ISS-024関連、workflow施策後のL1参照残存報告
  - `related-files-section-横展開.md` — ISS-029関連、triage-manager.mdのパターンを他ルールへ横展開
  - `トリアージのチェック観点となる標準ポリシーやガイドラインの整理.md` — トリアージ標準ポリシーのガイドライン化提案
  - `やらないこと見出し補足文言許容ルールの明文化.md` — role-format-guide次施策候補

### inbox ref_* ポインター確認

| ポインター | refs/ 対応 | 状態 |
|-----------|-----------|------|
| `ref_ai-driven-development-poc.md` | `refs/ai-driven-development-poc/` (14ファイル) | 正常 |
| `ref_openspec-official-summary.md` | `refs/openspec-official-summary.md` | 正常 |
| `ref_ai-functions.md` | `refs/ai-functions/` (3ファイル) | 正常 |
| `ref_個人PCローカル環境構築-手順書.md` | `refs/個人PCローカル環境構築-手順書.md` | 正常 |

- 孤立 refs/ エントリ: なし（全てポインター付き）

## backlog 確認

- [x] 総件数：16 件
- [x] 優先度 🔴（高）：0 件
- [x] 優先度未設定：0 件
- [x] ステータス「候補」のまま放置（30日以上）：0 件（最古は2026-02-25、8日経過）
- [x] 施策化済み候補（initiatives/ または _archive/ に対応施策あり）：0 件
- [x] 特記事項：
  - 全16件が「候補」ステータス。initiative に昇格したものがない
  - 優先度分布: 中7件（43.75%）、低9件（56.25%）
  - 対象リポジトリ分布: ai-driven-dev-patterns 10件、dev-process-improvement 3件、横断 2件、ai-research-notebook 1件

## 課題管理 CSV 確認（プロセス改善_課題管理.csv）

- [x] ステータス「起票」（未対応）：9 件
- [x] ステータス「方針確定」（未タスク化）：1 件（ISS-031）
- [x] 最古の未対応課題：ISS-006（OpenSpec開発ライフサイクル統合）
- [x] 特記事項：
  - 全34件中、クローズ18件、対応済2件、起票9件、方針確定1件、未対応1件
  - ISS-025/ISS-028: 5回以上のトリアージで繰り返し指摘（carry-over問題）
  - ISS-026: gh CLI未インストール（リポジトリ分離のブロッカー）
  - ISS-027: Claude Code Web 単一リポジトリ制約（アーキテクチャ的制限）

## 進行中 initiative 確認

- [x] 進行中：1 件
  - 施策名・フェーズ：`dev-process-improvementリポジトリ分離` — 提案フェーズ（00_proposal.md作成済み）
- [x] ブロック中：1 件（上記と同一）
  - 施策名・理由：ISS-026（gh CLI未インストール）、ISS-027（Claude Code Web 1リポジトリ制約）
- [x] アーカイブ待ち（ゲート通過済み・未移動）：1 件
  - 施策名：`個人PCローカル環境構築`（ゲート通過 2026-03-04、未アーカイブ）

## inbox 気づきエントリ確認

- [x] セッション終了時の気づきエントリ：5 件（ref_* 4件を除く）
- [x] 処理候補のエントリ（タイトル列挙）：
  - `backlogの一覧資料とbacklog同士の関連性の可視化.md` — backlogに統合 or 破棄判断
  - `dev-workflow-detail-escalation-l1-refs.md` — ISS-024後続、backlog候補
  - `related-files-section-横展開.md` — backlog候補（「関連ファイル一覧セクション横展開」と重複の可能性）
  - `トリアージのチェック観点となる標準ポリシーやガイドラインの整理.md` — backlog候補
  - `やらないこと見出し補足文言許容ルールの明文化.md` — role-format-guide次施策に統合

## ルール・workflow 整合性確認（.claude/rules/*.md ↔ docs/workflow.md）

- [x] 乖離あり（以下の内容）：
  1. **CRITICAL**: `docs/workflow.md` のコミットメッセージ例がトリアージを `[triage]` 1種類で表記 → 正しくは `[triage-mgr]` / `[triage-worker]` / `[triage-eval]` の3種類（commit-message.md準拠）
  2. **HIGH**: `docs/workflow.md` のファイル操作権限テーブルでL2-evaluatorのCSV直接書き込みを示唆 → 実際はL2-evaluatorは `07_issues.md` に書き、L1経由でCSV転記
  3. **MEDIUM**: トリアージセッション種別がworkflow.mdでは1行に集約、commit-message.mdでは3行に分離

## 前回トリアージからの変化

- 前回実施日：2026-03-04（20260304-2）
- inbox 増減：不明（前回後に新規追加の可能性あり）
- backlog 増減：前回17件 → 今回16件（変動あり）
- 完了施策：個人PCローカル環境構築（ゲート通過 2026-03-04）
- 新規課題：特になし

## 調査サマリ・今回の重点

- 重点1：**inbox 5件の分類処理** — 非ref_*の5件を backlog候補/却下/統合に分類する
- 重点2：**ルール・workflow 整合性の修正** — commit-message.mdとworkflow.mdのトリアージセッション種別乖離（CRITICAL）を是正する
- 重点3：**carry-over 課題の対処方針** — ISS-025/ISS-028 が5回以上繰り返し。maintenance コミットでの直接対処を検討
- 重点4：**個人PCローカル環境構築のアーカイブ** — ゲート通過済み・未移動のためアーカイブ処理

## ワーカーセット数の推奨

- 推奨セット数：1 セット
- 割り当て方針：
  - inbox 9件（うちref_* 4件は確認のみ）、backlog 16件、前回からの間隔が1日と短い
  - ルール・workflow乖離の修正は軽微（ワーカーのセッション内で対処可能）
  - 全TGタスク（TG-001〜TG-007）を1セットで実施する

---
**調査者**: トリアージマネージャーセッション
**調査日**: 2026-03-05
