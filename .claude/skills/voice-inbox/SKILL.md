---
name: voice-inbox
description: 音声メモを文字起こしから文脈抽出し、既存workflowへ振り分け、判断軸を長期記憶に追記する取り込み手順
type: playbook
---

# voice inbox（音声受信箱の取り込み）

ポケット/会議で録った音声メモを、業務で使える文脈だけに絞って取り込み、その中の「米谷さんの判断軸」を継続的に蓄積するための呼び出し可能な手順。詳細フローは `voice_inbox_workflow.md`、蓄積先は `judgment_axis_profile.md`。音声は**入力チャネル**であり新しい workflow カテゴリではない。

## 正直な前提（このスキルの限界）

1. **AI は音声そのものを聞けない。** 抽出は文字起こし（テキスト）に対して行う。音声だけ渡された場合は、先に文字起こしの場所を尋ねる。
2. **AI はセッションをまたいで記憶しない。** 「学習」は暗黙記憶ではなく `judgment_axis_profile.md` に**書き残す**ことで実現する。
3. **常時録音はしない。** ポケット常時録音は同席者の無断録音になるため推奨しない。意図的なプッシュ録音を前提にする。

## 起動条件（いつ実施するか）

- ユーザーが「音声メモを取り込んで」「/voice-inbox」等と指示したとき
- `voice_inbox_queue.csv` に `status = received` かつ `transcript_location` が埋まった行があるとき
- 週次レビューで音声起点の未処理を掃除するとき

## 手順（5 ステップ）

1. **受信確認（Intake）** — `voice_inbox_queue.csv` を読み、対象メモの `transcript_location` を確認する。空なら「文字起こしの場所（Obsidian/Drive）」をユーザーに尋ねて止まる。音声しか無い場合はここで先に進めない。
2. **文字起こし読み込み（Transcript）** — `transcript_location` のテキストを読む。読めなければパスの誤りをユーザーに戻す。
3. **文脈抽出（Extract only what matters）** — 下の抽出テンプレで、必要な文脈だけを取り出す。雑談・言い淀み・私的な話は捨てる。結果を `context_summary` にまとめ、`status = extracted`。
4. **振り分け（Route）** — 抽出結果を既存システムへ:
   - 案件文脈・状態・判断 → **Obsidian**（source of truth）
   - AI が下準備できる作業 → **Linear**（`Inbox` 起票、`linear_workflow.md` に従う）
   - 判断の理由・優先順位 → **`judgment_axis_profile.md`**（ステップ5）
   `routed_to` に行き先を記録、`status = routed`。
5. **判断軸の追記（Learning loop）** — 「なぜそう決めたか」を `judgment_axis_profile.md` に追記する。**推測は事実にしない**: 未確認は「仮説（要確認）」へ置き、確認できたら「確定」へ移す。根拠（音声メモ日付）を必ず残す。

## 抽出テンプレ（ステップ3で使う）

```text
この文字起こしから、業務で必要な文脈だけを抽出してください。次に分けてください:
1. 案件/相手/日付などの事実
2. 決めたこと（決定事項）
3. 保留・要確認（未決）
4. 次にやること（タスク候補）
5. 判断の理由・優先順位（＝判断軸の手がかり）
雑談・言い淀み・私的な話・重複は捨ててください。
不確かな点は「不確か」と明示し、勝手に断定しないでください。
```

## 実行時の判断ルール（厳守）

- 自動送信しない / 自動削除しない
- 既存ファイル（Obsidian 含む）の上書きは確認後
- final send / delete / publish / contract / payment は人間が行う（下書き止まり）
- `judgment_axis_profile.md` へは推測を確定として書かない（仮説は仮説として書く）

## 捨てるもの

1. 私的・センシティブな会話（家族、健康、金銭の私事）
2. 同席者を特定できる無断録音の部分
3. 業務に転用しない雑談・独り言
4. すでに Obsidian にある重複情報

## 効果測定との接続

音声起点の作業が時短・より良い下書き・ミス予防・再利用テンプレ化につながったら、`record_ai_effect.ps1` で1件記録する。`workflow` 列は**音声用の新語を作らず**、流し込んだ先の既存値を使う（例: 音声メモ→返信下書きなら `reply-triage`）。

## チェックリスト

- [ ] `transcript_location` が埋まっているか確認した（空なら止めて尋ねた）
- [ ] 文字起こしを実際に読んで抽出した（音声を「聞いた」ことにしていない）
- [ ] 雑談・私的・無断録音部分を捨てた
- [ ] 抽出結果を Obsidian / Linear / profile へ振り分け、`routed_to` を記録した
- [ ] 判断シグナルを仮説/確定を分けて `judgment_axis_profile.md` に追記した
- [ ] `voice_inbox_queue.csv` の `status` を更新した
- [ ] 該当すれば `effect_log.csv` に既存 workflow 値で1件記録した

## 参考

- `voice_inbox_workflow.md` — フロー全文
- `voice_inbox_queue.csv` + `record_voice_note.ps1` — 受信ログ
- `judgment_axis_profile.md` — 判断軸の長期記憶
- `linear_workflow.md` — Linear のステータス定義
