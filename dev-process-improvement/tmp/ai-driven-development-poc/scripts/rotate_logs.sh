#!/bin/bash

# rotate_logs.sh - セッションログの自動廃棄スクリプト

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# デフォルト設定
KEEP_COUNT=10
DRY_RUN=false

# 引数解析
for arg in "$@"; do
  case $arg in
    --dry-run)
      DRY_RUN=true
      ;;
    *)
      if [[ "$arg" =~ ^[0-9]+$ ]]; then
        KEEP_COUNT=$arg
      else
        echo "使い方: $0 [保持件数] [--dry-run]"
        echo ""
        echo "例:"
        echo "  $0              # デフォルト（各ロール10セッション保持）"
        echo "  $0 5            # 各ロール5セッション保持"
        echo "  $0 --dry-run    # 削除対象の確認のみ"
        exit 1
      fi
      ;;
  esac
done

echo "=== セッションログ ローテーション ==="
echo "  保持件数: 各ロール $KEEP_COUNT セッション"
if [ "$DRY_RUN" = true ]; then
  echo "  モード: DRY RUN（実際には削除しません）"
fi
echo ""

total_deleted=0
total_size=0

# 各エージェントディレクトリを確認
for agent_dir in logs/*/; do
  if [ -d "$agent_dir" ]; then
    agent_name=$(basename "$agent_dir")

    # セッションログファイルの一覧（新しい順）
    session_logs=($(ls -t "${agent_dir}"session_*.log 2>/dev/null || true))

    count=${#session_logs[@]}

    if [ "$count" -le "$KEEP_COUNT" ]; then
      echo "  $agent_name: ${count}件 — 削除なし"
      continue
    fi

    # 削除対象のファイル
    delete_count=$((count - KEEP_COUNT))
    to_delete=("${session_logs[@]:$KEEP_COUNT}")

    echo "  $agent_name: ${count}件 → ${KEEP_COUNT}件に縮小（${delete_count}件削除）"

    for log_file in "${to_delete[@]}"; do
      log_path="${agent_dir}${log_file}"

      # ファイルサイズの取得
      if [ -f "$log_path" ]; then
        size=$(du -sk "$log_path" | cut -f1)
        total_size=$((total_size + size))

        if [ "$DRY_RUN" = false ]; then
          rm -f "$log_path"
        fi

        echo "    削除: $log_file"
        total_deleted=$((total_deleted + 1))
      fi
    done
  fi
done

echo ""
echo "--- 結果 ---"
echo "  削除: $total_deleted ファイル"

if [ "$total_size" -gt 1024 ]; then
  total_size_mb=$((total_size / 1024))
  echo "  解放: ${total_size_mb}M"
else
  echo "  解放: ${total_size}K"
fi

if [ "$DRY_RUN" = true ]; then
  echo ""
  echo "DRY RUN モードのため、実際には削除されませんでした。"
  echo "実際に削除する場合は、--dry-run オプションを外して再実行してください。"
fi
