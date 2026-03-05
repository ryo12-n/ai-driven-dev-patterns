# ドキュメント分離パターン

## 知見

README はエントリーポイントに徹し、詳細は docs/ に分離する方針は汎用的に適用可能なパターン。

## 背景

organize-readme 施策で「README → docs/session-guide.md → docs/design/」の3層構造を採用。抽象度を段階的に深める構成が、初見ユーザーのオンボーディングに効果的だった。

## 対応案

- 他のドキュメント（CHANGELOG 等）にも同パターンを検討
- CLAUDE.md にドキュメント階層の方針として明記

## 情報源

- `dev-process-improvement/initiatives/_archive/organize-readme/08_gate_review.md` 必須把握事項 #2
