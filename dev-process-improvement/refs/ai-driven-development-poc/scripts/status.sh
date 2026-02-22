#!/bin/bash

# status.sh - プロジェクトの稼働状況確認スクリプト

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "=== プロジェクト稼働状況 ==="
echo "  時刻: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# タスク状況の集計
echo "■ タスク状況"

for category in features bugs refactor tests optimize docs; do
  open_count=$(ls -1 "tasks/$category/" 2>/dev/null | grep -v "^$" | wc -l || echo 0)
  done_count=$(ls -1 "done/$category/" 2>/dev/null | grep -v "^$" | wc -l || echo 0)

  printf "  %-12s 未着手: %3d  完了: %3d\n" "$category" "$open_count" "$done_count"
done

echo ""

# ロック中のタスク
echo "■ ロック中のタスク"

if [ -z "$(ls -A locks/ 2>/dev/null | grep '\.lock$')" ]; then
  echo "  （なし）"
else
  for lock_file in locks/*.lock; do
    if [ -f "$lock_file" ]; then
      lock_name=$(basename "$lock_file" .lock)
      agent=$(grep "^agent:" "$lock_file" | cut -d' ' -f2)
      started=$(grep "^started:" "$lock_file" | cut -d' ' -f2)
      task=$(grep "^task:" "$lock_file" | cut -d' ' -f2)

      echo "  🔒 $lock_name"
      echo "     担当: $agent  開始: $started"

      # 経過時間の計算（秒単位）
      if command -v date >/dev/null 2>&1; then
        started_epoch=$(date -d "$started" +%s 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%S" "$started" +%s 2>/dev/null || echo 0)
        now_epoch=$(date +%s)

        if [ "$started_epoch" -gt 0 ]; then
          elapsed=$((now_epoch - started_epoch))
          hours=$((elapsed / 3600))
          minutes=$(((elapsed % 3600) / 60))

          if [ "$hours" -gt 0 ]; then
            echo "     経過時間: ${hours}時間${minutes}分"
            if [ "$hours" -ge 1 ]; then
              echo "     ⚠️  長時間ロック中"
            fi
          else
            echo "     経過時間: ${minutes}分"
          fi
        fi
      fi
    fi
  done
fi

echo ""

# エージェントログの最新状況
echo "■ エージェントログ"

found_log=false
for agent_dir in logs/*/; do
  if [ -d "$agent_dir" ]; then
    agent_name=$(basename "$agent_dir")
    progress_file="${agent_dir}progress.md"

    if [ -f "$progress_file" ]; then
      # 最新の進捗を抽出（最後のセクション）
      last_entry=$(tail -n 10 "$progress_file" | grep -v "^#" | grep -v "^$" | tail -n 1)

      if [ -n "$last_entry" ]; then
        echo "  $agent_name: $last_entry"
        found_log=true
      fi
    fi
  fi
done

if [ "$found_log" = false ]; then
  echo "  （ログなし）"
fi

echo ""
echo "=== 稼働状況確認完了 ==="
echo ""
echo "詳細確認:"
echo "  - タスク一覧: ls tasks/*/"
echo "  - 完了タスク: ls done/*/"
echo "  - エージェントログ: cat logs/*/progress.md"
echo "  - セッションログ: ls logs/*/session_*.log"
