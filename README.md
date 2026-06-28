# AI Ops Starter

Updated: 2026-06-28

This folder is the local seed for a lightweight AI operations system.

## Role split

- `Obsidian`
  Source of truth for project context, judgments, and status.
- `Circleback`
  Turns meetings into task candidates.
- `Linear`
  Execution queue for AI-preparable work.
- `GitHub`
  History, scripts, prompts, templates, and reviewed changes.

## Recommended rollout order

1. Create GitHub and Linear accounts.
2. Create one GitHub repository from this folder.
3. Create one Linear workspace and one team.
4. Run the queue in Linear for one week.
5. Add Circleback only after the queue feels stable.

## Key files

- `github_linear_circleback_setup.md`
  Step-by-step setup order and first-day checklist.
- `linear_workflow.md`
  Status design, intake rules, and operating rhythm.
- `daily_runbook.md`
  Daily execution flow.
- `prompt_templates.md`
  Reusable requests for Codex.
- `weekly_review.md`
  Weekly review template.
- `effect_log.csv`
  Structured effect measurement log.
- `record_ai_effect.ps1`
  Appends one measured work item to the CSV.
- `summarize_ai_effect.ps1`
  Reads the CSV and outputs simple KPIs.

## How to use

1. Follow `github_linear_circleback_setup.md` to create accounts and connect tools.
2. Use `linear_workflow.md` to define what enters the queue and what stays out.
3. Use `daily_runbook.md` to decide which work blocks to run with Codex.
4. When a task ends, run `record_ai_effect.ps1`.
5. At the end of the week, run `summarize_ai_effect.ps1`.
6. Copy the results into `weekly_review.md` and decide what to expand, fix, or stop.

## What to measure

Measure only a few things consistently.

1. Estimated manual minutes
2. Actual minutes with Codex
3. Minutes saved
4. Whether quality improved
5. Whether a mistake was prevented
6. Which workflow or tool was used

## Recommended first workflows

1. Meeting follow-up to task creation
2. Calendar-driven daily planning
3. Google Drive document retrieval
4. Review and draft work
5. Linear queue triage
