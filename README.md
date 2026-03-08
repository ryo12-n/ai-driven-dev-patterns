# ai-driven-dev-patterns

Claude Code + OpenSpec を前提とした、**AIマルチエージェントによる仕様駆動開発**のリポジトリ構成テンプレートです。

> **疑似フォーク運用について**: 社内 Enterprise への取り込みは GitHub フォーク機能を使わず、upstream/origin の2リモート管理方式を推奨。詳細は [docs/sync-guide.md](docs/sync-guide.md) を参照。

---

## このリポジトリでできること

- `/dispatcher` スキルで開発タスクを投げると、AI が自動でシナリオ分類 → 計画策定 → 専門ロール起動を行う
- 新機能実装・バグ修正・レビュー・リファクタリング・ドキュメント整備の 5 シナリオに対応
- OpenSpec による仕様駆動開発（仕様 → 実装 → 検証のサイクル）が組み込まれている
- すべてのセッションは `sessions/` に記録され、再現性と引き継ぎが可能

---

## クイックスタート

### 前提

- Claude Code CLI がインストール済みであること
- 詳細な環境構築は [docs/dev-setup.md](docs/dev-setup.md) を参照

### セッションの起動

```
/dispatcher
```

`/dispatcher` はセッションのエントリーポイントです。自然言語でタスクを伝えると、5 シナリオに分類して `dev_manager` を起動します。

**プロンプト例（コピーして使えます）**

```
# 新機能を実装したい
/dispatcher ユーザー認証機能を追加したい。JWT を使い、ログイン・ログアウト・トークン検証の3エンドポイントを実装する。

# コードをリファクタリングしたい
/dispatcher src/api/ 以下のコードが重複している。DRY 化してほしい。機能変更は不要。

# コードレビューをしたい
/dispatcher 直近のコミットをレビューしてほしい。セキュリティと設計の観点で評価して。
```

---

## セッションシステム概要

```
人間
 ↓ 自然言語でタスクを入力
/dispatcher  ← エントリーポイント（シナリオ分類・コンテキスト構築）
 ↓
dev_manager  ← オーケストレーター（計画策定・ロール起動・フェーズゲート判定）
 ↓
専門ロール   ← 実作業（コード実装・テスト・レビュー等）
 ↓
sessions/   ← セッション記録（plan / log / report / issues）
```

### 5 シナリオ

| # | シナリオ | いつ使う |
|---|---------|---------|
| 1 | 要件定義〜設計 | 「〜を作りたい」「仕様を決めたい」 |
| 2 | 実施計画〜開発実施 | 「〜を実装して」「機能追加して」 |
| 3 | 独立評価 | 「レビューして」「品質確認して」 |
| 4 | ドキュメント整合性 | 「README を更新して」「設計書とコードの整合性を確認して」 |
| 5 | リファクタリング・最適化 | 「リファクタリングして」「パフォーマンス改善して」 |

---

## セッションカタログ

| シナリオ | 使用ロール | 起動プロンプト例 |
|---------|-----------|----------------|
| 要件定義〜設計 | documentarian, reviewer | `/dispatcher ○○機能を設計したい。要件を整理して設計書を作って。` |
| 実施計画〜開発 | feature_builder, test_writer, reviewer, (bug_fixer) | `/dispatcher ○○を実装して。テストも書いて。` |
| 独立評価 | reviewer | `/dispatcher 直近の実装をセキュリティ観点でレビューして。` |
| ドキュメント整合性 | documentarian, reviewer | `/dispatcher docs/ を最新のコードに合わせて更新して。` |
| リファクタリング | refactorer, optimizer, test_writer, reviewer | `/dispatcher src/○○ を機能変更なしでリファクタリングして。` |

詳細なシナリオフローとプロンプト例は [docs/session-guide.md](docs/session-guide.md) を参照。

---

## 専門ロール一覧

| ロール | 役割 | 定義 |
|--------|------|------|
| `dev_manager` | オーケストレーター。ロール起動・計画・フェーズゲート | [.claude/skills/dispatcher/SKILL.md](.claude/skills/dispatcher/SKILL.md) |
| `feature_builder` | 新機能の実装 | [.claude/agents/feature-builder.md](.claude/agents/feature-builder.md) |
| `test_writer` | テストカバレッジ拡充・エッジケース発見 | [.claude/agents/test-writer.md](.claude/agents/test-writer.md) |
| `reviewer` | コードレビュー・設計評価・品質確認 | [.claude/agents/reviewer.md](.claude/agents/reviewer.md) |
| `bug_fixer` | バグ修正（最小差分） | [.claude/agents/bug-fixer.md](.claude/agents/bug-fixer.md) |
| `documentarian` | README・設計書・CHANGELOG 整備 | [.claude/agents/documentarian.md](.claude/agents/documentarian.md) |
| `refactorer` | リファクタリング・DRY 化 | [.claude/agents/refactorer.md](.claude/agents/refactorer.md) |
| `optimizer` | パフォーマンス改善・最適化 | [.claude/agents/optimizer.md](.claude/agents/optimizer.md) |
| `openspec_specialist` | OpenSpec 仕様ライフサイクル管理 | [.claude/agents/openspec-specialist.md](.claude/agents/openspec-specialist.md) |

---

## OpenSpec 開発フロー（仕様駆動）

```
1. /opsx:new <feature>   → openspec/changes/<feature>/ を作成
2. /opsx:continue × 4   → proposal → specs → design → tasks を生成
3. /opsx:apply           → tasks.md に従い src/ を実装
4. /opsx:archive         → delta を openspec/specs/ にマージ
5. openspec/specs/       → 常に最新仕様の Single Source of Truth
```

> コマンドとスキルは `openspec init --tools claude` で `.claude/` 以下に自動生成される。

---

## ドキュメントマップ

| 知りたいこと | 参照先 | 読者 |
|------------|--------|------|
| 環境構築 | [docs/dev-setup.md](docs/dev-setup.md) | 人間 |
| セッション詳細・プロンプト例集 | [docs/session-guide.md](docs/session-guide.md) | 人間 |
| 各ロールの詳細定義 | [.claude/agents/](.claude/agents/) | 人間 |
| セッションフロー設計書 | [docs/design/session-operation-flow.md](docs/design/session-operation-flow.md) | 人間 |
| upstream 同期手順 | [docs/sync-guide.md](docs/sync-guide.md) | 人間 |
| Claude Code ディレクトリ構成 | [.claude/rules/claude-directory-guide.md](.claude/rules/claude-directory-guide.md) | Claude（常時） |
| トリアージポリシー | [.claude/skills/triage/](.claude/skills/triage/) | Claude（オンデマンド） |

### 文書分類ポリシー

本リポジトリではドキュメントの読者（人間 or Claude）を明確に区別し、配置先を分けている。

| 分類 | 配置先 | 説明 |
|------|--------|------|
| 人間用 | `docs/`, `README.md` | 設計書・ガイドライン・運用手順 |
| Claude 常時参照 | `.claude/rules/` | 毎リクエストで自動読み込み。コーディング規約・禁止事項など |
| Claude オンデマンド参照 | `.claude/skills/` | 特定タスク実行時のみ読み込み。ワークフロー手順・ポリシー詳細など |
| Claude 専門ワーカー | `.claude/agents/` | 独立コンテキストで動作。専門レビュワー等 |

詳細は [CLAUDE.md](CLAUDE.md) の「文書分類ポリシー」セクションを参照。

---

## セットアップ

```bash
bash scripts/setup.sh
```

詳細は [docs/dev-setup.md](docs/dev-setup.md) を参照。
