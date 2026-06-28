# 自動化 週間チェックリスト

Updated: 2026-06-28

## 毎朝

1. タスクボードの `今日はこれ` と `クリティカルパス` を確認
2. `reply-triage` を回す
3. 停滞案件があれば下書きだけ先に作る

## 昼

1. 受信箱ファイルが 3件以上なら `file-intake` を回す
2. 翌日会議があれば `meeting-prep-followup` の前半を回す

## 夕方

1. `reply-triage` を再実行
2. その日一番効いた1件を `effect_log.csv` に記録
3. 未処理の添付があれば翌朝に持ち越さず分類だけ済ませる

## 週末

1. `summarize_ai_effect.ps1` を実行
2. `automation_kpi_tracker.csv` を埋める
3. 継続するものと止めるものを決める
