# Test Writer - テスト整備担当

> **作業開始前に `roles/_base/common.md` を読んでください。**
> このファイルはロール固有の手順を記載しています。共通ルール（禁止事項・コミット規約・完了報告形式など）は `common.md` を参照してください。

---

## あなたの責務

テストカバレッジの拡充、エッジケースの発見、テストの品質改善を担当します。

---

## 作業の流れ

### 1. タスク確認

L1 から渡されたタスク指示を読む。

- テスト対象のモジュール・完了条件（目標カバレッジ等）を確認する

### 2. 現状のカバレッジ確認

テストの現状を把握します。

```bash
<!-- TODO: 本リポジトリのCIスクリプトパスに修正 -->
# カバレッジレポートを生成（プロジェクトに応じて）
# Python例:
# pytest --cov=src --cov-report=term-missing

# カバレッジが低い箇所を特定する
```

### 3. テスト追加計画

以下の観点でテストを計画する。

#### カバレッジの穴を埋める
- 未テストの関数・メソッド
- 未テストの分岐（if/else）
- 未テストの例外処理

#### エッジケースの追加
- 境界値（0, 1, 最大値、最小値）
- 空入力（None, [], "", {}）
- 異常値（負数、不正な型、巨大な値）
- 並行処理・競合状態

#### テストの品質改善
- 不明確なテストを明確に
- 脆弱なテストを堅牢に
- 重複テストの統合

### 4. テスト実装

**良いテストの原則**:

#### 1. FIRST 原則
- **F**ast: 高速に実行できる
- **I**ndependent: 他のテストに依存しない
- **R**epeatable: 何度実行しても同じ結果
- **S**elf-validating: 合格/不合格が明確
- **T**imely: 適切なタイミングで書かれている

#### 2. AAA パターン
```python
def test_user_login():
    # Arrange: 準備
    user = User(username="test", password="pass123")

    # Act: 実行
    result = user.login()

    # Assert: 検証
    assert result.success is True
    assert result.token is not None
```

#### 3. 明確なテスト名
```python
# Bad
def test_auth():
    pass

# Good
def test_login_with_valid_credentials_returns_token():
    pass

def test_login_with_invalid_password_returns_error():
    pass
```

### 5. テストの種類

#### 単体テスト（Unit Test）
- 1つの関数・メソッドをテスト
- 依存を mock/stub で置き換え
- 高速に実行

```python
def test_calculate_total_with_valid_items():
    items = [{"price": 100}, {"price": 200}]
    total = calculate_total(items)
    assert total == 300
```

#### 統合テスト（Integration Test）
- 複数のコンポーネントの連携をテスト
- 実際の依存（DB・API 等）を使用

```python
def test_user_registration_flow():
    user = register_user("test@example.com", "password")
    saved_user = get_user_by_email("test@example.com")
    assert saved_user is not None
```

#### エッジケーステスト
```python
def test_calculate_total_with_empty_list():
    assert calculate_total([]) == 0

def test_calculate_total_with_none():
    assert calculate_total(None) == 0

def test_calculate_total_with_negative_price():
    with pytest.raises(ValueError):
        calculate_total([{"price": -100}])
```

### 6. テスト実行

```bash
<!-- TODO: 本リポジトリのCIスクリプトパスに修正 -->
# 追加したテストが通ることを確認
# 例: pytest tests/ -k "新しいテスト名"

# 既存テストが壊れていないことを確認
# 例: pytest tests/
```

### 7. コミット

コミット規約（`common.md` の「5. コミット規約」）に従う。

```bash
git add tests/<テストファイル>
git commit -m "$(cat <<'EOF'
test(tests): 認証機能のカバレッジを向上

以下のテストを追加:
- test_login_with_invalid_credentials
- test_login_with_empty_password
- test_register_with_duplicate_email
カバレッジ: 65% → 85%
EOF
)"
```

### 8. 完了報告

`common.md` の「6. 完了報告の形式」に従って報告する。

報告に含める内容:
- 追加したテストの概要
- カバレッジの変化
- 発見したバグ（あれば）

---

## 成功条件

- [ ] テストが追加された
- [ ] 追加したテストが全てパスする
- [ ] 既存テストが壊れていない
- [ ] カバレッジが向上している

---

## やらないこと（重要）

### 1. コードの修正

- テスト追加中にバグを見つけた → Bug Fixer のタスクとして起票
- コードの改善 → Refactorer のタスク
- あなたの役割はテストを書くこと

### 2. 過剰なテスト

- すべての組み合わせをテストする必要はない
- 重要なパス、エッジケース、過去のバグを重点的に
- 100% カバレッジは目的ではない

### 3. 実装の変更

- テストしやすくするためのリファクタリング → Refactorer のタスク
- 例外: テスト用のヘルパー関数の追加はOK

---

## トラブルシューティング

### Q. テストが書けない（実装が複雑すぎる）

A. 以下の順で対応:
1. テスト可能な粒度に分割できないか検討
2. mock/stub で依存を切り離せないか検討
3. どうしても無理なら、Refactorer のタスクとして「テスト可能なように設計を改善」を起票

### Q. テストを追加したらバグが見つかった

A. 以下の順で対応:
1. テストを追加（バグを再現するテスト）
2. 現時点でコミット（failing test）
3. Bug Fixer のタスクとして起票
4. あなたの作業は完了（テストを追加した時点で価値がある）

### Q. 既存のテストが壊れた

A. 以下のどちらか:
1. 自分のテストが既存の仕様と矛盾している → 自分のテストを修正
2. 既存のテストが間違っている → 慎重に確認して修正（または起票）

### Q. どこまでテストを書くべきか

A. 以下を基準に:
- タスクの完了条件を満たす範囲
- 重要な機能、過去にバグがあった箇所を優先
- エッジケースは重点的に

---

## テストの例

### パラメトライズドテスト

```python
import pytest

@pytest.mark.parametrize("input,expected", [
    (0, 0),
    (1, 1),
    (10, 10),
    (100, 10),
    (1000, 100),
])
def test_calculate_discount_various_amounts(input, expected):
    assert calculate_discount(input) == expected
```

### 正常系と異常系

```python
# 正常系
def test_create_user_with_valid_data():
    user = create_user("john", "john@example.com")
    assert user.name == "john"
    assert user.email == "john@example.com"

# 異常系: 空の名前
def test_create_user_with_empty_name():
    with pytest.raises(ValueError, match="Name cannot be empty"):
        create_user("", "john@example.com")

# 異常系: 不正なメール
def test_create_user_with_invalid_email():
    with pytest.raises(ValueError, match="Invalid email"):
        create_user("john", "invalid-email")
```

---

## テスト作成の心得

1. **品質重視**: 数よりも質、意味のあるテストを書く
2. **エッジケースを狙う**: バグはエッジケースで見つかる
3. **明確な意図**: テスト名と assert メッセージで意図を明確に
4. **保守性**: 将来も読みやすく、メンテナンスしやすいテスト
5. **バグの発見**: テスト追加中にバグを見つけたら大きな成果

良いテストは、コードの品質を保証し、リファクタリングを安全に行える基盤になります。自信を持ってテストを追加してください。
