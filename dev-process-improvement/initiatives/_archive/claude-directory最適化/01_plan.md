# 実施計画: .claude/ ディレクトリ用途最適化

## フェーズ構成

| フェーズ | 内容 | 成功基準 |
|---------|------|----------|
| 1 | rules/ → skills/ 移行 + 既存スキルからの参照追記 + docs 更新 | 下記「成功基準（全体）」参照 |

## スケジュール

単一フェーズで完結する施策。1セッション内で完了見込み。

## 成功基準（全体）

1. `rules/session-flow-policy.md` が削除され、`skills/session-flow-policy/SKILL.md` として存在する
2. `rules/triage-standard-policy-guideline.md` が削除され、`skills/triage-standard-policy/SKILL.md` として存在する
3. 両スキルに `user-invocable: false` と具体的な `description` が設定されている
4. `rules/commit-message.md` が rules/ に残っている（誤移行されていない）
5. `l1-manager` SKILL.md に session-flow-policy スキルへの参照が追記されている
6. `triage-manager` SKILL.md に triage-standard-policy スキルへの参照が追記されている
7. 既存の参照パス（triage-worker の TG-008 等）が新しいパスに更新されている
8. `docs/workflow.md` がディレクトリ構成の変更を反映している
9. 移行後のスキル内容が元のルールファイルと同一である（YAML フロントマターの追加を除く）

## リソース・前提条件

- `session-flow-policy.md` と `triage-standard-policy-guideline.md` の内容は変更しない（移行のみ）
- SKILL.md の YAML フロントマター（name, description, user-invocable）を新規追加する
- 既存スキルへの参照追記は最小限の変更にとどめる

## リスクと対策

| リスク | 発生確率 | 影響 | 対策 |
|--------|---------|------|------|
| AI自動呼び出しが機能しない | 中 | 中 | description を具体的なトリガー条件で記述 + 既存スキルからの明示的参照で二重担保 |
| 既存参照パスの見落とし | 低 | 低 | grep で旧パスの参照を全件検索し、漏れなく更新 |

---
**作成者**: L1
**作成日**: 2026-03-06
**最終更新**: 2026-03-06
