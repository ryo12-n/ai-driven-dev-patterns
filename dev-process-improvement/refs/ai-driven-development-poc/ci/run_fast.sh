#!/bin/bash
# run_fast.sh - 高速チェック（30秒以内）

set -e

echo "=== Fast Check ==="
echo ""

# TODO: プロジェクトに応じてテストコマンドを実装
# 例:
# - flake8 src/ --max-line-length=100
# - mypy src/
# - pytest tests/ -m "critical" --tb=short

echo "⚠️  テストコマンドが未実装です"
echo "   ci/run_fast.sh を編集して、プロジェクトのテストコマンドを追加してください"
echo ""

# 仮の成功（実装後は実際のテスト結果を返す）
exit 0
