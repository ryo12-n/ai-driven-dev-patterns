# Test Protocol - テスト実行・判定ルール

## 目的

統一されたテスト実行ルールにより、品質を保証し、並列作業でのテスト失敗を早期に検出します。

## 2段階テスト

このフレームワークでは、テストを2段階で実行します：

### 1. 高速チェック（Fast Check）

**スクリプト**: `ci/run_fast.sh`

**目的**: コミット前の素早いフィードバック

**実行タイミング**:
- コミット前（必須）
- コード変更後（推奨）

**制限時間**: 30秒以内

**内容**:
- ユニットテストの一部（重要なテストのみ）
- 静的解析（lint, type check）
- フォーマットチェック

### 2. フルテスト（Full Test）

**スクリプト**: `ci/run_full.sh`

**目的**: 包括的な品質保証

**実行タイミング**:
- push前（必須）
- 重要な変更後（推奨）

**制限時間**: 5分以内

**内容**:
- 全ユニットテスト
- 統合テスト
- E2Eテスト（あれば）
- カバレッジレポート

## テストスクリプトの実装

### ci/run_fast.sh の実装例

```bash
#!/bin/bash
set -e

echo "=== Fast Check ==="

# 1. 静的解析（Python例）
echo "Running linter..."
flake8 src/ --max-line-length=100

# 2. 型チェック
echo "Running type checker..."
mypy src/

# 3. 重要なユニットテストのみ
echo "Running critical tests..."
pytest tests/ -m "critical" --tb=short

echo "✓ Fast check passed!"
exit 0
```

### ci/run_full.sh の実装例

```bash
#!/bin/bash
set -e

echo "=== Full Test ==="

# 1. 全ユニットテスト
echo "Running all unit tests..."
pytest tests/ --tb=short

# 2. カバレッジレポート
echo "Generating coverage report..."
pytest --cov=src --cov-report=term-missing --cov-report=html

# 3. 統合テスト
echo "Running integration tests..."
pytest integration_tests/ --tb=short

echo "✓ Full test passed!"
echo "Coverage report: htmlcov/index.html"
exit 0
```

## テスト実行の手順

### コミット前

```bash
# 1. 高速チェック
./ci/run_fast.sh

# 成功したらコミット
git add <files>
git commit -m "[role-id] category-task_id: summary"
```

### push前

```bash
# 1. フルテスト
./ci/run_full.sh

# 成功したらpush
git pull --rebase
git push
```

## テスト失敗時の対応フロー

### 高速チェック失敗

```bash
./ci/run_fast.sh
# → 失敗

# 1. エラーメッセージを読む
# 2. 失敗原因を特定
#    - 自分の変更が原因か？
#    - 既存のバグか？
# 3. 対応
```

#### ケース1: 自分の変更が原因

```bash
# 修正してから再テスト
./ci/run_fast.sh
# → 成功

# コミット
git add <files>
git commit -m "[role-id] category-task_id: summary"
```

#### ケース2: 既存のバグが原因

```bash
# 自分の変更を一旦取り消し
git stash

# テストを実行
./ci/run_fast.sh
# → 失敗（既存のバグを確認）

# Bug Fixer のタスクとして起票
cat > tasks/bugs/XXX_test_failure.md <<EOF
# タスク: テスト失敗の修正

## ステータス: open
## 優先度: high

## 概要
test_xxx が失敗している

## エラーメッセージ
（エラーメッセージを記録）

## 完了条件
- [ ] test_xxx が通る
- [ ] 原因を特定して修正
- [ ] 回帰テストを追加
EOF

git add tasks/bugs/XXX_test_failure.md
git commit -m "[YOUR_ROLE-YOUR_ID] bug: test_xxx の失敗を発見"
git push

# 自分の変更を戻す
git stash pop

# 別のタスクを選ぶ（このタスクは一旦保留）
```

### フルテスト失敗

```bash
./ci/run_full.sh
# → 失敗

# 1. どのテストが失敗したか確認
# 2. 高速チェックと同様に対応
```

## テストの種類とマーカー

### pytestのマーカー例

```python
import pytest

@pytest.mark.critical
def test_user_login():
    """Critical: ユーザーログイン"""
    pass

@pytest.mark.integration
def test_api_integration():
    """Integration: API統合テスト"""
    pass

@pytest.mark.slow
def test_large_dataset():
    """Slow: 大量データのテスト"""
    pass
```

### 実行方法

```bash
# Criticalテストのみ（高速チェック）
pytest -m "critical"

# 統合テストのみ
pytest -m "integration"

# slowを除く全テスト
pytest -m "not slow"
```

## テストカバレッジ

### カバレッジの確認

```bash
pytest --cov=src --cov-report=term-missing
```

出力例:
```
Name                Stmts   Miss  Cover   Missing
-------------------------------------------------
src/auth.py            45      5    89%   23-27
src/database.py        67      0   100%
src/utils.py           32      8    75%   45-52
-------------------------------------------------
TOTAL                 144     13    91%
```

### カバレッジの目標

- **新規コード**: 80%以上を目標
- **既存コード**: 徐々に向上させる
- **クリティカルな機能**: 100%を目指す

## テスト失敗の判定基準

### テストが「失敗」とみなされる場合

1. **アサーションエラー**: `assert` が False
2. **例外発生**: 意図しない例外が発生
3. **タイムアウト**: テストが制限時間を超える
4. **セットアップエラー**: テストのセットアップが失敗

### テストが「成功」とみなされる場合

1. **終了コード 0**: スクリプトが `exit 0` で終了
2. **全テストパス**: すべてのテストがパス
3. **カバレッジ基準達成**: カバレッジが基準を満たす（プロジェクトによる）

## CI/CDとの統合

### GitHub Actions の例

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Fast Check
        run: ./ci/run_fast.sh
      - name: Full Test
        run: ./ci/run_full.sh
```

### ローカルとCIの一貫性

- ローカルのテストスクリプトとCIで同じコマンドを使用
- `ci/run_fast.sh` と `ci/run_full.sh` をCIでも実行
- これにより、ローカルで通ったテストはCIでも通る

## テストのベストプラクティス

### 1. 独立性（Independence）

各テストは他のテストに依存しない：

```python
# Bad: テストの順序に依存
def test_create_user():
    global user_id
    user_id = create_user("test")

def test_update_user():
    update_user(user_id, "new_name")  # user_idに依存

# Good: 各テストが独立
def test_create_user():
    user_id = create_user("test")
    assert user_id is not None

def test_update_user():
    user_id = create_user("test")  # 自分で準備
    result = update_user(user_id, "new_name")
    assert result is True
```

### 2. 再現性（Repeatability）

何度実行しても同じ結果：

```python
# Bad: 現在時刻に依存
def test_is_business_day():
    assert is_business_day(datetime.now())  # 曜日により変わる

# Good: 固定値でテスト
def test_is_business_day():
    monday = datetime(2026, 2, 10)  # 2026-02-10は月曜日
    assert is_business_day(monday) is True

    sunday = datetime(2026, 2, 15)  # 2026-02-15は日曜日
    assert is_business_day(sunday) is False
```

### 3. 高速性（Speed）

テストは高速に：

```python
# Bad: 実際のAPIを呼び出す
def test_fetch_data():
    data = fetch_from_api("https://api.example.com")
    assert len(data) > 0

# Good: モックを使用
def test_fetch_data(mocker):
    mocker.patch('module.fetch_from_api', return_value=[1, 2, 3])
    data = fetch_from_api("https://api.example.com")
    assert len(data) == 3
```

### 4. 明確性（Clarity）

テストの意図が明確に：

```python
# Bad: 不明確
def test_process():
    assert process(10) == 20

# Good: 明確
def test_process_doubles_input_value():
    """process関数は入力値を2倍にして返す"""
    result = process(10)
    assert result == 20
```

## トラブルシューティング

### Q1. テストが不安定（時々失敗する）

A. 以下を確認：
- 非決定的な要素（ランダム、時間、並行処理）
- テスト間の依存関係
- 外部リソースへの依存（API、データベース）

### Q2. テストが遅い

A. 以下を検討：
- モックの活用
- テストデータの最小化
- 並列実行（pytest-xdist）
- slowマーカーで分離

### Q3. カバレッジが上がらない

A. 以下を確認：
- 未テストの分岐（if/else）
- 未テストの例外処理
- 未テストのエッジケース

### Q4. テストスクリプトがない

A. 以下の順で対応：
1. プロジェクトのテストコマンドを確認
2. `ci/run_fast.sh` と `ci/run_full.sh` を実装
3. 実装できない場合は、タスクとして起票

## まとめ

- **2段階テスト**: Fast Check（30秒）→ Full Test（5分）
- **コミット前**: 必ず Fast Check
- **push前**: 必ず Full Test
- **失敗時**: 原因を特定して対応
- **独立・再現・高速・明確**: テストのベストプラクティス

テストは品質の要です。必ず実行し、パスすることを確認してからコミット・pushしてください。
