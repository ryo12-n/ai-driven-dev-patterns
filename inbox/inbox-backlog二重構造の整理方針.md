# inbox/backlog 二重構造の整理方針検討

## 起票日
2026-03-04

## 背景
ai-driven-dev-patterns 直下に `inbox/` `backlog/` を新設したが、`dev-process-improvement/` 配下にも同名のディレクトリが存在する。現状はそれぞれ独立した管理単位。

- ai-driven-dev-patterns 側: 開発知見のバッファ（dev_manager のルーティング先）
- dev-process-improvement 側: プロセス改善の施策管理（L1/L2 フロー）

## 懸念
将来的に用途の混乱が生じる可能性がある。

## 現時点の方針
当面は二重構造を許容する。用途が異なるため README.md でスコープを明記して運用する。

## トリアージで判断してほしいこと
- 統合の必要性が出た時点で施策化するか、現状の分離運用を維持するか
- README.md のスコープ説明で十分か、命名変更等の対策が必要か

## 関連
- ISS-031（プロセス改善_課題管理.csv）
- 元施策: ai-driven-dev-patternsの改善サイクル整備
