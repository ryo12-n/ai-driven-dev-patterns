#!/bin/bash
# sync-upstream.sh - upstream から origin へ安全に同期するスクリプト
#
# 概要:
#   外部リポジトリ(upstream)の変更を社内リポジトリ(origin)へ取り込む。
#   dev-process-improvement/ 配下の作業実績ディレクトリは origin 固有のため
#   upstream の変更で上書きしない。
#
# 保護対象ディレクトリ:
#   - dev-process-improvement/backlog/
#   - dev-process-improvement/inbox/
#   - dev-process-improvement/initiatives/
#   - dev-process-improvement/triage/
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
# 保護対象ディレクトリ
# -------------------------------------------------------
PROTECTED_DIRS=(
  "dev-process-improvement/backlog"
  "dev-process-improvement/inbox"
  "dev-process-improvement/initiatives"
  "dev-process-improvement/triage"
)

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
# Step 2: 保護対象ディレクトリを一時バックアップ
# -------------------------------------------------------
echo "--- Step 2: 保護対象ディレクトリをバックアップ ---"
BACKUP_DIR="$(mktemp -d)"
trap 'rm -rf "$BACKUP_DIR"' EXIT

for dir in "${PROTECTED_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    mkdir -p "$BACKUP_DIR/$dir"
    cp -r "$dir/." "$BACKUP_DIR/$dir/"
    echo "  バックアップ完了: $dir"
  else
    echo "  スキップ（存在しない）: $dir"
  fi
done
echo ""

# -------------------------------------------------------
# Step 3: upstream から fetch
# -------------------------------------------------------
echo "--- Step 3: upstream から fetch ---"
git fetch upstream
echo ""

# -------------------------------------------------------
# Step 4: upstream/main をマージ
# -------------------------------------------------------
echo "--- Step 4: upstream/main をマージ ---"
if ! git merge upstream/main; then
  # コンフリクト発生時: 保護対象は ours で解決、それ以外はエラー終了
  CONFLICT_FILES=$(git diff --name-only --diff-filter=U 2>/dev/null || true)

  UNRESOLVABLE=""
  for conflict in $CONFLICT_FILES; do
    is_protected=false
    for dir in "${PROTECTED_DIRS[@]}"; do
      if [[ "$conflict" == "$dir/"* ]]; then
        is_protected=true
        break
      fi
    done

    if $is_protected; then
      echo "  保護対象のコンフリクトを ours で解決: $conflict"
      git checkout --ours "$conflict"
      git add "$conflict"
    else
      UNRESOLVABLE="$UNRESOLVABLE $conflict"
    fi
  done

  if [ -n "$UNRESOLVABLE" ]; then
    echo -e "${RED}ERROR: 保護対象外のファイルでコンフリクトが発生しました。${NC}"
    echo "       手動で解決してから再実行してください。"
    echo "       コンフリクトファイル:$UNRESOLVABLE"
    exit 1
  fi

  git commit --no-edit
fi
echo ""

# -------------------------------------------------------
# Step 5: 保護対象ディレクトリを復元
# -------------------------------------------------------
echo "--- Step 5: 保護対象ディレクトリを復元 ---"
RESTORED=false
for dir in "${PROTECTED_DIRS[@]}"; do
  if [ -d "$BACKUP_DIR/$dir" ]; then
    # upstream マージ後と内容が異なる場合のみ復元
    if ! diff -rq "$BACKUP_DIR/$dir" "$dir" > /dev/null 2>&1; then
      rm -rf "$dir"
      mkdir -p "$(dirname "$dir")"
      cp -r "$BACKUP_DIR/$dir" "$dir"
      echo "  復元完了: $dir"
      RESTORED=true
    else
      echo "  変更なし（復元不要）: $dir"
    fi
  fi
done
echo ""

# -------------------------------------------------------
# Step 6: 復元による差分をコミット
# -------------------------------------------------------
echo "--- Step 6: 復元差分のコミット ---"
if $RESTORED; then
  git add "${PROTECTED_DIRS[@]}" 2>/dev/null || true
  if ! git diff --cached --quiet; then
    git commit -m "Restore origin-only directories after upstream sync"
    echo -e "${GREEN}OK: 復元差分をコミットしました${NC}"
  else
    echo "  差分なし（コミット不要）"
  fi
else
  echo "  復元なし（コミット不要）"
fi
echo ""

# -------------------------------------------------------
# 完了メッセージ
# -------------------------------------------------------
echo -e "${GREEN}=== 同期完了 ===${NC}"
echo ""
echo "upstream の変更を取り込みました。"
echo "保護対象ディレクトリは origin の状態を維持しています。"
echo ""
echo -e "${YELLOW}次のステップ: 内容を確認後、以下のコマンドで origin へ push してください${NC}"
echo ""
echo "  git log --oneline -5     # コミット履歴の確認"
echo "  git diff origin/main     # push 前の差分確認"
echo "  git push origin main     # origin へ push"
