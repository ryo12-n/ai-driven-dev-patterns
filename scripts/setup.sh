#!/bin/bash
# setup.sh - 開発環境セットアップ確認スクリプト
#
# 動作: 各ツールの有無と最低バージョンを確認し、不足を報告する
# インストールは自動実行しない（案内のみ）
# 終了コード: 0 = 全ツール OK / 1 = 不足あり

set -euo pipefail

# -------------------------------------------------------
# ツール定義
# 書式: "コマンド名|表示名|最低バージョン|バージョン取得コマンド"
# -------------------------------------------------------
REQUIRED_TOOLS=(
  "bash|bash|4.0|bash --version | head -1 | grep -oP '\\d+\\.\\d+' | head -1"
  "git|git|2.0|git --version | grep -oP '\\d+\\.\\d+' | head -1"
  "node|Node.js (node)|18.0|node --version | tr -d 'v' | grep -oP '\\d+\\.\\d+' | head -1"
  "npm|npm|8.0|npm --version | grep -oP '\\d+\\.\\d+' | head -1"
  "claude|Claude Code CLI (claude)|1.0|claude --version 2>/dev/null | grep -oP '\\d+\\.\\d+' | head -1"
  "tmux|tmux|2.0|tmux -V | grep -oP '\\d+\\.\\d+' | head -1"
)

RECOMMENDED_TOOLS=(
  "curl|curl|7.0|curl --version | head -1 | grep -oP '\\d+\\.\\d+' | head -1"
  "jq|jq|1.6|jq --version | tr -d 'jq-' | grep -oP '\\d+\\.\\d+' | head -1"
  "python3|python3|3.8|python3 --version | grep -oP '\\d+\\.\\d+' | head -1"
)

# -------------------------------------------------------
# 色定義
# -------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# -------------------------------------------------------
# バージョン比較関数
# 引数: $1=現在バージョン $2=最低バージョン
# 戻り値: 0=OK / 1=NG
# -------------------------------------------------------
version_gte() {
  local current="$1"
  local minimum="$2"

  # major.minor を整数に変換して比較
  local cur_major cur_minor min_major min_minor
  cur_major=$(echo "$current" | cut -d. -f1)
  cur_minor=$(echo "$current" | cut -d. -f2)
  min_major=$(echo "$minimum" | cut -d. -f1)
  min_minor=$(echo "$minimum" | cut -d. -f2)

  if [ "$cur_major" -gt "$min_major" ]; then
    return 0
  elif [ "$cur_major" -eq "$min_major" ] && [ "$cur_minor" -ge "$min_minor" ]; then
    return 0
  else
    return 1
  fi
}

# -------------------------------------------------------
# チェック関数
# 引数: $1=コマンド $2=表示名 $3=最低バージョン $4=バージョン取得コマンド $5=必須(required)/推奨(recommended)
# -------------------------------------------------------
check_tool() {
  local cmd="$1"
  local name="$2"
  local min_ver="$3"
  local ver_cmd="$4"
  local kind="${5:-required}"

  # ツールの存在確認
  if ! command -v "$cmd" > /dev/null 2>&1; then
    if [ "$kind" = "required" ]; then
      echo -e "${RED}ERROR: ${name} が見つかりません${NC}"
      echo "       インストール手順: docs/dev-setup.md を参照してください"
    else
      echo -e "${YELLOW}WARN:  ${name} が見つかりません（推奨ツール）${NC}"
      echo "       インストール手順: docs/dev-setup.md を参照してください"
    fi
    return 1
  fi

  # バージョン取得
  local current_ver
  current_ver=$(eval "$ver_cmd" 2>/dev/null || echo "0.0")

  if [ -z "$current_ver" ]; then
    current_ver="0.0"
  fi

  # バージョン確認
  if version_gte "$current_ver" "$min_ver"; then
    echo -e "${GREEN}OK:    ${name} ${current_ver} (最低要件: ${min_ver})${NC}"
    return 0
  else
    if [ "$kind" = "required" ]; then
      echo -e "${RED}ERROR: ${name} のバージョンが不足しています (現在: ${current_ver}, 最低要件: ${min_ver})${NC}"
      echo "       アップデート手順: docs/dev-setup.md を参照してください"
    else
      echo -e "${YELLOW}WARN:  ${name} のバージョンが推奨要件未満です (現在: ${current_ver}, 推奨: ${min_ver})${NC}"
    fi
    return 1
  fi
}

# -------------------------------------------------------
# メイン処理
# -------------------------------------------------------
echo "=== 開発環境セットアップ確認 ==="
echo ""

has_error=0
has_warn=0

# 必須ツールのチェック
echo "--- 必須ツール ---"
for tool_entry in "${REQUIRED_TOOLS[@]}"; do
  IFS='|' read -r cmd name min_ver ver_cmd <<< "$tool_entry"
  if ! check_tool "$cmd" "$name" "$min_ver" "$ver_cmd" "required"; then
    has_error=1
  fi
done

echo ""

# 推奨ツールのチェック
echo "--- 推奨ツール ---"
for tool_entry in "${RECOMMENDED_TOOLS[@]}"; do
  IFS='|' read -r cmd name min_ver ver_cmd <<< "$tool_entry"
  if ! check_tool "$cmd" "$name" "$min_ver" "$ver_cmd" "recommended"; then
    has_warn=1
  fi
done

echo ""

# openspec の確認（任意）
echo "--- オプションツール ---"
if command -v openspec > /dev/null 2>&1; then
  echo -e "${GREEN}OK:    openspec が見つかりました${NC}"
else
  echo -e "${YELLOW}INFO:  openspec が見つかりません（仕様駆動開発を行う場合は npm install -g @fission-ai/openspec でインストール）${NC}"
fi

echo ""

# 結果サマリ
if [ "$has_error" -eq 1 ]; then
  echo -e "${RED}ERROR: セットアップが不完全です。上記の ERROR を確認して対応してください。${NC}"
  echo "       詳細: docs/dev-setup.md"
  exit 1
else
  if [ "$has_warn" -eq 1 ]; then
    echo -e "${GREEN}✅ セットアップ確認 OK${NC} ${YELLOW}（推奨ツールの警告があります）${NC}"
  else
    echo -e "${GREEN}✅ セットアップ確認 OK${NC}"
  fi
  exit 0
fi
