# 施策候補: m6o-es-product-api ドキュメント移動実施

## 背景・課題

「m6o-es-product-api ドキュメント整理」施策（フェーズ1）にて、`my_work/` 配下 86 件のファイルについて新ディレクトリ構造の設計と移動先マッピング表を作成した。
本施策はその設計を実際のファイル操作として反映するフェーズ2にあたる。

設計成果物は `initiatives/_archive/m6o-es-product-apiドキュメント整理/design.md` に格納されており、マッピング表をそのまま使用してファイル移動を実行できる状態にある。

## 期待される効果

- `my_work/` 配下の混在状態が解消され、AI用/人間用/参考資料 の区分で整理される
- `.claude/rules/` に AI 向けコンテキストファイルが集約され、Claude が適切に参照できるようになる
- `docs/` に人間向けドキュメントが集約され、発見性が向上する
- 将来の資料追加時に「どこに置くか」が明確になる

## スコープ（予定）

### やること

- 新ディレクトリ（`.claude/rules/`・`.claude/tools/`・`docs/design/`・`docs/process/`・`docs/re/`・`refs/poc/`・`refs/impl-history/`・`refs/process-history/`）の作成
- `design.md` のマッピング表に従ったファイル移動
- `.claude/rules/` 配置ファイルの kebab-case 英語名への改名
- `CLAUDE.md` 内の `my_work/` パス参照を新パスへ更新

### やらないこと

- `.claude/rules/` ファイルの内容整備・書き直し（別施策: ISS-016）
- ソースコード変更

## 優先度

**高**（フェーズ1完了を受けて着手可能な状態。設計成果物が陳腐化する前に実施する）

## 参照先

- 設計書: `initiatives/_archive/m6o-es-product-apiドキュメント整理/design.md`
- フェーズ1ゲート判定: `initiatives/_archive/m6o-es-product-apiドキュメント整理/08_gate_review.md`
- 関連課題: ISS-015（プロセス改善_課題管理.csv）

## 申し送り事項（フェーズ1 08_gate_review.md より）

1. `design.md` のマッピング表を正として参照すること（`04_work_report.md` のファイル数 73件は誤り。正しくは 86件）
2. ディレクトリ作成を先行してからファイル移動を行うこと
3. `.claude/rules/` 配置ファイルは kebab-case 英語名に改名すること
4. ファイル移動後は `CLAUDE.md` 内のパス参照を新パスに更新すること

---
**起票者**: L1
**起票日**: 2026-02-27
**ステータス**: 候補
