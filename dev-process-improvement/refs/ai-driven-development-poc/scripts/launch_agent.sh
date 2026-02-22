#!/bin/bash

# launch_agent.sh - 単一エージェントの起動スクリプト

set -e

# 使い方
usage() {
  echo "使い方: $0 <role> <id> [task_file]"
  echo ""
  echo "引数:"
  echo "  role        エージェントのロール（例: feature_builder, bug_fixer）"
  echo "  id          エージェントID（例: A, B）"
  echo "  task_file   特定のタスクファイル（オプション）"
  echo ""
  echo "例:"
  echo "  $0 feature_builder A"
  echo "  $0 bug_fixer B tasks/bugs/042_sql_injection.md"
  exit 1
}

# 引数チェック
if [ "$#" -lt 2 ]; then
  usage
fi

ROLE="$1"
ID="$2"
TASK_FILE="${3:-}"

# プロジェクトルート
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# プロンプトファイル
BASE_PROMPT=".claude/base_prompt.md"
ROLE_PROMPT=".claude/roles/${ROLE}.md"
PROTOCOLS_DIR=".claude/protocols"

# ログディレクトリ
LOGS_DIR="logs/${ROLE}-${ID}"
mkdir -p "$LOGS_DIR"

# プロンプトファイルの存在確認
if [ ! -f "$BASE_PROMPT" ]; then
  echo "エラー: $BASE_PROMPT が見つかりません"
  exit 1
fi

if [ ! -f "$ROLE_PROMPT" ]; then
  echo "エラー: $ROLE_PROMPT が見つかりません"
  echo "利用可能なロール:"
  ls -1 .claude/roles/ | sed 's/\.md$//' | sed 's/^/  /'
  exit 1
fi

# プロンプトの結合
echo "=== Agent Launch: ${ROLE}-${ID} ==="
echo ""

PROMPT_FILE=$(mktemp)
trap "rm -f $PROMPT_FILE" EXIT

# プロンプトを結合
cat "$BASE_PROMPT" > "$PROMPT_FILE"
echo "" >> "$PROMPT_FILE"
echo "---" >> "$PROMPT_FILE"
echo "" >> "$PROMPT_FILE"
cat "$ROLE_PROMPT" >> "$PROMPT_FILE"

# プロトコルファイルを結合
for protocol in "$PROTOCOLS_DIR"/*.md; do
  if [ -f "$protocol" ]; then
    echo "" >> "$PROMPT_FILE"
    echo "---" >> "$PROMPT_FILE"
    echo "" >> "$PROMPT_FILE"
    cat "$protocol" >> "$PROMPT_FILE"
  fi
done

# セッション情報を追加
echo "" >> "$PROMPT_FILE"
echo "---" >> "$PROMPT_FILE"
echo "" >> "$PROMPT_FILE"
echo "# セッション情報" >> "$PROMPT_FILE"
echo "" >> "$PROMPT_FILE"
echo "- **Agent Role**: ${ROLE}" >> "$PROMPT_FILE"
echo "- **Agent ID**: ${ID}" >> "$PROMPT_FILE"
echo "- **Session Start**: $(date -Iseconds)" >> "$PROMPT_FILE"

if [ -n "$TASK_FILE" ]; then
  echo "- **Assigned Task**: ${TASK_FILE}" >> "$PROMPT_FILE"
  echo "" >> "$PROMPT_FILE"
  echo "指定されたタスクを実行してください:" >> "$PROMPT_FILE"
  echo "" >> "$PROMPT_FILE"
  echo '```' >> "$PROMPT_FILE"
  cat "$TASK_FILE" >> "$PROMPT_FILE"
  echo '```' >> "$PROMPT_FILE"
fi

# 起動情報の表示
echo "Role: $ROLE"
echo "ID: $ID"
echo "Logs: $LOGS_DIR"
if [ -n "$TASK_FILE" ]; then
  echo "Task: $TASK_FILE"
fi
echo ""

# 起動コマンドの構築
INSTRUCTION="あなたは ${ROLE}-${ID} です。base_prompt と role prompt に従って、タスクを1つ実行してください。"

# Claude Code の起動
claude -p "$INSTRUCTION" \
  --model sonnet \
  --append-system-prompt-file "$PROMPT_FILE" \
  --dangerously-skip-permissions \
  2>&1 | tee "$LOGS_DIR/session_$(date +%Y%m%d_%H%M%S).log"
