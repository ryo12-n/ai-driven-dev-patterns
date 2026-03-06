# スキャンレポート: Set-2

## 担当タスク

| タスクID | 対象 | ステータス |
|---------|------|-----------|
| TG-002 | backlog 16件の棚卸し | 完了 |
| TG-003 | backlog→initiatives 施策化済みチェック | 完了 |
| TG-005 | initiative 状態確認（dev-process-improvementリポジトリ分離） | 完了 |
| TG-006 | backlog 関係性分析 | 完了 |
| TG-008 | セッション構造標準ポリシーチェック | 完了 |

---

## TG-002: backlog 棚卸し

### 棚卸し結果サマリ
- 総数: 16件
- 全件ステータス: 候補（施策化率 0%）
- 優先度分布: 中 7件 / 低 9件
- 起票日範囲: 2026-02-25 〜 2026-03-05
- 対象リポジトリ分布: ai-driven-dev-patterns 9件 / dev-process-improvement 4件 / 横断 1件 / ai-research-notebook 1件 / 不明 1件

### 各アイテム棚卸し結果

| # | 施策名 | 優先度 | 起票日 | 対象リポ | 滞留日数 | 判断 |
|---|--------|--------|--------|---------|---------|------|
| 1 | Claude Code標準skills評価・取り込み | 低 | 03-03 | ai-driven-dev-patterns | 3日 | 維持 |
| 2 | LLMローカル開発のセキュリティ強化 | 低 | 03-03 | 横断 | 3日 | 維持 |
| 3 | ai-driven-dev-patternsの設計プロセス整備 | 中 | 03-03 | ai-driven-dev-patterns | 3日 | 維持 |
| 4 | ai-driven-dev-patternsトリアージプロセスのブラッシュアップ | 中 | 03-04 | ai-driven-dev-patterns | 2日 | 維持 |
| 5 | ai-research-notebookの整備 | 低 | 03-02 | ai-research-notebook | 4日 | 維持（スコープ外だが関連性あり） |
| 6 | claude-directory最適化(ai-driven-dev-patterns) | 中 | 03-05 | ai-driven-dev-patterns | 1日 | 統合検討（#7と） |
| 7 | claude-directory最適化 | 中 | 03-05 | dev-process-improvement | 1日 | 統合検討（#6と） |
| 8 | dev-workflow-detail L1参照精査 | 低 | 03-05 | dev-process-improvement | 1日 | 維持 |
| 9 | sessionsテンプレート間連携ガイド | 低 | 03-04 | ai-driven-dev-patterns | 2日 | 維持 |
| 10 | ハーネスエンジニアリング観点でのブラッシュアップ | 低 | 03-01 | ai-driven-dev-patterns | 5日 | 維持 |
| 11 | マルチAIエージェント共通ルール適用 | 中 | 02-25 | ai-driven-dev-patterns | 9日 | 維持（最古アイテム） |
| 12 | メタ認知による改善の強制 | 低 | 03-04 | ai-driven-dev-patterns | 2日 | 維持 |
| 13 | 全ロールファイルrole-format-guide準拠確認修正 | 低 | 03-04 | ai-driven-dev-patterns | 2日 | 維持 |
| 14 | 北村さんの取り組みを取り込む | 低 | 03-02 | ai-driven-dev-patterns | 4日 | 維持 |
| 15 | 関連ファイル一覧セクション横展開 | 低 | 03-05 | dev-process-improvement | 1日 | 維持 |
| 16 | 高度な並列化と協調プロトコル統合 | 中 | 03-02 | ai-driven-dev-patterns | 4日 | 維持（前提施策完了済み） |

### 優先度妥当性レビュー

- **中→高への昇格候補**: なし。現在進行中の施策（リポジトリ分離）がブロック中のため、新施策の優先度を上げる前にブロック解消が先決
- **低→中への昇格候補**: 「マルチAIエージェント共通ルール適用」（最古アイテム、9日経過）は検討の余地あり
- **削除候補**: なし

### 不整合の発見

- **README.md とファイル実体の不整合**: `backlog/README.md` のテーブルに「triageテンプレートのブラッシュアップ」が記載されているが、対応する `.md` ファイルが `backlog/` に存在しない。リンク先 `./triageテンプレートのブラッシュアップ.md` はデッドリンク

---

## TG-003: 施策化済みチェック

### 突合結果サマリ
- 突合対象: backlog 16件 vs initiatives/ 1件（進行中） + initiatives/_archive/ 33件（完了）
- 施策化済み: 0件
- 削除・クローズ候補: 0件

### 詳細突合結果

| # | backlog アイテム | 類似 initiative | 関係性 | 判定 |
|---|-----------------|----------------|--------|------|
| 1 | 全ロールファイルrole-format-guide準拠確認修正 | _archive/role-format-guide準拠確認チェックリスト | 関連（チェックリスト作成→全ファイル修正）だが別スコープ | 未施策化 |
| 2 | 高度な並列化と協調プロトコル統合 | _archive/git-worktree-parallel-dev | Stage 2完了 → Stage 3（本アイテム） | 未施策化 |
| 3 | ai-driven-dev-patternsトリアージプロセスのブラッシュアップ | _archive/refine-triage-template | テンプレート改善完了 → 追加差分（refs/管理等） | 未施策化 |
| 4 | その他13件 | 該当なし | - | 未施策化 |

### README.md 記載の不在ファイル

- 「triageテンプレートのブラッシュアップ」: README テーブルに記載ありだがファイル不在。_archive/refine-triage-template として施策化済みの可能性が高い。README からの行削除を推奨

---

## TG-005: initiative 状態確認

### 進行中施策一覧

| 施策名 | フェーズ | 状態 | ゲート判定 |
|--------|---------|------|-----------|
| dev-process-improvementリポジトリ分離 | フェーズ1 | 一部ブロック | 未実施（テンプレートのまま） |

### 詳細

**施策: dev-process-improvementリポジトリ分離**

- **タスク進捗**: 15タスク中 10完了 / 3ブロック / 1未着手 / 1完了（固定タスク）
- **ブロック要因**: T-001（`gh repo create` でのGitHubリポジトリ作成）が権限問題でブロック → T-002（コンテンツ移行）、T-003（パス修正）が連鎖ブロック
- **完了済み作業**: 親リポの参照更新（T-004〜T-012）は全て完了。collab-log移設、CLAUDE.md更新、README.md更新、各設計ドキュメント更新が完了
- **残作業**: T-001〜T-003（新リポ作成・コンテンツ移行）、T-013（親リポからのdev-process-improvement/削除）
- **ゲート判定**: 08_gate_review.md はテンプレートのまま。ゲート通過済み未アーカイブの状態ではない

**所見**: ブロック解除にはGitHubリポジトリ作成権限の問題解決が必要。ユーザーによる手動リポジトリ作成または権限付与で解消可能。

---

## TG-006: backlog 関係性分析

### 関係性サマリ
- 重複候補: 2組
- 依存関係: 3組
- 統合候補: 1組

### 重複候補

| # | アイテムA | アイテムB | 重複度 | 説明 |
|---|----------|----------|--------|------|
| 1 | claude-directory最適化(ai-driven-dev-patterns) | claude-directory最適化 | 高（同一テーマ） | 同じ「.claude/ディレクトリ最適化」を対象リポジトリ別に分割。アプローチ（rules→skills移行、コンテキストコスト削減）が共通 |
| 2 | 北村さんの取り組みを取り込む | マルチAIエージェント共通ルール適用 | 低（一部重複） | 北村さんの取り組みにはDevin多段レビューが含まれ、マルチAIエージェントもDevin対応が焦点。ただし全体スコープは異なる |

### 依存関係

| # | 先行アイテム（完了済み） | 後続アイテム（backlog） | 依存内容 |
|---|----------------------|----------------------|---------|
| 1 | _archive/git-worktree-parallel-dev | 高度な並列化と協調プロトコル統合 | Stage 2完了 → Stage 3。前提施策として必要な基盤が整備済み |
| 2 | _archive/role-format-guide準拠確認チェックリスト | 全ロールファイルrole-format-guide準拠確認修正 | チェックリスト完成 → 全ファイルへの適用 |
| 3 | _archive/refine-triage-template | ai-driven-dev-patternsトリアージプロセスのブラッシュアップ | テンプレート改善完了 → 追加機能（refs/管理、collab-log蒸留等） |

### 統合候補

| # | 対象アイテム | 統合案 | 効果 |
|---|------------|--------|------|
| 1 | claude-directory最適化(ai-driven-dev-patterns) + claude-directory最適化(dev-process-improvement) | 「claude-directory最適化（全リポジトリ）」として1施策に統合。フェーズ分けで各リポジトリを順次対応 | アプローチ策定の重複排除。知見の横展開が施策内で完結 |

### backlog 内依存関係（backlog 同士）

| # | アイテムA | アイテムB | 関係 |
|---|----------|----------|------|
| 1 | ai-driven-dev-patternsの設計プロセス整備 | sessionsテンプレート間連携ガイド | 設計プロセス整備の一部としてテンプレート連携を扱える可能性 |
| 2 | ハーネスエンジニアリング観点でのブラッシュアップ | メタ認知による改善の強制 | ハーネス5観点の「検証とガードレール」がメタ認知と関連 |

---

## TG-008: セッション構造標準ポリシーチェック

### 走査結果サマリ
- 走査対象ファイル数: 6件
- 新規・変更 roles/*.md: 0件
- 不適合件数: 3件（必須: 0件 / 推奨: 2件 / 軽微: 1件）

### ファイル別チェック結果

| ファイル | A.ライフサイクル | B.ペアリング | C.課題起票 | D.停止ルール | 総合判定 |
|---------|:-------------:|:----------:|:--------:|:----------:|:-------:|
| l1-manager/SKILL.md | OK | OK | OK | OK | OK |
| l1-manager/agents/l2-worker.md | OK | OK | OK | OK | OK |
| l1-manager/agents/l2-evaluator.md | OK | OK | OK | OK | OK |
| triage-manager/SKILL.md | OK | OK | OK | OK | OK |
| triage-manager/agents/triage-worker.md | NG(推奨) | OK | NG(推奨) | OK | NG |
| triage-manager/agents/triage-evaluator.md | OK | OK | OK(注) | OK | OK(注) |

### 不適合の詳細

| # | ファイル | チェック項目 | 不適合内容 | 重大度 | 対応方針 |
|---|---------|------------|----------|--------|---------|
| 1 | triage-worker.md | C. 知見記録セクション | スキャンレポートテンプレートに「判断・気づき」セクションはあるが、「ルール化候補」「参考情報」の分類テーブルが定義されていない。ガイドライン1.2で triage-worker の気づき記録は「必須」 | 推奨 | 07_issues.md に起票 |
| 2 | triage-evaluator.md | A. 気づき記録 | 06_eval_report.md テンプレートに「評価中の知見」（ルール化候補/参考情報）テーブルは存在するが、ロール定義の「やること」セクションで知見記録への言及が弱い。ガイドライン1.2で triage-evaluator の気づき記録は「推奨」 | 推奨 | 07_issues.md に起票 |
| 3 | triage-evaluator.md | D. 担当ファイルテーブル | 02_scan_plan.md（ワーカーの壁打ち・計画ファイル）が担当ファイルテーブルの読み取り対象に含まれていない。評価時にワーカーの計画を確認する際に参照する可能性がある | 軽微 | セッション内修正候補 |

### チェック項目別詳細

#### A. ライフサイクル完備チェック

| ファイル | ロール種別 | 壁打ち | 計画 | 作業履歴 | 課題起票 | 気づき記録 | レポート | 評価 | ゲート | 知見ルーティング |
|---------|----------|--------|------|---------|---------|-----------|---------|------|--------|---------------|
| l1-manager | マネージャー | OK（フェーズ0） | OK（フェーズA） | N/A | 条件付きOK | N/A | N/A | N/A | OK（フェーズB） | OK（クローズ手順） |
| l2-worker | ワーカー | OK（壁打ちフェーズ） | OK（実施計画） | OK（タイムスタンプ付き） | OK（07_issues.md） | OK（04知見セクション） | OK（04_work_report.md） | N/A | N/A | N/A |
| l2-evaluator | 評価者 | OK（壁打ちフェーズ） | OK（評価計画） | N/A | OK（07_issues.md） | OK（06知見セクション） | OK（06_eval_report.md） | OK | N/A | N/A |
| triage-manager | マネージャー | OK（事前調査） | OK（01_plan.md） | N/A | OK（CSV転記） | N/A | OK（03_report.md） | N/A | 条件付きOK | OK（知見集約手順） |
| triage-worker | ワーカー | OK（02_scan_plan.md） | N/A（受領側） | OK（タイムスタンプ付き） | OK（07_issues.md） | **NG**（分類テーブル未定義） | OK（04_scan_report.md） | N/A | N/A | N/A |
| triage-evaluator | 評価者 | OK（05_eval_plan.md） | N/A（受領側） | N/A | OK（07_issues.md） | OK（テンプレートに存在、言及弱） | OK（06_eval_report.md） | OK | N/A | N/A |

#### B. ペアリング整合性チェック

| ペア | ペア存在 | 成果物チェーン | 対称性 | 起動順序 |
|------|---------|-------------|--------|---------|
| l2-worker ↔ l2-evaluator | OK | OK（04→評価者の担当ファイルに記載） | OK | OK（l1-manager に明記） |
| triage-worker ↔ triage-evaluator | OK | OK（04→評価者の担当ファイルに記載） | OK（注: 知見記録の詳細度に差あり） | OK（triage-manager に明記） |

#### C. 課題起票・ルーティングチェック

| ファイル | 課題起票方法 | 知見記録セクション | 知見集約ルーティング |
|---------|------------|-----------------|-----------------|
| l1-manager | OK（07_issues.md→CSV、クローズチェックリスト） | N/A | OK（ルーティング判断基準テーブル） |
| l2-worker | OK（07_issues.md→CSV転記手順明記） | OK（04_work_report.md知見セクション） | N/A |
| l2-evaluator | OK（07_issues.md→CSV転記手順明記） | OK（06_eval_report.md知見セクション） | N/A |
| triage-manager | OK（07_issues.md集約→CSV転記） | N/A | OK（知見集約手順セクション） |
| triage-worker | OK（07_issues.md経由、CSV直接起票禁止明記） | **NG**（分類テーブル未定義） | N/A |
| triage-evaluator | OK（07_issues.md経由、CSV直接起票禁止明記） | OK（06テンプレートに存在） | N/A |

#### D. 停止ルール・スコープチェック

| ファイル | やること | やらないこと | 停止ルール | 担当ファイルテーブル |
|---------|---------|------------|-----------|------------------|
| l1-manager | OK | OK | N/A（マネージャー） | N/A（暗黙だが明確） |
| l2-worker | OK | OK | OK（フォーマット明記） | OK |
| l2-evaluator | OK | OK | OK（フォーマット明記） | OK |
| triage-manager | OK | OK | N/A（マネージャー） | OK |
| triage-worker | OK | OK | OK（フォーマット明記） | OK |
| triage-evaluator | OK | OK | OK（フォーマット明記） | OK（注: 02_scan_plan.md 未記載） |

---

## 課題起票

- 起票件数: 3件（`07_issues.md` に起票済み）
  - [ISS-W2-001] backlog/README.md とファイル実体の不整合（triageテンプレートのブラッシュアップ）
  - [ISS-W2-002] triage-worker.md の知見記録セクションに分類テーブル未定義
  - [ISS-W2-003] triage-evaluator.md の知見記録言及が弱い・担当ファイルに02_scan_plan.md未記載

## 判断・気づき

- **backlog の施策化率が0%**: 全16件が候補のまま。進行中施策（リポジトリ分離）のブロック解消後に、優先度「中」のアイテムから施策化を開始するのが妥当
- **claude-directory最適化2件の統合**: 同一テーマ・同一アプローチのため、統合して1施策にすることを推奨。フェーズ分けで各リポジトリを順次対応
- **トリアージ系ロール定義の知見記録**: L1/L2系と比較してトリアージ系の知見記録の仕組みが弱い。triage-worker のスキャンレポートテンプレートに「ルール化候補」「参考情報」分類テーブルを追加することで改善可能
- **リポジトリ分離施策のブロック**: ユーザーによる手動リポジトリ作成または権限付与でブロック解消可能。早期解消を推奨
- **README.md 不整合**: 「triageテンプレートのブラッシュアップ」ファイルが不在。_archive/refine-triage-template として既に施策化済みの可能性が高く、README.md から該当行を削除すべき

---
**作成者**: トリアージワーカー
**作成日**: 2026-03-06
