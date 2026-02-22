#!/bin/bash

# setup_hooks.sh - Git フックのインストールスクリプト

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "=== Git Hooks Setup ==="
echo ""

# .git/hooks ディレクトリの確認
if [ ! -d ".git" ]; then
  echo "エラー: .git ディレクトリが見つかりません"
  echo "このスクリプトはGitリポジトリのルートで実行してください"
  exit 1
fi

mkdir -p .git/hooks

# post-commit フックのインストール
SOURCE_HOOK=".claude/hooks/post-commit"
TARGET_HOOK=".git/hooks/post-commit"

if [ ! -f "$SOURCE_HOOK" ]; then
  echo "エラー: $SOURCE_HOOK が見つかりません"
  echo "まず ./scripts/init_project.sh を実行してください"
  exit 1
fi

# フックをコピー
cp "$SOURCE_HOOK" "$TARGET_HOOK"
chmod +x "$TARGET_HOOK"

echo "  ✓ post-commit フックをインストールしました"
echo "    $TARGET_HOOK"
echo ""

echo "=== セットアップ完了 ==="
echo ""
echo "post-commit フックが有効になりました。"
echo "コミット時に自動的に進捗ログ（logs/*/progress.md）が更新されます。"
echo ""
echo "注意事項:"
echo "  - .git/hooks/ は Git 管理対象外のため、"
echo "    リポジトリをクローンした場合は、再度このスクリプトを実行してください"
echo "  - フックを無効にする場合は、.git/hooks/post-commit を削除してください"
