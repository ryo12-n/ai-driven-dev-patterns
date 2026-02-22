#!/bin/bash

# launch_team.sh - チーム一括起動スクリプト（tmux方式）

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# チーム構成を定義
TEAM=(
  "feature_builder:A"
  "feature_builder:B"
  "bug_fixer:A"
  # "refactorer:A"        # コメント解除で追加
  # "test_writer:A"
  # "reviewer:A"
  # "optimizer:A"
  # "documentarian:A"
)

SESSION_NAME="agents"

# オプション解析
DRY_RUN=false
KILL_SESSION=false

for arg in "$@"; do
  case $arg in
    --dry-run)
      DRY_RUN=true
      ;;
    --kill)
      KILL_SESSION=true
      ;;
    *)
      echo "不明なオプション: $arg"
      echo "使い方: $0 [--dry-run] [--kill]"
      exit 1
      ;;
  esac
done

# セッション停止
if [ "$KILL_SESSION" = true ]; then
  echo "=== tmux セッション停止 ==="
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux kill-session -t "$SESSION_NAME"
    echo "  ✓ セッション「$SESSION_NAME」を停止しました"
  else
    echo "  - セッション「$SESSION_NAME」は存在しません"
  fi
  exit 0
fi

# dry-run
if [ "$DRY_RUN" = true ]; then
  echo "=== Team Launch (Dry Run) ==="
  echo ""
  echo "エージェント数: ${#TEAM[@]}"
  echo ""
  for agent in "${TEAM[@]}"; do
    IFS=':' read -r role id <<< "$agent"
    echo "./scripts/launch_agent.sh $role $id"
  done
  exit 0
fi

# 実際の起動
echo "=== Team Launch (tmux) ==="
echo ""
echo "エージェント数: ${#TEAM[@]}"
echo "セッション名: $SESSION_NAME"
echo ""

# 既存セッションの確認
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "エラー: セッション「$SESSION_NAME」は既に存在します"
  echo ""
  echo "以下のいずれかを実行してください:"
  echo "  - tmux attach -t $SESSION_NAME    # 既存セッションに接続"
  echo "  - ./scripts/launch_team.sh --kill # 既存セッションを停止"
  exit 1
fi

# tmuxセッションの作成
tmux new-session -d -s "$SESSION_NAME"

# エージェント数に応じてレイアウトを決定
NUM_AGENTS=${#TEAM[@]}

if [ "$NUM_AGENTS" -eq 1 ]; then
  # 1体: 分割なし
  :
elif [ "$NUM_AGENTS" -eq 2 ]; then
  # 2体: 左右分割
  tmux split-window -h -t "$SESSION_NAME"
elif [ "$NUM_AGENTS" -eq 3 ]; then
  # 3体: 左に1つ、右に2つ
  tmux split-window -h -t "$SESSION_NAME"
  tmux split-window -v -t "$SESSION_NAME:0.1"
elif [ "$NUM_AGENTS" -eq 4 ]; then
  # 4体: 2x2グリッド
  tmux split-window -h -t "$SESSION_NAME"
  tmux split-window -v -t "$SESSION_NAME:0.0"
  tmux split-window -v -t "$SESSION_NAME:0.2"
elif [ "$NUM_AGENTS" -eq 6 ]; then
  # 6体: 3x2グリッド
  tmux split-window -h -t "$SESSION_NAME"
  tmux split-window -h -t "$SESSION_NAME"
  tmux split-window -v -t "$SESSION_NAME:0.0"
  tmux split-window -v -t "$SESSION_NAME:0.2"
  tmux split-window -v -t "$SESSION_NAME:0.4"
  tmux select-layout tiled
else
  # その他: タイル状に自動配置
  for ((i=1; i<NUM_AGENTS; i++)); do
    tmux split-window -h -t "$SESSION_NAME"
    tmux select-layout tiled
  done
fi

# 各ペインでエージェントを起動
for i in "${!TEAM[@]}"; do
  agent="${TEAM[$i]}"
  IFS=':' read -r role id <<< "$agent"

  # ペイン番号
  pane_id=$i

  # ペインのボーダーにロール名を表示
  tmux select-pane -t "$SESSION_NAME:0.$pane_id" -T "${role}-${id}"

  # エージェント起動コマンドを送信
  tmux send-keys -t "$SESSION_NAME:0.$pane_id" "cd $PROJECT_ROOT && ./scripts/launch_agent.sh $role $id" Enter

  echo "  [$i] ${role}-${id} 起動"

  # スタッガード起動（2秒間隔）
  if [ "$i" -lt $((NUM_AGENTS - 1)) ]; then
    sleep 2
  fi
done

echo ""
echo "=== 全エージェント起動完了 ==="
echo ""
echo "tmux 操作方法:"
echo "  Ctrl+B → 矢印キー     ペイン移動"
echo "  Ctrl+B → [            スクロールモード（矢印/PgUp で移動、q で終了）"
echo "  Ctrl+B → Z            ペインをズーム/元に戻す"
echo "  Ctrl+B → D            セッションから切断（バックグラウンド継続）"
echo ""
echo "再接続:"
echo "  tmux attach -t $SESSION_NAME"
echo ""
echo "停止:"
echo "  ./scripts/launch_team.sh --kill"
echo ""

# セッションにアタッチ
tmux attach -t "$SESSION_NAME"
