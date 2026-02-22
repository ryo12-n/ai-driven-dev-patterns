#!/bin/bash

# init_project.sh - プロジェクト構造の初期化スクリプト

set -e

echo "=== AI-Driven Development Framework - Project Initialization ==="
echo ""

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "プロジェクトルート: $PROJECT_ROOT"
echo ""

# ディレクトリ作成
echo "■ ディレクトリ構造を作成中..."

mkdir -p .claude/roles .claude/protocols .claude/hooks
mkdir -p tasks/{features,bugs,refactor,tests,optimize,docs}
mkdir -p locks logs
mkdir -p done/{features,bugs,refactor,tests,optimize,docs}
mkdir -p ci scripts src tests docs

echo "  ✓ ディレクトリ作成完了"

# .gitkeep ファイルの作成
echo "■ .gitkeep ファイルを配置中..."

touch locks/.gitkeep logs/.gitkeep src/.gitkeep tests/.gitkeep

echo "  ✓ .gitkeep 配置完了"

# CI スクリプトの雛形を作成（既存ファイルは上書きしない）
echo "■ CI スクリプトの雛形を作成中..."

if [ ! -f ci/run_fast.sh ]; then
  cat > ci/run_fast.sh <<'EOF'
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
EOF
  chmod +x ci/run_fast.sh
  echo "  ✓ ci/run_fast.sh 作成"
else
  echo "  - ci/run_fast.sh は既に存在（スキップ）"
fi

if [ ! -f ci/run_full.sh ]; then
  cat > ci/run_full.sh <<'EOF'
#!/bin/bash
# run_full.sh - フルテスト（5分以内）

set -e

echo "=== Full Test ==="
echo ""

# TODO: プロジェクトに応じてテストコマンドを実装
# 例:
# - pytest tests/ --tb=short
# - pytest --cov=src --cov-report=term-missing --cov-report=html
# - pytest integration_tests/ --tb=short

echo "⚠️  テストコマンドが未実装です"
echo "   ci/run_full.sh を編集して、プロジェクトのテストコマンドを追加してください"
echo ""

# 仮の成功（実装後は実際のテスト結果を返す）
exit 0
EOF
  chmod +x ci/run_full.sh
  echo "  ✓ ci/run_full.sh 作成"
else
  echo "  - ci/run_full.sh は既に存在（スキップ）"
fi

# タスクテンプレートの作成
echo "■ タスクテンプレートを作成中..."

if [ ! -f tasks/TASK_TEMPLATE.md ]; then
  cat > tasks/TASK_TEMPLATE.md <<'EOF'
# タスク: {タスク名}

## ステータス: open
## 優先度: medium

## 概要

{タスクの概要を記述}

## 完了条件

- [ ] 条件1
- [ ] 条件2
- [ ] 全テストがパスする
- [ ] 既存テストが壊れていない

## 参考

- 関連ドキュメント: docs/xxx.md
- 関連コード: src/xxx.py
EOF
  echo "  ✓ tasks/TASK_TEMPLATE.md 作成"
else
  echo "  - tasks/TASK_TEMPLATE.md は既に存在（スキップ）"
fi

# サンプルタスクの作成（オプション）
echo "■ サンプルタスクを作成中..."

if [ ! -f tasks/features/001_example.md ]; then
  cat > tasks/features/001_example.md <<'EOF'
# タスク: サンプル機能の実装

## ステータス: open
## 優先度: low

## 概要

これはサンプルタスクです。実際のプロジェクトに合わせて、このタスクを削除し、
新しいタスクを追加してください。

## 完了条件

- [ ] サンプル機能を実装
- [ ] テストを追加
- [ ] 全テストがパスする

## 参考

- TASK_TEMPLATE.md を参考にして、新しいタスクを作成してください
EOF
  echo "  ✓ tasks/features/001_example.md 作成（サンプル）"
else
  echo "  - サンプルタスクは既に存在（スキップ）"
fi

echo ""
echo "=== 初期化完了 ==="
echo ""
echo "次のステップ:"
echo "  1. ./scripts/setup_hooks.sh を実行して、Git フックをインストール"
echo "  2. .claude/ のプロンプトファイルを確認・編集"
echo "  3. ci/run_fast.sh と ci/run_full.sh にテストコマンドを実装"
echo "  4. tasks/ にプロジェクトのタスクを追加"
echo "  5. ./scripts/launch_team.sh でエージェントチームを起動"
echo ""
echo "詳細は README.md を参照してください。"
