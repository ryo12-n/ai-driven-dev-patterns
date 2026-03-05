# README の行数上限ルール

## 知見

README を 150行以内に保つルールを明文化すれば、ドキュメント肥大化を防止できる。

## 背景

organize-readme 施策で README を 146行 → 137行に書き直した際、150行上限を設定したことで詳細情報を docs/ に分離する判断が自然に生まれた。

## 対応案

- CLAUDE.md または .claude/rules/ に「README は 150行以内に保つ」ルールを追加
- 詳細情報は docs/ に分離する方針と組み合わせて運用

## 情報源

- `dev-process-improvement/initiatives/_archive/organize-readme/08_gate_review.md` 必須把握事項 #1
