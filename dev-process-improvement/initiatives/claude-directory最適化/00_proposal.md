# 改善施策提案: .claude/ ディレクトリ用途最適化

## 背景・課題

dev-process-improvement の `.claude/rules/` 配下のファイルは全て常時読み込みされている。
しかし文書分類ポリシーに照らすと、セッション種別に依存するポリシー文書はオンデマンド読み込み（skills/）が適切である。

現状の rules/ 構成（計386行が常時読み込み）:

| ファイル | 行数 | 常時読み込みの妥当性 |
|---------|------|-------------------|
| `commit-message.md` | 92行 | 妥当（全セッションでコミット規約を守る必要あり） |
| `session-flow-policy.md` | 137行 | 不要（新セッションタイプ作成時のみ参照） |
| `triage-standard-policy-guideline.md` | 157行 | 不要（トリアージ走査・準拠チェック時のみ参照） |

## 目標

- rules/ の常時読み込みコンテキストを約76%削減する（386行 → 92行 + description 2行）
- 移行後もAIが必要なタイミングで確実にポリシーを参照できるようにする

## スコープ

### やること

- `session-flow-policy.md` を `skills/session-flow-policy/SKILL.md` に移行
- `triage-standard-policy-guideline.md` を `skills/triage-standard-policy/SKILL.md` に移行
- 各スキルに `user-invocable: false` + 明確な `description` を設定し、AI自動呼び出しを実現
- 既存スキル（l1-manager, triage-manager）から新スキルへの参照を追記
- `docs/workflow.md` の更新（ドキュメント整合性ルールに基づく）

### やらないこと

- `commit-message.md` の移行（rules/ に残す）
- スキル・エージェント定義の内容変更（移行のみ、内容は変えない）
- ルートリポジトリ（ai-driven-dev-patterns）の `.claude/` 構成変更

## 期待される効果

- コンテキストウィンドウの常時占有量が294行削減される
- 文書分類ポリシーに準拠した一貫性のある構成になる
- セッション起動時に必要なルールだけが読み込まれる効率的な構成になる

## リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| AIがスキルを自動呼び出ししない | 中 | description を具体的に記述 + 既存スキルからの明示的参照で二重担保 |
| 既存の参照パスが壊れる | 低 | triage-worker の TG-008 セクション等の参照パスを更新する |

## 壁打ちの背景

壁打ちフェーズで以下が確認された:

1. **スコープ**: バックログには `rules/l1-manager.md`, `l2-worker.md`, `l2-evaluator.md` と記載されていたが、これらは既に `skills/` 配下に配置済み。実際の最適化対象は `session-flow-policy.md` と `triage-standard-policy-guideline.md` の2ファイル
2. **skills 形式**: 独立したスキルとして作成し、`user-invocable: false` + 明確な description でAI自動呼び出しを実現する
3. **自動呼び出しの工夫**: description によるAI自動判断 + 既存スキルからの明示的参照の併用で確実性を担保

## 備考・設計パターン

### AI自動呼び出しの設計

移行先のスキルは以下の設計とする:

```yaml
# session-flow-policy
---
name: session-flow-policy
description: '新セッションタイプの作成・.claude/skills/ 配下のスキル/エージェント構成の変更時に参照するポリシー'
user-invocable: false
---
```

```yaml
# triage-standard-policy
---
name: triage-standard-policy
description: 'トリアージ走査（TG-008）・ペアリング検証・ライフサイクル準拠チェック時に参照するガイドライン'
user-invocable: false
---
```

`user-invocable: false` により `/` メニューには非表示だが、description はセッション開始時に読み込まれるため、Claudeが関連タスクを検出した際に自動的にスキル全文を読み込む。

加えて、以下の既存スキルに明示的な参照を追記する:
- `l1-manager` SKILL.md: 新セッションタイプ作成時に session-flow-policy を参照する旨
- `triage-manager` SKILL.md: TG-008 チェック時に triage-standard-policy を参照する旨

---
**起票者**: L1
**起票日**: 2026-03-06
**ステータス**: 起票
