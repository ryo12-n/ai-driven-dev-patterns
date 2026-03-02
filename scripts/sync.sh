#!/bin/bash
# sync.sh - origin と upstream の双方向同期スクリプト
#
# 概要:
#   origin と upstream の main ブランチを完全同期に保つ。
#   片方で PR をマージしたら、もう片方へ fast-forward push するために使う。
#
# 使い方:
#   bash scripts/sync.sh upstream-to-origin   # upstream → origin（upstream で PR マージ後）
#   bash scripts/sync.sh origin-to-upstream   # origin → upstream（origin で PR マージ後）
#
# 注意:
#   - 実行前にすべての変更をコミットしておくこと
#   - push は自動実行しない。完了後に手動で push すること
#   - origin→upstream の場合: スクリプトが gh auth switch を実行する。
#     push 後に gh auth switch --user ryo-nagata_monotaro でアカウントを戻すこと

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

# -------------------------------------------------------
# 引数チェック
# -------------------------------------------------------
DIRECTION="${1:-}"

if [[ "$DIRECTION" != "upstream-to-origin" && "$DIRECTION" != "origin-to-upstream" ]]; then
  echo -e "${YELLOW}使い方:${NC}"
  echo "  bash scripts/sync.sh upstream-to-origin   # upstream → origin"
  echo "  bash scripts/sync.sh origin-to-upstream   # origin → upstream"
  exit 1
fi

if [[ "$DIRECTION" == "upstream-to-origin" ]]; then
  echo -e "${BLUE}=== 同期スクリプト: upstream → origin ===${NC}"
  SOURCE_REMOTE="upstream"
  SOURCE_LABEL="upstream"
  PUSH_CMD="git push origin main"
else
  echo -e "${BLUE}=== 同期スクリプト: origin → upstream ===${NC}"
  SOURCE_REMOTE="origin"
  SOURCE_LABEL="origin"
  PUSH_CMD="git push upstream main"
fi
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
# Step 2: ソースリモートから fetch
# -------------------------------------------------------
echo "--- Step 2: ${SOURCE_LABEL} から fetch ---"
git fetch "$SOURCE_REMOTE"
echo ""

# -------------------------------------------------------
# Step 3: fast-forward マージ
# -------------------------------------------------------
echo "--- Step 3: ${SOURCE_LABEL}/main を fast-forward マージ ---"
if ! git merge --ff-only "${SOURCE_REMOTE}/main"; then
  echo -e "${RED}ERROR: fast-forward マージができませんでした。${NC}"
  echo "       origin と upstream の両方で同時に変更がマージされた可能性があります。"
  echo "       .claude/rules/sync.md の「同時マージが発生した場合の対処」を参照してください。"
  exit 1
fi
echo ""

# -------------------------------------------------------
# origin→upstream の場合: gh アカウント切り替え
# -------------------------------------------------------
if [[ "$DIRECTION" == "origin-to-upstream" ]]; then
  echo "--- Step 4: upstream push 用アカウントへ切り替え ---"
  if ! gh auth status 2>&1 | grep -q "ryo12-n"; then
    echo -e "${RED}ERROR: ryo12-n アカウントが gh に登録されていません。${NC}"
    echo "       gh auth login でアカウントを追加してから再実行してください。"
    exit 1
  fi
  gh auth switch --user ryo12-n
  echo -e "${GREEN}OK: ryo12-n に切り替えました${NC}"
  echo ""
fi

# -------------------------------------------------------
# 完了メッセージ
# -------------------------------------------------------
echo -e "${GREEN}=== 同期完了 ===${NC}"
echo ""
if [[ "$DIRECTION" == "upstream-to-origin" ]]; then
  echo "upstream の変更を取り込みました。"
  echo ""
  echo -e "${YELLOW}次のステップ: 内容を確認後、以下のコマンドで origin へ push してください${NC}"
  echo ""
  echo "  git log --oneline -5     # コミット履歴の確認"
  echo "  git diff origin/main     # push 前の差分確認"
  echo "  git push origin main     # origin へ push"
else
  echo "origin の変更を取り込みました。"
  echo ""
  echo -e "${YELLOW}次のステップ: 内容を確認後、以下のコマンドで upstream へ push してください${NC}"
  echo ""
  echo "  git log --oneline -5                              # コミット履歴の確認"
  echo "  git diff upstream/main                            # push 前の差分確認"
  echo "  git push upstream main                            # upstream へ push"
  echo "  gh auth switch --user ryo-nagata_monotaro         # アカウントを元に戻す"
fi
