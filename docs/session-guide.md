# セッションガイド

`/dispatcher` の使い方と各シナリオの詳細フローを説明する補足ドキュメント。

> 設計書レベルの詳細は [docs/design/session-operation-flow.md](design/session-operation-flow.md) を参照。

---

## /dispatcher の使い方

### 基本的な使い方

Claude Code の対話画面で `/dispatcher` と入力し、続けて自然言語でタスクを伝える。

```
/dispatcher <やりたいことを自然言語で記述>
```

dispatcher は入力を解析し、以下の情報を構造化して dev_manager に渡す:

- **シナリオ番号・名称**: 5シナリオのいずれか
- **目的**: ユーザー入力から抽出した1行サマリー
- **対象**: 対象ファイル・モジュール・参照ドキュメント
- **制約**: セキュリティ要件・パフォーマンス要件・テストカバレッジ要件など
- **元のユーザー入力**: 原文をそのまま保持

### プロンプト作成のコツ

- **「何を」「どの範囲で」「制約は何か」を含める**: 具体的なほど正確にシナリオ分類される
- **設計書が既にある場合はパスを明示する**: `docs/design/xxx.md に基づいて実装して` のように指定
- **制約を明示する**: 「機能変更なし」「テストも書いて」「セキュリティ観点で」など
- **曖昧な場合は dispatcher が確認してくる**: 分類できない入力には追加質問が返される

---

## シナリオ別 詳細フロー

### シナリオ1: 要件定義〜設計

**起動ロール**: documentarian → reviewer

**いつ使うか**: 要件がまだ言語化されていない、設計ドキュメントの作成が必要な場合。

**フロー**:

1. dev_manager がタスクを分析し、documentarian を起動
2. documentarian が要件を整理し、設計書を `docs/design/` に作成
3. reviewer が設計レビューを実施（カバレッジ・整合性・実現可能性の3点）
4. レビュー指摘があれば documentarian が修正

**プロンプト例**:

```
/dispatcher ユーザープロフィール機能を設計したい。要件を整理して設計書を作成して。
/dispatcher 認証基盤のアーキテクチャを検討したい。OAuth と JWT のどちらが適切か設計書にまとめて。
/dispatcher 通知システムを新規に作りたい。要件定義から始めたい。
```

**主な成果物**: `docs/design/` 配下の設計書

---

### シナリオ2: 実施計画〜開発実施

**起動ロール**: feature_builder, test_writer, reviewer, (bug_fixer), (documentarian)

**いつ使うか**: 要件・設計が存在し、コードの実装が必要な場合。

**フロー**:

1. dev_manager がタスクを分析し、実施計画を策定
2. test_writer がテストを先行作成（TDD 分離が有効な場合）
3. feature_builder がコードを実装
4. reviewer がコードレビューを実施（セキュリティ・バグリスク・設計・パフォーマンス・可読性の5観点）
5. レビュー指摘があれば feature_builder または bug_fixer が修正
6. 最大3回のレビューイテレーション

**プロンプト例**:

```
/dispatcher ユーザー認証機能を実装して。JWT を使い、ログイン・ログアウト・トークン検証の3エンドポイントを作る。
/dispatcher docs/design/user-profile.md に基づいてプロフィール機能を実装して。テストも書いて。
/dispatcher Issue #42 の機能を実装して。設計書は docs/design/notification.md を参照。
/dispatcher src/api/users.ts に CRUD エンドポイントを追加して。バリデーションとエラーハンドリングも含めて。
```

**主な成果物**: `src/` 配下の実装コード、`tests/` 配下のテスト

---

### シナリオ3: 独立評価

**起動ロール**: reviewer（独立コンテキスト）

**いつ使うか**: 既存のコード・成果物に対する客観的な品質評価が目的の場合。開発セッションとは独立したコンテキストで実施される。

**フロー**:

1. dev_manager が reviewer を独立コンテキストで起動
2. reviewer が5点評価フレームワークで評価（セキュリティ・設計・テスト・パフォーマンス・保守性）
3. 評価レポートをセッション記録に出力

**プロンプト例**:

```
/dispatcher 直近のコミットをレビューしてほしい。セキュリティと設計の観点で評価して。
/dispatcher src/auth/ 以下のコードを品質監査して。OWASP Top 10 の観点で。
/dispatcher リリース前チェックをして。本番環境に出して問題ないか確認して。
```

**主な成果物**: 評価レポート（セッション記録内）

---

### シナリオ4: ドキュメント整合性

**起動ロール**: documentarian → reviewer

**いつ使うか**: 既存ドキュメントと実態（コード・設計・運用）の乖離を検知し、整合させることが目的の場合。

**フロー**:

1. dev_manager が documentarian を起動
2. documentarian が5種類の整合性チェックを実施:
   - コード ↔ 設計書
   - コード ↔ README
   - 設計書 ↔ 運用手順
   - ロール定義 ↔ 運用フロー
   - CHANGELOG ↔ git 履歴
3. 乖離を検出し、ドキュメントを更新
4. reviewer がドキュメントレビューを実施

**プロンプト例**:

```
/dispatcher docs/ を最新のコードに合わせて更新して。
/dispatcher 設計書とコードの整合性を確認して。乖離があれば設計書を修正して。
/dispatcher README を最新化して。新しく追加した機能が反映されていない。
```

**主な成果物**: 更新されたドキュメント

---

### シナリオ5: リファクタリング・最適化

**起動ロール**: refactorer / optimizer, test_writer, reviewer

**いつ使うか**: 機能変更を伴わないコード品質改善またはパフォーマンス最適化が目的の場合。

**フロー**:

1. dev_manager がタスクを分析
2. テストカバレッジが 70% 未満の場合、test_writer がセーフティネットテストを先行作成
3. refactorer / optimizer がコード改善を実施
4. reviewer が品質ゲートを確認（振る舞い不変 + 品質向上の2点）

**プロンプト例**:

```
/dispatcher src/api/ 以下のコードが重複している。DRY 化してほしい。機能変更は不要。
/dispatcher データベースクエリのパフォーマンスを改善して。N+1 問題がある。
/dispatcher src/utils/ の関数群を整理して。責務が混在している。
/dispatcher ビルド時間を短縮したい。現在3分かかっている。
```

**主な成果物**: リファクタリング済みコード、パフォーマンス計測結果

---

## 専門ロール詳細

| ロール | 役割 | 詳細定義 |
|--------|------|---------|
| `dev_manager` | 最上位オーケストレーター。コードは書かず、タスク分配・判断・コンテキスト中継・セッション管理を担当 | [roles/dev_manager.md](../roles/dev_manager.md) |
| `feature_builder` | 新機能の実装を担当。タスク指示から機能実装タスクを選び、テストが通るまで実装を繰り返す | [roles/feature_builder.md](../roles/feature_builder.md) |
| `test_writer` | テストカバレッジの拡充、エッジケースの発見、テストの品質改善を担当 | [roles/test_writer.md](../roles/test_writer.md) |
| `reviewer` | 直近のコミットを監視し、設計問題・バグリスク・改善点を発見してタスクとして起票 | [roles/reviewer.md](../roles/reviewer.md) |
| `bug_fixer` | 失敗テスト・既知バグの修正を担当。最小差分での修正を心がけ、既存機能を壊さない | [roles/bug_fixer.md](../roles/bug_fixer.md) |
| `documentarian` | README、CHANGELOG、設計書、進捗サマリーなどのドキュメントを整備 | [roles/documentarian.md](../roles/documentarian.md) |
| `refactorer` | 重複コードの統合、設計改善、DRY化。振る舞いを変えずにコード品質を改善する | [roles/refactorer.md](../roles/refactorer.md) |
| `optimizer` | パフォーマンス改善、ビルド高速化、出力品質の向上。計測→改善→計測のサイクルを回す | [roles/optimizer.md](../roles/optimizer.md) |
| `openspec_specialist` | OpenSpec の仕様ライフサイクル全体を担当。仕様の作成・更新・検証・アーカイブを行う | [roles/openspec_specialist.md](../roles/openspec_specialist.md) |

---

## セッション記録の見方

すべてのセッションは `sessions/` ディレクトリに記録される。

```
sessions/
└── <session-type>_<task-name>/
    ├── plan.md          # 実施計画（dev_manager が作成）
    ├── log.md           # 作業ログ（各ロールが追記）
    ├── report.md        # 完了レポート
    └── issues.md        # 発見した課題・改善点
```

- **plan.md**: dev_manager が作成するタスク分割・ロール起動計画
- **log.md**: 各専門ロールが作業の進捗・判断・結果を時系列で追記
- **report.md**: セッション完了時のサマリーと成果物一覧
- **issues.md**: セッション中に発見した課題・改善提案

---

## 関連ドキュメント

| ドキュメント | 内容 |
|------------|------|
| [docs/design/session-operation-flow.md](design/session-operation-flow.md) | セッション運用フロー設計書（ハブ） |
| [docs/design/session-flow-scenarios.md](design/session-flow-scenarios.md) | 5シナリオ詳細設計（シーケンス図含む） |
| [docs/design/session-flow-foundations.md](design/session-flow-foundations.md) | ライフサイクルモデル・dispatcher 仕様 |
| [docs/design/session-flow-advanced.md](design/session-flow-advanced.md) | 横断的関心事・統合マッピング |
| [docs/dev-setup.md](dev-setup.md) | 環境構築ガイド |
