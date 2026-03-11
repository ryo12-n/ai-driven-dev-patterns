# PR URL 出力規約

PR の URL をユーザーに提示する際は、バッククォート（`` ` ``）やマークダウンのリンク記法（`[text](url)`）で囲まず、プレーンテキストで出力する。

## 例

**良い例:**
```
https://github.com/owner/repo/compare/main...branch-name
```

**悪い例:**
```
`https://github.com/owner/repo/compare/main...branch-name`
[PR URL](https://github.com/owner/repo/compare/main...branch-name)
```

---
**作成日**: 2026-03-08
**同期元**: dev-process-improvement `.claude/rules/pr-url-output.md`
