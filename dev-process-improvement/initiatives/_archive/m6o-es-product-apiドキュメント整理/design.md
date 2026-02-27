# 設計書: m6o-es-product-api ドキュメント整理

**作成者**: L2-worker
**作成日**: 2026-02-27
**ステータス**: 完成

---

## 1. 概要

本ドキュメントは `m6o-es-product-api` リポジトリの `my_work/` 配下ファイルの棚卸し・分類・新ディレクトリ構造設計・移動先マッピング表をまとめた設計成果物である。

実際のファイル移動は後続施策で実施する。本施策はマッピング設計のみを行う。

---

## 2. 分類基準

### 2.1 区分定義

| 区分 | 定義 | 配置先 |
|------|------|--------|
| AI 用 | 主な利用者が AI（Claude）。コンテキストとして自動参照される、または AI が実行するファイル | `.claude/rules/`、`.claude/tools/` |
| 人間用 | 主な利用者が人間。設計書・ガイド・プロセス文書など、人間が参照・編集するドキュメント | `docs/` |
| 参考資料 | 過去実績・参考情報。現役の設計書でも AI 用でもなく、アーカイブ・履歴として保持するもの | `refs/` |

### 2.2 判断軸

- **第1軸**: 主な利用者が AI か人間か
- **第2軸**: 迷う場合は AI 用に倒す（`00_proposal.md` の方針）
- **PoC 実装メモリバンク**: AI が過去実装時に参照したコンテキストファイル群。現役の設計書ではないため **参考資料** に分類する（`00_proposal.md` の壁打ち背景に記載）
- **プロセス改善/tools/ シェルスクリプト**: Claude が実行するため **AI 用** に分類する

---

## 3. ファイル棚卸し一覧と分類

対象ディレクトリ: `/m6o-es-product-api/my_work/`（ファイル数: 73 ファイル + 1 .gitkeep）

### 3.1 README

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/README.md` | `my_work/` のディレクトリ構成・主要ドキュメントへのリンク集 | 人間用 |

### 3.2 アプリ設計

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/アプリ設計/PoCアプリ設計書_本番アプリ設計書_差分整理.md` | PoC と本番アプリ設計書の差分比較ドキュメント | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoCアプリ設計/product_image_app_arch.md` | PoC アプリアーキテクチャ設計書（初版） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoCアプリ設計/product_image_app_arch_brushup.md` | PoC アプリアーキテクチャ設計書（改善版） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/activeContext.md` | PoC 実装時の現在コンテキスト（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/api-specification.md` | PoC 実装時の API 仕様（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/issueArchive.md` | PoC 実装時の課題アーカイブ（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/productContext.md` | PoC 実装時のプロダクトコンテキスト（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/progress.md` | PoC 実装時の進捗記録（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/projectbrief.md` | PoC 実装時のプロジェクト概要（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/systemPatterns.md` | PoC 実装時のシステムパターン（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/techContext.md` | PoC 実装時の技術コンテキスト（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/test-specification.md` | PoC 実装時のテスト仕様（AI メモリバンク） | 参考資料 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/01_概要.md` | 商品画像一覧取得機能 アプリ設計書（概要） | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/02_サーバーロジック設計.md` | 商品画像一覧取得機能 サーバーロジック設計 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/03_クライアントロジック設計.md` | 商品画像一覧取得機能 クライアントロジック設計 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/04_段階リリース設計.md` | 段階リリース（フィーチャーフラグ等）の設計 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/05_切り戻し設計.md` | 切り戻し手順の設計 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/06_単体テスト実装方針.md` | 単体テスト実装方針 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/ADR.md` | アーキテクチャ決定記録 | 人間用 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/review_result.md` | 設計レビュー結果 | 参考資料 |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/変更履歴.md` | 設計書変更履歴 | 参考資料 |

### 3.3 API スキーマ設計

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/APIスキーマ設計/APIスキーマ設計ブラッシュアップ版/index.md` | API スキーマ設計（改善版）のインデックス | 人間用 |
| `my_work/APIスキーマ設計/APIスキーマ設計ブラッシュアップ版/product_image.proto` | Protobuf スキーマ定義（改善版） | 人間用 |
| `my_work/APIスキーマ設計/APIスキーマ設計修正箇所調査/APIスキーマ定義_妥当性評価レポート.md` | API スキーマ妥当性評価レポート | 参考資料 |
| `my_work/APIスキーマ設計/APIスキーマ設計修正箇所調査/APIスキーマ定義_妥当性評価レポート_検証結果.md` | API スキーマ妥当性評価の検証結果 | 参考資料 |

### 3.4 リバースエンジニアリング

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング(devin)/product_image_list_design_document.md` | Devin によるリバースエンジニアリング設計書 | 参考資料 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/01_機能仕様書.md` | リバースエンジニアリング 機能仕様書 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/02_データフロー図.md` | リバースエンジニアリング データフロー図 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/03_API設計書.md` | リバースエンジニアリング API 設計書 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/04_サーバーロジック設計書.md` | リバースエンジニアリング サーバーロジック設計書 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/05_クライアントロジック設計書.md` | リバースエンジニアリング クライアントロジック設計書 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/06_テスト設計書.md` | リバースエンジニアリング テスト設計書 | 人間用 |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング_実施計画.md` | リバースエンジニアリング実施計画 | 参考資料 |
| `my_work/リバースエンジニアリング/差分比較/商品画像一覧取得機能_設計書差分比較レポート.md` | PoC 設計書と本番設計書の差分比較レポート | 参考資料 |

### 3.5 実装管理

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/実装管理/実装計画/商品画像一覧取得機能_実装計画書.md` | 本実装の実装計画書 | 人間用 |
| `my_work/実装管理/実装計画/タスク一覧.md` | 実装タスクの一覧 | 人間用 |
| `my_work/実装管理/実装計画/変更履歴.md` | 実装計画の変更履歴 | 参考資料 |
| `my_work/実装管理/phase3/TODO_テストケース再検討.md` | Phase 3 テストケース再検討の TODO | 参考資料 |
| `my_work/実装管理/phase3/カバレッジレポート.md` | Phase 3 テストカバレッジレポート | 参考資料 |
| `my_work/実装管理/phase3/テストエラー対応メモ.md` | Phase 3 テストエラー対応メモ | 参考資料 |
| `my_work/実装管理/phase3/テスト実装レビュー/レビュー結果.md` | Phase 3 テスト実装レビュー結果 | 参考資料 |
| `my_work/実装管理/phase3/テスト実装レビュー/レビュー結果_詳細版.md` | Phase 3 テスト実装レビュー結果（詳細版） | 参考資料 |
| `my_work/実装管理/phase3/テスト実装レビュー対応/タスク分解計画書.md` | Phase 3 レビュー対応のタスク分解計画書 | 参考資料 |
| `my_work/実装管理/phase3/テスト実装レビュー対応/ワーカーマネージャーセッション実行計画書.md` | Phase 3 ワーカーマネージャーセッション実行計画書 | 参考資料 |
| `my_work/実装管理/課題管理.csv` | プロダクト実装課題の管理 CSV（ISS-XXX 形式） | 人間用 |

### 3.6 プロセス改善 - ツール

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/tools/analyze-commands.sh` | コマンド頻度分析スクリプト（Claude が実行） | AI 用 |
| `my_work/プロセス改善/tools/command-tracker.sh` | コマンド実行履歴記録 PostToolUse hook（Claude が実行） | AI 用 |
| `my_work/プロセス改善/tools/csv-validation.sh` | CSV フォーマット検証スクリプト（Claude が実行） | AI 用 |
| `my_work/プロセス改善/tools/estimate_context.sh` | コンテキスト見積もりスクリプト（Claude が実行） | AI 用 |
| `my_work/プロセス改善/tools/logs/.gitkeep` | ログディレクトリのプレースホルダー（内容なし） | AI 用 |

### 3.7 プロセス改善 - ブランチ戦略

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/branch_strategy_plan.md` | OpenSpec と Git ブランチ戦略の統合計画書 | 人間用 |
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/user_decisions.md` | ブランチ戦略に関するユーザー意思決定記録 | 参考資料 |
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/work_history.md` | ブランチ戦略策定の作業履歴 | 参考資料 |

### 3.8 プロセス改善 - OpenSpec

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/openspec/openspec導入/README.md` | OpenSpec 導入手順書 | 人間用 |
| `my_work/プロセス改善/openspec/openspec導入/openspec活用事例/README.md` | OpenSpec 活用事例集 | 参考資料 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17727_商品画像一覧取得_Phase3_サーバー側単体テスト_Go/README.md` | Phase 3 OpenSpec 移行記録（Go サーバー側） | 参考資料 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/PR_template.md` | Phase 4 PR テンプレート | 参考資料 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/README.md` | Phase 4 OpenSpec 移行記録（Python クライアント側） | 参考資料 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/implementation_plan.md` | Phase 4 実装計画書 | 参考資料 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/openspec_operation_guide.md` | OpenSpec 運用ガイド | 人間用 |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/verification_checklist.md` | Phase 4 検証チェックリスト | 参考資料 |

### 3.9 プロセス改善 - settings.json 管理

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/PR_INFO.md` | Hooks 導入 PR 情報 | 参考資料 |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/README.md` | Hooks 導入の概要・手順 | 人間用 |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/implementation_plan.md` | Hooks 導入実装計画 | 参考資料 |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/実装ログ/phase1_implementation.md` | Hooks 導入 Phase 1 実装ログ | 参考資料 |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/実装ログ/phase2_implementation.md` | Hooks 導入 Phase 2 実装ログ | 参考資料 |

### 3.10 プロセス改善 - 並列開発

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/セッション運用ガイド.md` | ワーカーマネージャー方式の運用手順書（Claude が参照） | AI 用 |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/ディレクトリ構成.md` | ディレクトリ構造・命名規則・成果物格納ルール（Claude が参照） | AI 用 |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/プラグイン活用ガイド.md` | プラグイン活用ガイド（Claude が参照） | AI 用 |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/ワーカープロンプトテンプレート.md` | ワーカー起動プロンプトのテンプレート集（Claude が使用） | AI 用 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/README.md` | multi-agent-shogun 統合プロジェクト概要 | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/README_MONOTARO.md.sample` | マネージャー向け README サンプル | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/config-samples/projects.yaml.sample` | projects.yaml のサンプル設定 | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/config-samples/settings.json.sample` | settings.json のサンプル設定 | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/infra.md.sample` | インフラコンテキストのサンプル | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/microservices.md.sample` | マイクロサービスコンテキストのサンプル | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/ms-parts.md.sample` | マイクロサービス部品コンテキストのサンプル | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/protobuf.md.sample` | Protobuf コンテキストのサンプル | 参考資料 |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/統合計画.md` | multi-agent-shogun 統合計画書 | 参考資料 |

### 3.11 プロセス改善 - 課題管理構築

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/README.md` | CSV フォーマット強制機構の概要・手順 | 人間用 |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/implementation_plan.md` | CSV フォーマット強制の実装計画 | 参考資料 |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/integration_test_recovery.md` | 統合テスト復旧記録 | 参考資料 |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/verification_checklist.md` | 検証チェックリスト | 参考資料 |

### 3.12 プロセス改善 - Node.js アップグレード

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/nodejs-upgrade/README.md` | Node.js アップグレード実施報告 | 参考資料 |

### 3.13 プロセス改善 - 課題管理 CSV

| 現在パス | 概要 | 区分 |
|----------|------|------|
| `my_work/プロセス改善/プロセス改善_課題管理.csv` | プロセス改善課題の管理 CSV | 人間用 |

---

## 4. 新ディレクトリ構造設計

### 4.1 設計方針

- **AI 資料 = Source of Truth**: `.claude/` 配下が正の情報源。人間向けドキュメントは AI 資料から派生させる。
- **命名規則**: このプロジェクトで確立している `.claude/rules/` 命名を継続（Claude Code 標準ではなく本プロジェクト規約優先）。
- **参考資料の分離**: 現役の設計書・ルールと過去実績を明確に分離する。

### 4.2 新ディレクトリ構造

```
m6o-es-product-api/
├── .claude/
│   ├── rules/          # AI 向けルール・コンテキストファイル（Source of Truth）
│   │                   # Claude が自動参照するルールファイル群
│   │                   # 例: セッション運用ガイド、ディレクトリ構成、プロンプトテンプレート
│   └── tools/          # Claude が実行するシェルスクリプト群
│                       # 例: analyze-commands.sh, command-tracker.sh, csv-validation.sh
├── docs/               # 人間向けドキュメント（AI 資料から派生・同期）
│   ├── design/         # アプリケーション設計書
│   │                   # 例: 商品画像一覧取得機能の設計書群、API スキーマ設計書
│   ├── process/        # プロセス・ガイド・手順書
│   │                   # 例: OpenSpec 導入手順、Hooks 導入手順、ブランチ戦略
│   └── re/             # リバースエンジニアリング設計書
│                       # 例: 商品画像一覧取得機能のリバースエンジニアリング設計書群
└── refs/               # 参考資料・過去実績・アーカイブ
    ├── poc/            # PoC 情報（設計書・実装メモリバンク）
    ├── impl-history/   # 実装履歴・レビュー記録・作業ログ
    └── process-history/ # プロセス改善の実施記録・比較レポート
```

### 4.3 各ディレクトリの用途定義

| ディレクトリ | 用途 | 配置するファイルの種類 | 参照者 |
|-------------|------|----------------------|--------|
| `.claude/rules/` | AI 向けルール・コンテキスト（Source of Truth） | セッション運用ガイド、ディレクトリ構成、プロンプトテンプレート、プラグイン活用ガイド | AI（Claude） |
| `.claude/tools/` | Claude が実行するスクリプト | シェルスクリプト（analyze-commands.sh 等）、ログディレクトリ | AI（Claude） |
| `docs/design/` | 現役のアプリ設計書 | 商品画像機能の設計書群（01_概要.md 等）、ADR、API スキーマ設計書、実装計画書 | 人間 |
| `docs/process/` | プロセス・ガイド・手順書 | OpenSpec 導入手順、Hooks 導入手順、ブランチ戦略、CSV フォーマット強制手順 | 人間 |
| `docs/re/` | リバースエンジニアリング設計書 | 商品画像機能のリバースエンジニアリング成果物（機能仕様書・データフロー図等） | 人間 |
| `refs/poc/` | PoC 関連資料 | PoC アプリ設計書、PoC 実装メモリバンク、PoC と本番の差分整理 | 人間（参照のみ） |
| `refs/impl-history/` | 実装履歴・作業記録 | Phase 3 実装記録、レビュー結果、OpenSpec 移行記録、settings.json 実装ログ | 人間（参照のみ） |
| `refs/process-history/` | プロセス改善の実施記録 | ブランチ戦略の意思決定記録・作業履歴、Node.js アップグレード報告、並列開発構築記録 | 人間（参照のみ） |

> **NOTE**: `my_work/README.md` は `my_work/` が廃止されるため、`docs/` 直下の `README.md` に移設してリンクを更新するか、廃止する。

---

## 5. ファイル移動先マッピング表

移動先パスはリポジトリルート（`m6o-es-product-api/`）基準で記載する。`my_work/` プレフィックスは廃止する。

### 5.1 README

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/README.md` | `docs/README.md` | リンク先パスを新パスに合わせて更新要 |

### 5.2 アプリ設計

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/01_概要.md` | `docs/design/商品画像一覧取得機能/01_概要.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/02_サーバーロジック設計.md` | `docs/design/商品画像一覧取得機能/02_サーバーロジック設計.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/03_クライアントロジック設計.md` | `docs/design/商品画像一覧取得機能/03_クライアントロジック設計.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/04_段階リリース設計.md` | `docs/design/商品画像一覧取得機能/04_段階リリース設計.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/05_切り戻し設計.md` | `docs/design/商品画像一覧取得機能/05_切り戻し設計.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/06_単体テスト実装方針.md` | `docs/design/商品画像一覧取得機能/06_単体テスト実装方針.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/ADR.md` | `docs/design/商品画像一覧取得機能/ADR.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/review_result.md` | `refs/impl-history/商品画像一覧取得機能/review_result.md` | |
| `my_work/アプリ設計/本実装/商品画像一覧取得機能/変更履歴.md` | `refs/impl-history/商品画像一覧取得機能/変更履歴.md` | |
| `my_work/アプリ設計/PoCアプリ設計書_本番アプリ設計書_差分整理.md` | `refs/poc/アプリ設計書_差分整理.md` | |
| `my_work/アプリ設計/PoC情報/PoCアプリ設計/product_image_app_arch.md` | `refs/poc/PoCアプリ設計/product_image_app_arch.md` | |
| `my_work/アプリ設計/PoC情報/PoCアプリ設計/product_image_app_arch_brushup.md` | `refs/poc/PoCアプリ設計/product_image_app_arch_brushup.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/activeContext.md` | `refs/poc/PoC実装メモリバンク/activeContext.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/api-specification.md` | `refs/poc/PoC実装メモリバンク/api-specification.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/issueArchive.md` | `refs/poc/PoC実装メモリバンク/issueArchive.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/productContext.md` | `refs/poc/PoC実装メモリバンク/productContext.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/progress.md` | `refs/poc/PoC実装メモリバンク/progress.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/projectbrief.md` | `refs/poc/PoC実装メモリバンク/projectbrief.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/systemPatterns.md` | `refs/poc/PoC実装メモリバンク/systemPatterns.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/techContext.md` | `refs/poc/PoC実装メモリバンク/techContext.md` | |
| `my_work/アプリ設計/PoC情報/PoC実装メモリバンク/test-specification.md` | `refs/poc/PoC実装メモリバンク/test-specification.md` | |

### 5.3 API スキーマ設計

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/APIスキーマ設計/APIスキーマ設計ブラッシュアップ版/index.md` | `docs/design/APIスキーマ設計/index.md` | |
| `my_work/APIスキーマ設計/APIスキーマ設計ブラッシュアップ版/product_image.proto` | `docs/design/APIスキーマ設計/product_image.proto` | |
| `my_work/APIスキーマ設計/APIスキーマ設計修正箇所調査/APIスキーマ定義_妥当性評価レポート.md` | `refs/impl-history/APIスキーマ設計/APIスキーマ定義_妥当性評価レポート.md` | |
| `my_work/APIスキーマ設計/APIスキーマ設計修正箇所調査/APIスキーマ定義_妥当性評価レポート_検証結果.md` | `refs/impl-history/APIスキーマ設計/APIスキーマ定義_妥当性評価レポート_検証結果.md` | |

### 5.4 リバースエンジニアリング

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/01_機能仕様書.md` | `docs/re/商品画像一覧取得機能/01_機能仕様書.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/02_データフロー図.md` | `docs/re/商品画像一覧取得機能/02_データフロー図.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/03_API設計書.md` | `docs/re/商品画像一覧取得機能/03_API設計書.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/04_サーバーロジック設計書.md` | `docs/re/商品画像一覧取得機能/04_サーバーロジック設計書.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/05_クライアントロジック設計書.md` | `docs/re/商品画像一覧取得機能/05_クライアントロジック設計書.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/06_テスト設計書.md` | `docs/re/商品画像一覧取得機能/06_テスト設計書.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング_実施計画.md` | `refs/impl-history/リバースエンジニアリング/実施計画.md` | |
| `my_work/リバースエンジニアリング/商品画像一覧取得機能_リバースエンジニアリング(devin)/product_image_list_design_document.md` | `refs/impl-history/リバースエンジニアリング/product_image_list_design_document_devin.md` | |
| `my_work/リバースエンジニアリング/差分比較/商品画像一覧取得機能_設計書差分比較レポート.md` | `refs/impl-history/リバースエンジニアリング/設計書差分比較レポート.md` | |

### 5.5 実装管理

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/実装管理/実装計画/商品画像一覧取得機能_実装計画書.md` | `docs/design/商品画像一覧取得機能/実装計画書.md` | |
| `my_work/実装管理/実装計画/タスク一覧.md` | `docs/design/商品画像一覧取得機能/タスク一覧.md` | |
| `my_work/実装管理/実装計画/変更履歴.md` | `refs/impl-history/商品画像一覧取得機能/実装計画_変更履歴.md` | |
| `my_work/実装管理/phase3/TODO_テストケース再検討.md` | `refs/impl-history/phase3/TODO_テストケース再検討.md` | |
| `my_work/実装管理/phase3/カバレッジレポート.md` | `refs/impl-history/phase3/カバレッジレポート.md` | |
| `my_work/実装管理/phase3/テストエラー対応メモ.md` | `refs/impl-history/phase3/テストエラー対応メモ.md` | |
| `my_work/実装管理/phase3/テスト実装レビュー/レビュー結果.md` | `refs/impl-history/phase3/テスト実装レビュー/レビュー結果.md` | |
| `my_work/実装管理/phase3/テスト実装レビュー/レビュー結果_詳細版.md` | `refs/impl-history/phase3/テスト実装レビュー/レビュー結果_詳細版.md` | |
| `my_work/実装管理/phase3/テスト実装レビュー対応/タスク分解計画書.md` | `refs/impl-history/phase3/テスト実装レビュー対応/タスク分解計画書.md` | |
| `my_work/実装管理/phase3/テスト実装レビュー対応/ワーカーマネージャーセッション実行計画書.md` | `refs/impl-history/phase3/テスト実装レビュー対応/ワーカーマネージャーセッション実行計画書.md` | |
| `my_work/実装管理/課題管理.csv` | `docs/課題管理.csv` | ルートに近い場所で管理継続 |

### 5.6 プロセス改善 - ツール

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/tools/analyze-commands.sh` | `.claude/tools/analyze-commands.sh` | |
| `my_work/プロセス改善/tools/command-tracker.sh` | `.claude/tools/command-tracker.sh` | |
| `my_work/プロセス改善/tools/csv-validation.sh` | `.claude/tools/csv-validation.sh` | |
| `my_work/プロセス改善/tools/estimate_context.sh` | `.claude/tools/estimate_context.sh` | |
| `my_work/プロセス改善/tools/logs/.gitkeep` | `.claude/tools/logs/.gitkeep` | |

### 5.7 プロセス改善 - ワーカーマネージャー構成（AI 用）

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/セッション運用ガイド.md` | `.claude/rules/session-operation-guide.md` | |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/ディレクトリ構成.md` | `.claude/rules/directory-structure.md` | |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/プラグイン活用ガイド.md` | `.claude/rules/plugin-guide.md` | |
| `my_work/プロセス改善/並列開発/ワーカーマネージャー構成構築/ワーカープロンプトテンプレート.md` | `.claude/rules/worker-prompt-templates.md` | |

### 5.8 プロセス改善 - 並列開発（参考資料）

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/README.md` | `refs/process-history/multi-agent-shogun/README.md` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/README_MONOTARO.md.sample` | `refs/process-history/multi-agent-shogun/README_MONOTARO.md.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/config-samples/projects.yaml.sample` | `refs/process-history/multi-agent-shogun/config-samples/projects.yaml.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/config-samples/settings.json.sample` | `refs/process-history/multi-agent-shogun/config-samples/settings.json.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/infra.md.sample` | `refs/process-history/multi-agent-shogun/context-samples/infra.md.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/microservices.md.sample` | `refs/process-history/multi-agent-shogun/context-samples/microservices.md.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/ms-parts.md.sample` | `refs/process-history/multi-agent-shogun/context-samples/ms-parts.md.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/context-samples/protobuf.md.sample` | `refs/process-history/multi-agent-shogun/context-samples/protobuf.md.sample` | |
| `my_work/プロセス改善/並列開発/並列開発構築(multi-agent-shogun)/統合計画.md` | `refs/process-history/multi-agent-shogun/統合計画.md` | |

### 5.9 プロセス改善 - ブランチ戦略

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/branch_strategy_plan.md` | `docs/process/branch-strategy.md` | |
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/user_decisions.md` | `refs/process-history/ブランチ戦略/user_decisions.md` | |
| `my_work/プロセス改善/ブランチ戦略/1_初回策定/work_history.md` | `refs/process-history/ブランチ戦略/work_history.md` | |

### 5.10 プロセス改善 - OpenSpec

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/openspec/openspec導入/README.md` | `docs/process/openspec/openspec導入.md` | |
| `my_work/プロセス改善/openspec/openspec導入/openspec活用事例/README.md` | `refs/process-history/openspec/openspec活用事例.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17727_商品画像一覧取得_Phase3_サーバー側単体テスト_Go/README.md` | `refs/impl-history/openspec移行/MDM-17727_Phase3.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/PR_template.md` | `refs/impl-history/openspec移行/MDM-17729_PR_template.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/README.md` | `refs/impl-history/openspec移行/MDM-17729_Phase4.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/implementation_plan.md` | `refs/impl-history/openspec移行/MDM-17729_implementation_plan.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/openspec_operation_guide.md` | `docs/process/openspec/openspec_operation_guide.md` | |
| `my_work/プロセス改善/openspec/openspec管理への移行/MDM-17729_商品画像一覧取得_Phase4_クライアント側実装_Python2.7/verification_checklist.md` | `refs/impl-history/openspec移行/MDM-17729_verification_checklist.md` | |

### 5.11 プロセス改善 - settings.json 管理

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/README.md` | `docs/process/hooks/hooks導入.md` | |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/PR_INFO.md` | `refs/process-history/hooks/PR_INFO.md` | |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/implementation_plan.md` | `refs/process-history/hooks/implementation_plan.md` | |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/実装ログ/phase1_implementation.md` | `refs/process-history/hooks/実装ログ/phase1_implementation.md` | |
| `my_work/プロセス改善/settings_json管理/1_導入・hooks作成/実装ログ/phase2_implementation.md` | `refs/process-history/hooks/実装ログ/phase2_implementation.md` | |

### 5.12 プロセス改善 - 課題管理構築

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/README.md` | `docs/process/課題管理/csv_format_enforcement.md` | |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/implementation_plan.md` | `refs/process-history/課題管理構築/implementation_plan.md` | |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/integration_test_recovery.md` | `refs/process-history/課題管理構築/integration_test_recovery.md` | |
| `my_work/プロセス改善/課題管理構築/1_課題管理csvフォーマット強制/verification_checklist.md` | `refs/process-history/課題管理構築/verification_checklist.md` | |

### 5.13 プロセス改善 - Node.js アップグレード

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/nodejs-upgrade/README.md` | `refs/process-history/nodejs-upgrade/README.md` | |

### 5.14 プロセス改善 - 課題管理 CSV

| 現在パス | 新パス | 備考 |
|----------|--------|------|
| `my_work/プロセス改善/プロセス改善_課題管理.csv` | `docs/プロセス改善_課題管理.csv` | |

---

## 6. 設計方針まとめ

### AI 資料 = Source of Truth

```
.claude/rules/ が正の情報源
  ↓ 派生
docs/ が人間向け可視化
```

- `.claude/rules/` 配下のルールファイルを更新した場合、必ず `docs/process/` の対応するドキュメントも合わせて更新する。
- AI 用ファイルは Claude が自動参照できる場所（`.claude/` 配下）に集約する。

### ファイル命名規則

| 場所 | 命名規則 |
|------|----------|
| `.claude/rules/` | kebab-case の英語名（例: `session-operation-guide.md`） |
| `.claude/tools/` | kebab-case の英語名（例: `analyze-commands.sh`） |
| `docs/design/` | 日本語名のまま継続（既存命名規則を維持） |
| `docs/process/` | 日本語名または英語名（混在可） |
| `refs/` | 既存ファイル名を維持（移動のみ） |

---

**作成者**: L2-worker
**対象リポジトリ**: `/home/developer/projects/m6o-es-product-api_dev_process_improvement/m6o-es-product-api/`
**参照構造例**: `/home/developer/projects/m6o-es-product-api_dev_process_improvement/ai-driven-dev-patterns-fork/.claude/rules/`
