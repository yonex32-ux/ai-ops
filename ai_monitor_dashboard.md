# AI社員 監視ダッシュボード

Updated: 2026-06-29

AI社員（各ワークフロー）が「今どのタスクで、どんな状態で働いているか」をひと目で監視するための仕組み。

## 何が見えるか

- **AI社員ごとの稼働状況カード** — 現在のタスクと状態（稼働中 / 確認待ち / 待機 / 完了）
- **稼働ログ（タイムライン）** — 誰がいつ何をしたかの時系列
- **効果サマリー** — `effect_log.csv` から短縮時間・品質・ミス予防を集計

「稼働中」のAI社員はカードのバッジが緑に点滅し、働いている様子が分かる。

## AI社員（ワークフロー）の対応

| AI社員 | workflow | 役割 |
| --- | --- | --- |
| 返信担当 | `reply-triage` | メール・サイボウズ返信下書き |
| 仕分け担当 | `file-intake` | 添付ファイルの案件仕分け |
| 会議担当 | `meeting-prep-followup` | 会議前ブリーフ・会議後タスク化 |
| 立ち上げ担当 | `new-project-kickoff` | 新規案件の資料リスト・段取り |
| 申請担当 | `budget-outsourcing-draft` | 実行予算・外注・変更申請の下書き |

## ファイル構成

- `activity_log.csv` — 稼働イベントのログ（監視の生データ）
- `record_activity.ps1` — 稼働イベントを1行追記する
- `dashboard_template.html` — ダッシュボードのテンプレート（編集はこちら）
- `build_dashboard.ps1` — CSVを読み込み `ai_monitor_dashboard.html` を生成
- `ai_monitor_dashboard.html` — 生成済みダッシュボード（ブラウザで開く）

## 使い方

### 1. 稼働状況を記録する

AI社員にタスクを始めさせる／状態が変わるたびに記録する。

```powershell
# タスク開始
.\record_activity.ps1 -Employee "返信担当" -Workflow "reply-triage" -Status "稼働中" -Task "朝の返信トリアージ" -Detail "Gmailとサイボウズの未返信を確認中"

# 人の確認待ちになった
.\record_activity.ps1 -Employee "会議担当" -Workflow "meeting-prep-followup" -Status "確認待ち" -Task "会議前ブリーフ" -Detail "論点メモを作成、人の確認待ち"

# 完了
.\record_activity.ps1 -Employee "返信担当" -Workflow "reply-triage" -Status "完了" -Task "朝の返信トリアージ" -Detail "返信下書き3件を作成"
```

状態は `稼働中` / `確認待ち` / `待機` / `完了` の4つ。`linear_workflow.md` のステータス設計と対応する。

### 2. ダッシュボードを生成して開く

```powershell
.\build_dashboard.ps1 -Open
```

`ai_monitor_dashboard.html` が更新され、既定のブラウザで開く。
データを変えたら再実行すれば最新状態に更新される。

## 運用のヒント

- `daily_runbook.md` のルーチンに「タスク開始時／確認待ち／完了時に `record_activity.ps1` を打つ」を足すと、ログが自然に貯まる。
- 効果サマリーは `effect_log.csv` を元にするので、タスク完了時に `record_ai_effect.ps1` も忘れずに。
- ブラウザを開きっぱなしにし、`build_dashboard.ps1` を朝夕に流せば簡易的な稼働モニタになる。
