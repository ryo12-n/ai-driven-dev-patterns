# トリアージセッションのtodo管理義務化

## 気づき

20260306 トリアージセッションで、todoリスト（TodoWrite）による進捗追跡がセッション途中からしか行われなかった。セッション全体のライフサイクルステップを開始時点からtodoに登録し、各ステップの完了を追跡すべき。

## 提案

triage-manager SKILL.md の作業フローに「セッション開始時にtodoリストを作成する」ステップを追加する。

### todoに含めるべきステップ（例）

1. セッションフォルダ作成
2. 事前調査（00_pre_investigation.md）
3. 実施計画（01_plan.md）
4. ワーカーセット作成・ディスパッチ
5. レポート集約（03_report.md）
6. アクション実施（inbox処理・backlog作成・ルール反映等）
7. コミット・プッシュ
8. PR作成

## 対象

- `dev-process-improvement/.claude/skills/triage-manager/SKILL.md`
- 同様の改善を l1-manager にも横展開できる可能性あり

## 発見元

20260306 トリアージセッション
