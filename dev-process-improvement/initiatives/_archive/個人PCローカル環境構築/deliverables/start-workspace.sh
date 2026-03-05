#!/bin/bash
# start-workspace.sh — Claude Code マルチリポセッション起動スクリプト
#
# 使い方:
#   ./start-workspace.sh              # デフォルト: ai-driven-dev-patterns のみ
#   ./start-workspace.sh all          # 全リポを束ねて起動
#   ./start-workspace.sh multi        # ai-driven-dev-patterns + dev-process-improvement
#   ./start-workspace.sh <リポ名>...  # 指定リポを --add-dir で追加
#
# 配置場所: ~/projects/start-workspace.sh

set -euo pipefail

# === 設定 ===
PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"
HUB_REPO="ai-driven-dev-patterns"

# 追加リポジトリの定義（名前=パス）
declare -A REPOS=(
  ["dev-process-improvement"]="${PROJECTS_DIR}/dev-process-improvement"
  # 将来リポが増えたらここに追加
  # ["frontend"]="${PROJECTS_DIR}/frontend"
)

# プリセット定義
declare -A PRESETS=(
  ["all"]="dev-process-improvement"
  ["multi"]="dev-process-improvement"
  # 将来プリセットが増えたらここに追加
  # ["backend"]="dev-process-improvement frontend"
)

# === 関数 ===
usage() {
  cat <<'USAGE'
Usage: start-workspace.sh [PRESET | REPO_NAME...]

プリセット:
  (引数なし)   ai-driven-dev-patterns のみで起動
  all          全リポを束ねて起動
  multi        ai-driven-dev-patterns + dev-process-improvement

リポ指定:
  dev-process-improvement   指定リポを --add-dir で追加（複数指定可）

オプション:
  -h, --help   このヘルプを表示
  --dry-run    実行コマンドを表示するだけで起動しない

例:
  ./start-workspace.sh                        # メインリポのみ
  ./start-workspace.sh multi                  # 2リポ構成
  ./start-workspace.sh dev-process-improvement # 特定リポを追加
  ./start-workspace.sh --dry-run all          # コマンド確認のみ
USAGE
}

check_repo_exists() {
  local repo_path="$1"
  if [[ ! -d "$repo_path/.git" ]]; then
    echo "エラー: リポジトリが見つかりません: $repo_path" >&2
    echo "  git clone でリポジトリを取得してください" >&2
    return 1
  fi
}

# === メイン処理 ===
DRY_RUN=false
ADD_DIRS=()

# 引数パース
for arg in "$@"; do
  case "$arg" in
    -h|--help)
      usage
      exit 0
      ;;
    --dry-run)
      DRY_RUN=true
      ;;
    *)
      # プリセットチェック
      if [[ -n "${PRESETS[$arg]+x}" ]]; then
        for repo_name in ${PRESETS[$arg]}; do
          ADD_DIRS+=("$repo_name")
        done
      elif [[ -n "${REPOS[$arg]+x}" ]]; then
        ADD_DIRS+=("$arg")
      else
        echo "エラー: 不明なリポジトリまたはプリセット: $arg" >&2
        echo "  利用可能: ${!REPOS[*]}" >&2
        echo "  プリセット: ${!PRESETS[*]}" >&2
        exit 1
      fi
      ;;
  esac
done

# 軸リポの存在確認
HUB_PATH="${PROJECTS_DIR}/${HUB_REPO}"
if ! check_repo_exists "$HUB_PATH"; then
  exit 1
fi

# --add-dir オプションの組み立て
ADD_DIR_OPTS=()
for repo_name in "${ADD_DIRS[@]}"; do
  repo_path="${REPOS[$repo_name]}"
  if ! check_repo_exists "$repo_path"; then
    exit 1
  fi
  ADD_DIR_OPTS+=("--add-dir" "$repo_path")
done

# --add-dir 使用時は追加リポの CLAUDE.md も読み込む
if [[ ${#ADD_DIR_OPTS[@]} -gt 0 ]]; then
  export CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1
fi

# コマンド組み立て
CMD=(claude "${ADD_DIR_OPTS[@]}")

# 実行
echo "=== Claude Code ワークスペース ==="
echo "軸リポ: ${HUB_PATH}"
if [[ ${#ADD_DIRS[@]} -gt 0 ]]; then
  echo "追加リポ: ${ADD_DIRS[*]}"
fi
echo "コマンド: ${CMD[*]}"
echo "==================================="

if [[ "$DRY_RUN" == true ]]; then
  echo "(dry-run: 実行しません)"
  exit 0
fi

cd "$HUB_PATH"
exec "${CMD[@]}"
