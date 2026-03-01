# 作業レポート: openspec-code-trial

## サマリ

openspec の変更サイクル（new → continue → apply → verify → archive）を「マークダウンファイルの見出し一覧を出力する Go CLI ツール」の実コード生成で1回完遂した。全9タスク（T-001〜T-009）が完了し、`src/` に Go コードが実装され、ビルド・テストともに成功している。openspec CLI が未インストールのため全ステップを手動で実施したが、スキルの手順書が十分に詳細であり、手動でも問題なくサイクルを完遂できた。

## タスク実績

| ID | タスク | 計画 | 実績 | 差異・備考 |
|----|--------|------|------|-----------|
| T-001 | Go 開発環境確認 | go version で確認 | go version go1.24.7（Go 1.21以上） | 差異なし |
| T-002 | openspec change 作成 | /opsx:new で作成 | 手動で change ディレクトリ・.openspec.yaml 作成 | openspec CLI 未インストールのため手動実施 |
| T-003 | 成果物一式生成 | /opsx:continue で順次生成 | 手動で proposal → specs → design → tasks を作成 | 手動でスキル手順を再現。4成果物すべて完了 |
| T-004 | Go コード実装 | /opsx:apply で実装 | tasks.md の12タスクに従い手動実装 | 初回テストで1件失敗→修正→全パス |
| T-005 | ビルド・テスト | go build / go test | ビルド成功、6テスト全パス | 差異なし |
| T-006 | 整合性検証 | /opsx:verify で検証 | 手動で Completeness/Correctness/Coherence を検証 | CRITICAL 0件、WARNING 0件 |
| T-007 | アーカイブ | /opsx:archive で実施 | 手動で delta spec マージ・change 移動 | 差異なし |
| T-008 | プロセス知見記録 | 04_work_report.md に記載 | 本レポートに記載 | - |
| T-009 | 課題 CSV 転記 | 07_issues.md → CSV | 転記実施 | - |

## 成果物一覧

### openspec 成果物
- `openspec/changes/archive/2026-02-28-add-sample-go-cli/proposal.md` — 変更提案
- `openspec/changes/archive/2026-02-28-add-sample-go-cli/specs/md-heading-cli/spec.md` — デルタ仕様
- `openspec/changes/archive/2026-02-28-add-sample-go-cli/design.md` — 技術設計
- `openspec/changes/archive/2026-02-28-add-sample-go-cli/tasks.md` — 実装タスク（12/12完了）
- `openspec/specs/md-heading-cli/spec.md` — マージ済みメイン仕様

### ソースコード
- `src/go.mod` — Go モジュール定義
- `src/main.go` — CLI エントリポイント
- `src/parser/parser.go` — マークダウン見出し解析ロジック
- `src/parser/parser_test.go` — ユニットテスト（6テストケース）

## 発生した課題

- ISS-OC-001: openspec CLI が環境にインストールされていない（施策内で完結。手動実行で代替可能であることを確認）

## openspec x 実コード生成のプロセス知見

### (1) specs が実装の指針としてどの程度機能したか

**結論: 高い指針効果があった。**

- delta spec に記載した RFC2119 キーワード付きの要件と Given/When/Then 形式のシナリオが、実装時の判断基準として明確に機能した
- 特にエラー処理（引数なし・ファイル不在）の振る舞いが spec に明記されていたため、実装時に「何を実装すべきか」で迷うことがなかった
- verify フェーズで spec のシナリオ1つ1つに対して実装・テストの対応を確認できたため、漏れの検出が容易だった
- **改善点**: spec にはテスト戦略（単体テストの粒度・結合テストの要否）までは含まれていない。テスト設計は design.md や tasks.md で補完する必要がある

### (2) apply フェーズの実行結果と改善点

**結論: tasks.md のチェックリストが実装のガイドとして有効だった。**

- tasks.md の階層番号付きチェックリスト（1.1, 2.1, ...）が実装順序を明確にし、依存関係（モジュール初期化 → parser → CLI → テスト）に沿った実装ができた
- 1タスク1アクションの粒度が適切で、各タスクの完了判定が明確だった
- **実際の問題**: ネストしたコードブロック（4つのバッククォートで開始）のハンドリングが初回実装で漏れていた。テストで発見・修正できたが、spec にこのエッジケースを明記しておけば初回から正しい実装ができた可能性がある
- **改善点**: apply フェーズでは openspec CLI が利用できなかったため、tasks.md の読み込み → 実装 → チェックボックス更新のサイクルを手動で回した。CLI が使えればこの部分が自動化され、進捗トラッキングが容易になる

### (3) 全体サイクルのボトルネック

**結論: spec 作成（continue フェーズ）が最もコンテキスト負荷が高い。**

- **proposal → specs**: 要件の粒度設計（どこまで詳細に書くか）に判断が必要。特に Given/When/Then シナリオの網羅性は、実装経験がないと見積もりが難しい
- **specs → design**: spec が明確であれば設計は比較的スムーズ。mermaid 図の作成は設計の妥当性検証に有効だった
- **design → tasks**: design の Decisions セクションからタスクへの分解は機械的に行えた
- **apply**: tasks.md の粒度が適切であれば最も効率的なフェーズ。今回は12タスクで実装完了
- **verify**: spec のシナリオと実装の突合は時間がかかるが、品質保証として必須。自動化（テスト実行結果とシナリオの対応付け）の余地がある
- **archive**: 手動でも単純な作業。CLI があればさらに簡便

**ボトルネック**: spec 作成フェーズ。要件の粒度・網羅性の判断に最も時間とコンテキストを消費する。proposal で Capabilities を適切に設計し、spec では観測可能な振る舞いに集中することが重要。

## 所感・次フェーズへの申し送り

- openspec の変更サイクルは、CLI ツール規模のプロジェクトであれば1回のセッションで完遂可能
- openspec CLI が未インストールでもスキルの手順書を読んで手動実行できた。これはスキル設計の品質が高いことを示す
- 今回は外部依存なしの単純な CLI だったが、外部APIやDB連携がある場合の spec 記述パターンは別途検討が必要
- config.yaml の rules で「DB / API / フロントエンド / テスト」のカテゴリ分けが指定されているが、CLI ツールの場合は適合しない。プロジェクトタイプに応じた柔軟なカテゴリ設定が望ましい

---
**作成者**: L2（実施）
**作成日**: 2026-02-28
