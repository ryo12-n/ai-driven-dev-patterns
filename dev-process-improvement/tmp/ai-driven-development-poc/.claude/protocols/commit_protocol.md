# Commit Protocol - コミットメッセージ規約とpush手順

## 目的

統一されたコミットメッセージ形式により、進捗の自動記録とチーム間の可読性を確保します。

## コミットメッセージの形式

```
[{role}-{id}] {category}-{task_id}: {summary}

{details}
```

### パラメータ

- **{role}**: あなたのロール（例: `feature-builder`, `bug-fixer`, `refactorer`）
- **{id}**: あなたのID（例: `A`, `B`）
- **{category}**: タスクのカテゴリ
- **{task_id}**: タスクのID（例: `001`, `042`）
- **{summary}**: 1行の要約（50文字以内推奨）
- **{details}**: 詳細説明（任意、複数行OK）

### カテゴリ一覧

| カテゴリ | 意味 | 例 |
|---------|------|-----|
| `feat` | 新機能の追加 | `feat-001: ユーザー認証エンドポイント追加` |
| `bug` | バグ修正 | `bug-042: SQLインジェクションのリスク修正` |
| `refactor` | リファクタリング | `refactor-005: 認証ロジックの重複を統合` |
| `test` | テストの追加・修正 | `test-007: 認証テストのカバレッジ向上` |
| `optimize` | パフォーマンス改善 | `optimize-001: API レイテンシを84%改善` |
| `docs` | ドキュメントの更新 | `docs-001: READMEを更新` |
| `lock` | タスクロックの取得 | `lock: tasks/features/001_user_auth.md` |
| `complete` | タスク完了 | `complete: feat-001` |

## コミットメッセージの例

### 機能実装

```
[feature-builder-A] feat-001: ユーザー認証エンドポイント追加

POST /auth/login を実装
JWT トークン生成ロジックを追加
tests/test_auth.py に5件のテストを追加
全テストパス
```

### バグ修正

```
[bug-fixer-B] bug-042: SQLインジェクションのリスク修正

原因: get_user_by_name が文字列結合でクエリ構築
修正: プレースホルダーを使用するように変更
テスト: test_sql_injection_protection を追加
```

### リファクタリング

```
[refactorer-A] refactor-005: 認証ロジックの重複を統合

validate_credentials 関数を抽出
login_user と register_user で共通利用
振る舞いは変更なし、全テストパス
```

### テスト追加

```
[test-writer-A] test-007: 認証テストのカバレッジ向上

以下のテストを追加：
- test_login_with_invalid_credentials
- test_login_with_empty_password
- test_register_with_duplicate_email
カバレッジ: 65% → 85%
```

### 最適化

```
[optimizer-A] optimize-001: API レイテンシを84%改善

ボトルネック: N+1クエリ（1,523回）
改善: select_related で JOIN に変更（12回）
結果: 5.2秒 → 0.8秒（84%改善）
振る舞いは変更なし、全テストパス
```

### ドキュメント更新

```
[documentarian-A] docs: 進捗サマリーとCHANGELOGを更新

- logs/_summary.md: 全エージェントの進捗を集約
- CHANGELOG.md: 最近の変更を記録
- 完了タスク: 28/45 (62%)
```

### ロック取得

```
[feature-builder-A] lock: tasks/features/001_user_auth.md
```

### タスク完了

```
[feature-builder-A] complete: feat-001 ユーザー認証実装完了
```

## コミット前の確認事項

### 1. テストが通ること

```bash
./ci/run_fast.sh
```

- 高速テストが全てパスすることを確認
- 失敗する場合は、コミットしない

### 2. 適切なファイルだけをコミット

```bash
git status
```

- 意図したファイルだけが staged されているか確認
- 不要なファイル（ログ、一時ファイルなど）が含まれていないか確認

### 3. コミットメッセージの形式

- `[role-id] category-task_id: summary` の形式になっているか
- summary は簡潔で分かりやすいか
- details は十分な情報を含んでいるか

## push前の手順

### 1. ローカルでコミット

```bash
git add <変更ファイル>
git commit -m "[role-id] category-task_id: summary"
```

### 2. フルテストを実行（重要な変更の場合）

```bash
./ci/run_full.sh
```

### 3. 最新の変更を取得

```bash
git pull --rebase
```

- `--rebase` を使用して、履歴を直線的に保つ
- コンフリクトが発生した場合は、次のセクションを参照

### 4. push

```bash
git push
```

- 成功すれば完了
- 失敗した場合は、エラーメッセージを確認

## コンフリクト解消のルール

### コンフリクトの種類

#### 1. ロックファイルのコンフリクト

```
CONFLICT (add/add): Merge conflict in locks/features__001_user_auth.lock
```

**対応**: 別のタスクを選ぶ

```bash
git rebase --abort
git reset --hard HEAD~1
# → 別のタスクを選んで再試行
```

#### 2. ソースコードのコンフリクト

```
CONFLICT (content): Merge conflict in src/auth.py
```

**対応**: コンフリクトを解消

```bash
# コンフリクトを解消
# エディタで src/auth.py を編集し、<<<<<<< や ======= を削除

git add src/auth.py
git rebase --continue
git push
```

**コンフリクト解消のガイドライン**:
- 両方の変更を保持できる場合は、両方を残す
- どちらかを選ぶ必要がある場合は、慎重に判断
- テストを実行して、コンフリクト解消後も動作することを確認

#### 3. タスクファイルのコンフリクト

```
CONFLICT (content): Merge conflict in tasks/features/001_user_auth.md
```

**対応**: 通常は起こらないが、起こった場合は慎重に解消

- 他のエージェントがタスクを更新した可能性
- 両方の変更を確認し、適切に統合

### コンフリクト解消後の確認

```bash
# テストを実行
./ci/run_fast.sh

# 成功したらpush
git push
```

## HEREDOCを使った複数行コミットメッセージ

シェルでの複数行コミットメッセージは、HEREDOCを使用します：

```bash
git commit -m "$(cat <<'EOF'
[feature-builder-A] feat-001: ユーザー認証エンドポイント追加

POST /auth/login を実装
JWT トークン生成ロジックを追加
tests/test_auth.py に5件のテストを追加
全テストパス
EOF
)"
```

**重要**: `<<'EOF'` のようにシングルクォートで囲むと、変数展開が無効になります。

## 禁止事項

### 1. 意味のないコミットメッセージ

```bash
# Bad
git commit -m "update"
git commit -m "fix"
git commit -m "wip"

# Good
git commit -m "[feature-builder-A] feat-001: ユーザー認証エンドポイント追加"
```

### 2. ロール名のないコミットメッセージ

```bash
# Bad
git commit -m "feat-001: ユーザー認証追加"

# Good
git commit -m "[feature-builder-A] feat-001: ユーザー認証追加"
```

理由: post-commitフックがロール名を使って進捗を記録するため

### 3. テストが失敗した状態でのコミット

```bash
# テストが失敗している状態でコミットしない
./ci/run_fast.sh
# → 失敗

# 修正してからコミット
```

例外: Test Writer が failing test を追加する場合のみ許可

### 4. --force push

```bash
# Bad
git push --force

# Good
git push
```

理由: 他のエージェントの作業を上書きしてしまう

### 5. 直接 main/master ブランチへのpush

このフレームワークでは、全てのエージェントが同じブランチで作業します（通常は `main` または `master`）。

ブランチ戦略が必要な場合は、プロジェクトの設計で考慮してください。

## コミット頻度

### 小さく、頻繁にコミット

```bash
# Bad: 大きな変更を1つのコミットにまとめる
# （100行の変更を1コミット）

# Good: 小さな変更を複数のコミットに分ける
git commit -m "[feature-builder-A] feat-001: ユーザーモデルを追加"
git commit -m "[feature-builder-A] feat-001: ログインAPIを実装"
git commit -m "[feature-builder-A] feat-001: テストを追加"
```

**メリット**:
- レビューしやすい
- 問題が起きた時に切り戻しやすい
- 進捗が可視化される

## よくある質問

### Q1. コミットメッセージを間違えた

A. 直前のコミットなら修正可能（pushする前）：

```bash
git commit --amend -m "$(cat <<'EOF'
[feature-builder-A] feat-001: 正しいメッセージ
EOF
)"
```

pushした後は修正しない（--force が必要になり、危険）

### Q2. 複数のタスクを同時に進めたい

A. このフレームワークでは、1セッションで1タスクのみを扱います。

複数のタスクを進めたい場合は、複数のエージェントセッションを起動してください。

### Q3. コミットを取り消したい

A. 直前のコミット（pushする前）なら取り消し可能：

```bash
git reset --soft HEAD~1
# → コミットが取り消される（変更はstaged状態で残る）

git reset --hard HEAD~1
# → コミットと変更が全て取り消される（危険）
```

pushした後は取り消さない（他のエージェントに影響）

## まとめ

- **コミットメッセージ**: `[role-id] category-task_id: summary` 形式を厳守
- **コミット前**: テストを実行
- **push前**: `git pull --rebase`
- **コンフリクト**: ロックは引き下がる、ソースコードは解消
- **小さく頻繁に**: 大きな変更は複数のコミットに分ける

このプロトコルを守ることで、並列作業がスムーズに進みます。
