# スキャンレポート: Set-1

## 担当タスク

| タスクID | 対象 | ステータス |
|---------|------|-----------|
| TG-001 | inbox | 完了 |
| TG-002 | backlog | 完了 |
| TG-003 | CSV | 完了 |
| TG-004 | initiative | 完了 |
| TG-005 | backlog関係性 | 完了 |
| TG-006 | refs/ | 完了 |
| TG-007 | rules/workflow | 完了 |

---

## TG-001: inbox 走査・分類

### 非ref_* アイテム分類結果

| ファイル名 | 分類 | 理由 |
|-----------|------|------|
| `backlogの一覧資料とbacklog同士の関連性の可視化.md` | 対応不要 | 内容1行のstub。TG-005の関係性分析で一部カバー。具体的提案なし |
| `dev-workflow-detail-escalation-l1-refs.md` | **backlog候補** | ISS-024関連。L1参照の残存箇所と検討ポイントが明記済み。施策化可能 |
| `related-files-section-横展開.md` | **backlog候補** | ISS-029関連。triage-manager.mdの関連ファイル一覧パターンを他ルールへ横展開 |
| `やらないこと見出し補足文言許容ルールの明文化.md` | 既存backlogに統合 | 「全ロールファイルrole-format-guide準拠確認修正」のスコープに含まれる |
| `トリアージのチェック観点となる標準ポリシーやガイドラインの整理.md` | **backlog候補** | トリアージ品質基準のガイドライン化提案。プロセス品質向上に直結 |

### ref_* ポインター整合性

| ポインター | refs/ 対応 | 状態 |
|-----------|-----------|------|
| ref_ai-driven-development-poc.md | refs/ai-driven-development-poc/ | 整合OK |
| ref_ai-functions.md | refs/ai-functions/ | 整合OK |
| ref_openspec-official-summary.md | refs/openspec-official-summary.md | 整合OK |
| ref_個人PCローカル環境構築-手順書.md | refs/個人PCローカル環境構築-手順書.md | 整合OK |

### inbox 処理後のアクション提案

- **削除対象**: `backlogの一覧資料と〜`（対応不要）、`やらないこと見出し〜`（backlog統合済み）
- **backlog新規追加対象**: `dev-workflow-detail-escalation-l1-refs.md`、`related-files-section-横展開.md`、`トリアージのチェック観点〜`
- **ref_* は継続保持**（削除不要）

---

## TG-002: backlog 棚卸し

### 施策化済みチェック

| backlog ファイル | 優先度 | 判断 |
|----------------|--------|------|
| Claude Code標準skills評価・取り込み | 低 | 継続保持 |
| LLMローカル開発のセキュリティ強化 | 低 | 継続保持 |
| ai-driven-dev-patternsのREADME整備 | 中 | **要確認**: _archive/readme-improvement との関係 |
| ai-driven-dev-patternsの設計プロセス整備 | 中 | 継続保持 |
| ai-driven-dev-patternsトリアージプロセスのブラッシュアップ | 中 | 継続保持 |
| ai-research-notebookの整備 | 低 | 継続保持（外部リポジトリ） |
| sessionsテンプレート間連携ガイド | 低 | 継続保持 |
| トリアージのマネージャー・ワーカー構成化 | 中 | **削除・クローズ候補**: 現行3分割構成（mgr/worker/eval）で実質達成済み |
| ハーネスエンジニアリング観点でのブラッシュアップ | 低 | 継続保持 |
| マルチAIエージェント共通ルール適用 | 中 | 継続保持 |
| メタ認知による改善の強制 | 低 | 継続保持 |
| 並列開発の仕組み実装 | 中 | **要確認**: Stage 2完了済み、残スコープの見直しが必要 |
| 全ロールファイルrole-format-guide準拠確認修正 | 低 | 継続保持 |
| 北村さんの取り組みを取り込む | 低 | 継続保持 |
| 高度な並列化と協調プロトコル統合 | 中 | 継続保持（Stage 3） |
| 関連ファイル一覧セクション横展開 | 低 | 継続保持 |

### 削除・クローズ候補

| backlog ファイル | 理由 |
|----------------|------|
| トリアージのマネージャー・ワーカー構成化 | triage-manager.md + triage-worker.md + triage-evaluator.md の3分割構成で目的が達成済み |

### 優先度変更候補

- 特になし（現状の優先度分布は妥当）

---

## TG-003: CSV 未対応課題の対応方針

| ID | タイトル | ステータス | 対応方針案 |
|----|---------|-----------|-----------|
| ISS-006 | OpenSpec開発ライフサイクル統合 | 未対応 | 継続保留。「設計プロセス整備」施策開始時に併せて対処 |
| ISS-013 | Agent Teams機能がworktreeガイドラインで未言及 | 起票 | 低優先度で継続。「高度な並列化」施策で対応 |
| ISS-016 | m6o-es-product-api ルール整備 | 起票 | 施策化可能。backlog候補として提案 |
| ISS-017 | settings.json の充実 | 起票 | 短期施策化推奨。ISS-018と合わせて対応 |
| ISS-018 | rules/ の paths活用 | 起票 | ISS-017と合わせて短期施策化推奨 |
| ISS-019 | claude-directory-guide.md の skills/ 移動 | 起票 | 低優先度で継続 |
| ISS-020 | config.yaml tasks ルール適合性 | 起票 | 低優先度。openspec施策で対応 |
| ISS-021 | spec 作成時エッジケース漏れ | 起票 | 低優先度。openspec改善時に対応 |
| ISS-022 | spec 作成フェーズのボトルネック | 起票 | 中優先度。openspec活用改善で対応 |
| ISS-031 | inbox/backlog 二重構造 | 方針確定 | ステータス維持（二重構造を許容） |
| ISS-032 | CSVステータス同期漏れ | 起票 | 低優先度。トリアージルール改善で対応 |
| ISS-033 | 成功基準とCSV対応方針案のスコープ整合 | 起票 | 低優先度。l1-managerガイドに追記検討 |

### carry-over 問題

- ISS-025/ISS-028: 前回トリアージ（20260304）で maintenance コミットにより対処済み。carry-over 問題は解消

---

## TG-004: initiative 状態確認

| 施策名 | 状態 | 詳細 |
|--------|------|------|
| dev-process-improvementリポジトリ分離 | 進行中（ブロック中） | T-001〜T-003 が ISS-026/ISS-027 でブロック。ローカル環境では再開可能の見込み |
| 個人PCローカル環境構築 | **ゲート通過済み・未アーカイブ** | 08_gate_review.md で「通過」判定（2026-03-04）。アーカイブ対象 |

### アーカイブ対象

- `個人PCローカル環境構築` → `initiatives/_archive/` への移動を推奨

---

## TG-005: backlog 関係性分析

| 関係種別 | アイテムA | アイテムB | 詳細 |
|---------|----------|----------|------|
| 依存 | 並列開発の仕組み実装 | 高度な並列化と協調プロトコル統合 | Stage 2 → Stage 3 の段階的関係 |
| 統合候補 | 並列開発の仕組み実装 | 高度な並列化と協調プロトコル統合 | 残スコープが小さければ統合可能 |
| 関連 | マルチAIエージェント共通ルール適用 | 北村さんの取り組みを取り込む | マルチAI対応。知見入力の関係 |
| 重複候補 | トリアージのマネージャー・ワーカー構成化 | （現行実装） | 実質達成済み |
| 依存 | ai-driven-dev-patternsの設計プロセス整備 | ai-driven-dev-patternsのREADME整備 | 設計プロセスが先の方が効果的 |
| 関連 | ハーネスエンジニアリング | メタ認知による改善の強制 | 品質改善観点で重なる部分あり |
| 関連 | ai-driven-dev-patternsトリアージプロセスBU | トリアージのマネージャー・ワーカー構成化 | 前者が上位概念 |

### 推奨実施順序

1. 設計プロセス整備 → README整備（依存関係）
2. 並列開発の仕組み実装 → 高度な並列化（段階的関係）
3. 北村さんの取り組み → マルチAI共通ルール（知見入力）

---

## TG-006: refs/ 孤立エントリ確認

| refs/ エントリ | inbox/ref_* | 状態 |
|---------------|-------------|------|
| refs/ai-driven-development-poc/ | inbox/ref_ai-driven-development-poc.md | 整合OK |
| refs/ai-functions/ | inbox/ref_ai-functions.md | 整合OK |
| refs/openspec-official-summary.md | inbox/ref_openspec-official-summary.md | 整合OK |
| refs/個人PCローカル環境構築-手順書.md | inbox/ref_個人PCローカル環境構築-手順書.md | 整合OK |

- 孤立エントリ: **0件**

---

## TG-007: rules/workflow 整合性チェック

### 検出された乖離

| # | 重要度 | 内容 | 修正方針 |
|---|--------|------|---------|
| 1 | CRITICAL | workflow.md のトリアージ commit prefix が `[triage]` 1種類 → commit-message.md では `[triage-mgr/worker/eval]` 3種類 | workflow.md 該当行を3行に分割 |
| 2 | 検証結果: 乖離なし | L2-evaluator の CSV 直接書き込み → 実際は l2-evaluator.md と workflow.md 両方で「施策をまたぐものを CSV 転記」と記載 | 修正不要 |
| 3 | MEDIUM | workflow.md のトリアージ session-type が1行に集約 | 乖離1と同一。workflow.md 更新で解消 |

### 修正の推奨

- **実質的な乖離は1件**（workflow.md のトリアージ commit prefix / session-type）
- 修正は軽微。トリアージセッション内で即時修正可能
- Source of Truth は .claude/rules/*.md であり、workflow.md を合わせる方向で修正

---

## 課題起票

- 起票件数: 0 件
- 新規の課題は発見されなかった。既存CSVの対応方針更新のみ

## 判断・気づき

- backlog 全16件が「候補」のまま8日以上経過。initiative 開始の判断が必要
- 「トリアージのマネージャー・ワーカー構成化」は実質達成済みのため削除推奨
- ISS-017 + ISS-018 の短期施策化を推奨
- workflow.md のトリアージ commit prefix 乖離は早急に修正すべき
- 「個人PCローカル環境構築」のアーカイブを早期に実施すべき

---
**作成者**: トリアージワーカー
**作成日**: 2026-03-05
