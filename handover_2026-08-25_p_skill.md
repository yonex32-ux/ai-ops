# 引き継ぎ書: /p スキル（マイタスク プライベートリスト ランナー）

Updated: 2026-08-25

リモートセッションからローカルセッションへの引き継ぎ。
このファイルを読めば、途中から続きができる状態にしてある。

## 何をしていたか

マイタスク（`mytasks.yonetani32ai.workers.dev`）の**プライベートリスト**のタスクを
番号で実行する `/p` スキルを作った。既存の `/t`（リスト限定なし）と対になるコマンド。

- `/p 296` `/p296` `/p MYT-0296` → MYT-0296 をそのまま実行
- `/p 296 293` → 順に1件ずつ実行
- `/p`（番号なし）→ プライベートの未完了一覧を出して番号を選ばせる
- 指定番号が `private` 以外のリストなら実行せず確認する（仕事リストは `/t` の担当）

## 現在の状態

| 項目 | 状態 |
|---|---|
| ブランチ | `claude/mytask-private-execution-v9r8io`（push 済み、commit 3件） |
| PR | https://github.com/yonex32-ux/ai-ops/pull/2 — **open / draft**、コンフリクトなし、CI なし、レビューコメントなし |
| スキル本体 | `.claude/skills/p/SKILL.md`（commit 済み） |
| セットアップ指示書 | `p_skill_setup.md`（commit 済み） |
| 動作確認 | 済。MCP 経由で `list_lists` / `list_tasks(list="private")` を実行し、`/p` を起動して一覧表示まで確認した |
| claude.ai への恒久登録 | **未完了**（下記「残タスク」） |

## 残タスク

### 1. /p を claude.ai の Skills に登録する（MYT-0298、`in_progress`）

これが唯一の未完了項目。ai-ops 以外のディレクトリでも `/p` を使うために必要。

- 手順は `p_skill_setup.md` の「方法1」に書いてある
- アップロードする zip は Google ドライブのマイドライブ直下に **`p-skill.zip`**（3,267 バイト）として置いてある
  https://drive.google.com/file/d/1l2cEmL5dq4QytRQ6j3NpoubGJ7IIe-Oi/view
- zip の中身は `p/SKILL.md` の構成。claude.ai → Settings → Capabilities → Skills → Upload skill
- アップロード後、**新しいセッションを開き直して** `/p` がスラッシュメニューに出るか確認する
- 確認できたら MYT-0298 を `complete_task` で完了にする

**この操作は Claude 側から実行できない**（ブラウザ操作ツールも claude.ai のスキル登録 API も無い）。
本人の手作業が必要。claude-in-chrome が使えるローカルセッションなら代行できる可能性はある。

### 2. PR #2 のレビューとマージ

draft のまま。内容を確認して問題なければ ready にしてマージする。

## つまずいた点（同じことで悩まないように）

- **スキルを作ったセッションでは `/` メニューに `/p` が出ない**。スラッシュコマンドの一覧は
  セッション開始時に読み込まれるため。新しいセッションを開き直せば出る。
  メニューに出なくても、文章として `/p 296` と打てば拾われる
- リポジトリ内の `.claude/skills/p/` は **ai-ops を開いたセッションでしか効かない**
- リモートコンテナの `/root/.claude/skills/p/` に入れたものは**セッション終了で消える**

## 設計上の決定（変更するなら理由を残すこと）

- 番号指定を主動線にした（`/t` と同じ操作感にするため）
- `note` が空・`readiness.missing` があっても止まらず、タイトルから推測して下準備を進める。
  手戻りになる要点だけ質問する（全項目の穴埋め質問はしない）
- `automation_priority_roadmap.md` の判断ルールをスキルに明記：
  自動送信しない / 自動削除しない / 上書きは確認後 / 注文・支払い・契約は下書き止まり。
  `risk_level` B・C は最後の一押しを本人に渡す

## リモート側で動いていたもの（引き継ぎ後は止まる）

PR #2 の状態を1時間おきに再チェックする self check-in を仕掛けていた。
これはリモートセッションに紐づいているので、そちらへ移った時点で止まる。
ローカルで監視を続けたい場合は改めて設定する。

## 参照

- スキル本体: `.claude/skills/p/SKILL.md`
- セットアップ手順: `p_skill_setup.md`
- PR: https://github.com/yonex32-ux/ai-ops/pull/2
- 登録タスク: MYT-0298
