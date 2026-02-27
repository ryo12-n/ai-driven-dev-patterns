#!/bin/bash
# sync-upstream.sh - upstream から origin へ同期するスクリプト
#
# 概要:
#   外部リポジトリ(upstream)の変更を社内リポジトリ(origin)へ取り込む。
#
# 使い方:
#   bash scripts/sync-upstream.sh
#
# 注意:
#   - 実行前にすべての変更をコミットしておくこと
#   - push は自動実行しない。完了後に手動で git push origin main を実行すること

set -euo pipefail

# -------------------------------------------------------
# 色定義
# -------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# -------------------------------------------------------
# スクリプトのルートディレクトリをリポジトリルートに固定
# -------------------------------------------------------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo -e "${BLUE}=== upstream 同期スクリプト ===${NC}"
echo ""

# -------------------------------------------------------
# Step 1: 未コミット変更の確認
# -------------------------------------------------------
echo "--- Step 1: 未コミット変更の確認 ---"
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo -e "${RED}ERROR: 未コミットの変更があります。${NC}"
  echo "       すべての変更をコミットしてから再実行してください。"
  echo ""
  echo "       未コミット変更の一覧:"
  git status --short
  exit 1
fi
echo -e "${GREEN}OK: クリーンな状態です${NC}"
echo ""

# -------------------------------------------------------
# Step 2: upstream から fetch
# -------------------------------------------------------
echo "--- Step 2: upstream から fetch ---"
git fetch upstream
echo ""

# -------------------------------------------------------
# Step 3: upstream/main をマージ
# -------------------------------------------------------
echo "--- Step 3: upstream/main をマージ ---"
if ! git merge upstream/main; then
  echo -e "${RED}ERROR: コンフリクトが発生しました。${NC}"
  echo "       手動で解決してから再実行してください。"
  echo ""
  echo "       コンフリクトファイル:"
  git diff --name-only --diff-filter=U 2>/dev/null || true
  exit 1
fi
echo ""

# -------------------------------------------------------
# 完了メッセージ
# -------------------------------------------------------
echo -e "${GREEN}=== 同期完了 ===${NC}"
echo ""
echo "upstream の変更を取り込みました。"
echo ""
echo -e "${YELLOW}次のステップ: 内容を確認後、以下のコマンドで origin へ push してください${NC}"
echo ""
echo "  git log --oneline -5     # コミット履歴の確認"
echo "  git diff origin/main     # push 前の差分確認"
echo "  git push origin main     # origin へ push"
