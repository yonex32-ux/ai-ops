# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

軽量な AI 運用システム（AI Ops）のシードリポジトリ。アプリケーションコードは無く、運用ドキュメント（Markdown）、計測用 PowerShell スクリプト、CSV ログで構成される。ビルド・lint・テストは存在しない。

役割分担（ツール間）:

- **Obsidian** — プロジェクト文脈・判断・状態の source of truth
- **Circleback** — 会議をタスク候補に変換
- **Linear** — AI が下準備できる作業の実行キュー（マスターアーカイブではない）
- **GitHub（このリポジトリ）** — 履歴、スクリプト、プロンプト、テンプレート、レビュー済み変更

## Commands

計測スクリプトは PowerShell 製で、スクリプト自身のディレクトリにある CSV に追記する。

```powershell
# タスク1件の効果を effect_log.csv に記録（タスク完了ごとに実行）
.\record_ai_effect.ps1 -Date 2026-06-28 -TaskType "triage" -TaskName "..." `
  -EstimatedManualMinutes 20 -ActualMinutes 8 -QualityScore 4 `
  -MistakePrevented $true -Workflow "reply-triage" -PluginsUsed "Gmail,Codex" -Notes "..."

# effect_log.csv を集計して KPI を出力（週次レビュー用）
.\summarize_ai_effect.ps1

# YouTube 学習候補を youtube_learning_queue.csv に追記
.\record_youtube_candidate.ps1 -Date ... -Topic ... -VideoTitle ... -Url ... -WhyWatch ...
```

## Architecture: 計測ループが中心

このリポジトリの核は「実行 → 記録 → 集計 → 週次レビュー」のループ。

1. `daily_runbook.md` に従って作業ブロックを実行する
2. タスク完了ごとに `record_ai_effect.ps1` で `effect_log.csv` に 1 タスク 1 レコード追記する
3. 週末に `summarize_ai_effect.ps1` で集計し、結果を `weekly_review.md` / `weekly_automation_review.md` に転記して拡大・修正・中止を判断する

`effect_log.csv` の `workflow` 列は固定の分類語彙を使う（`automation_priority_roadmap.md` で定義）: `reply-triage` / `file-intake` / `meeting-prep-followup` / `new-project-kickoff` / `budget-outsourcing-draft`。新しい値を勝手に増やさない。

ドキュメントの参照関係:

- `automation_priority_roadmap.md` — 自動化の優先順位と KPI の定義元（日本語・業務固有）
- `linear_workflow.md` — Linear に入れるもの/入れないもの、ステータス定義（`Inbox` → `AI起案中` → `人確認待ち` → `実行中` → `完了`）
- `github_linear_circleback_setup.md` — 初期セットアップ手順
- `prompt_templates.md` / `automation_prompt_pack.md` — 再利用プロンプト
- `notebooklm_youtube_workflow.md` + `youtube_learning_queue.csv` — 学習素材の取り込みフロー

## 実行時の判断ルール（automation_priority_roadmap.md より）

- 自動送信しない
- 自動削除しない
- 既存ファイルの上書きは確認後
- 判断が重いものは下書き止まり（final send / delete / publish / contract / payment は人間が行う）

## Skills

- `/memory-dream` — 記憶階層（この CLAUDE.md を含む記憶ファイル群）を定期的に再編し、重複・矛盾・陳腐化を除去する consolidation 手順。20〜30 セッション蓄積時や大規模改編後に実行する。

## Conventions

- ドキュメントは日本語と英語が混在する。既存ファイルの言語に合わせる。
- 日付は絶対日付（YYYY-MM-DD）で書く。「昨日」「先週」等の相対表現は使わない。
- 更新日を持つドキュメントは冒頭の `Updated:` 行を更新する。
- CSV はスクリプト経由で追記する（手編集で列順や引用符の形式を崩さない）。
