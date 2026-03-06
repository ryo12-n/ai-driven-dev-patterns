# トリアージ申し送り（2026-03-06）

## 次回トリアージへの申し送り事項

### 1. ISS-017/018 が3回連続未着手

- ISS-017: settings.json の充実（$schema・deny ルール追加）
- ISS-018: rules/ の paths 活用

3回連続で未着手のまま。次回トリアージで以下のいずれかを判断すること:
- 明示的なスキップ判断（理由を記載してクローズ）
- backlog 施策として着手開始

### 2. backlog 施策化率が0%のまま継続

backlog 18ファイルすべてが「候補」ステータス。initiatives/ への着手ゼロ。

リポジトリ分離がブロッカーとして指摘されているが、以下の施策は前提なく着手可能:
- 高度な並列化と協調プロトコル統合
- 全ロールファイル role-format-guide 準拠確認修正
- triage テンプレートのブラッシュアップ

次回トリアージで着手候補の優先順位づけを検討すること。

### 3. claude-directory 最適化の2施策は分離維持

当初統合候補だったが、検証の結果、対象リポジトリが異なる独立施策と判明:
- `claude-directory最適化(ai-driven-dev-patterns).md` — ルート側
- `claude-directory最適化.md` — dev-process-improvement 側

統合しないこと。
