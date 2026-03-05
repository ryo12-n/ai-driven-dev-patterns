# ローカル環境向け .claude/settings.json 設計

## 概要

ローカル WSL 環境で使用する `.claude/settings.json` の設定設計。
プロジェクト共有（git 管理）の設定として `ai-driven-dev-patterns/.claude/settings.json` に適用する。

## 設計方針

1. **$schema** を設定してエディタの自動補完・バリデーションを有効にする
2. **deny ルール** で機密ファイルへのアクセスを防止する
3. **allow ルール** で頻用コマンドの自動許可を設定し、操作性を向上させる
4. JSONC（コメント付き JSON）から**純粋な JSON** に移行する

## 設定内容

### 推奨 settings.json

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(./**/credentials*)",
      "Read(./**/*.pem)",
      "Read(./**/*.key)"
    ],
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git log *)",
      "Bash(git diff *)",
      "Bash(git branch *)",
      "Bash(git fetch *)",
      "Bash(gh auth status)",
      "Bash(gh pr view *)",
      "Bash(gh pr list *)",
      "Bash(ls *)",
      "Bash(cat *)"
    ],
    "ask": [
      "Bash(git push *)",
      "Bash(git merge *)",
      "Bash(git rebase *)",
      "Bash(gh pr create *)",
      "Bash(gh pr merge *)",
      "Bash(rm *)"
    ]
  }
}
```

### 各ルールの説明

#### deny（常に拒否）

| ルール | 理由 |
|--------|------|
| `Read(./.env)` / `Read(./.env.*)` | 環境変数に API キー等の機密情報が含まれる |
| `Read(./secrets/**)` | シークレットディレクトリ全体を保護 |
| `Read(./**/credentials*)` | 認証情報ファイルを保護 |
| `Read(./**/*.pem)` / `Read(./**/*.key)` | SSL 証明書・秘密鍵を保護 |

#### allow（自動許可）

| ルール | 理由 |
|--------|------|
| `Bash(npm run *)` | ビルド・テスト・リントの実行を自動許可 |
| `Bash(git status)` 等 | 読み取り系 git コマンドは安全 |
| `Bash(gh auth status)` 等 | gh の参照系コマンドは安全 |
| `Bash(ls *)` / `Bash(cat *)` | ファイル確認は安全 |

#### ask（毎回確認）

| ルール | 理由 |
|--------|------|
| `Bash(git push *)` | リモートへの変更は影響大 |
| `Bash(git merge *)` / `Bash(git rebase *)` | ブランチ操作は慎重に |
| `Bash(gh pr create *)` / `Bash(gh pr merge *)` | PR 操作は確認必須 |
| `Bash(rm *)` | ファイル削除は不可逆 |

## 個人設定 (settings.local.json)

個人の好みで追加する設定は `.claude/settings.local.json`（gitignored）に記載する。

```json
{
  "permissions": {
    "allow": [
      "Bash(git push -u origin *)"
    ]
  }
}
```

## 現行 settings.json からの変更点

| 項目 | 現行 | 変更後 |
|------|------|--------|
| フォーマット | JSONC（コメント付き） | 純粋な JSON |
| `$schema` | なし | 設定済み |
| deny ルール | なし | 機密ファイル 6 ルール |
| allow ルール | なし | 頻用コマンド 11 ルール |
| ask ルール | なし | 破壊的操作 6 ルール |

## 適用手順

1. 本設計をレビューし、プロジェクトの実情に合わせて調整する
2. `.claude/settings.json` を上記の推奨設定で上書きする
3. 個人設定が必要な場合は `.claude/settings.local.json` を作成する

---
**作成日**: 2026-03-04
