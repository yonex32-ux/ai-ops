# GitHub + Linear + Circleback Setup

Updated: 2026-06-28

## Goal

Use:

- `GitHub` for history
- `Circleback` for meeting-to-task intake
- `Linear` for the AI execution queue
- `Obsidian` for project truth

## Account creation order

1. Create a GitHub account.
2. Create a Linear account.
3. Create a Circleback account.

## First-day setup

### 1. GitHub

Create one repository:

- Repository name: `ai-ops`
- Visibility: `Private`
- Description: `AI operations prompts, scripts, templates, and reviewed workflow changes`

Push this local folder into that repository after the account is ready.

### 2. Linear

Create:

- Workspace: `Yonetani AI Ops`
- Team: `AI Ops`

Statuses:

1. `Inbox`
2. `AI起案中`
3. `人確認待ち`
4. `実行中`
5. `完了`

Priorities:

- `P1` Today
- `P2` This week
- `P3` Later

Recommended properties:

- `Source`
  Values: `Circleback`, `Manual`, `Obsidian`, `GitHub`
- `Work type`
  Values: `draft`, `research`, `review`, `ops`
- `Owner`
  Keep this simple at the start

### 3. Circleback

Connect Circleback to Linear only.

Initial rule:

- Send tasks only to `AI Ops`
- Default status: `Inbox`

Only create tasks when all of these are true:

1. The owner is clear
2. The next action is clear
3. The work is actually needed
4. The item can be acted on within 1 to 2 weeks

Do not auto-create tasks for:

1. Background discussion
2. Unowned ideas
3. Long-term possibilities
4. Notes with no next action

## GitHub structure

Keep the repository small at the start.

1. `README.md`
2. `daily_runbook.md`
3. `linear_workflow.md`
4. `prompt_templates.md`
5. `weekly_review.md`
6. `.github/ISSUE_TEMPLATE/ai-task.md`

## First test

Run one test item only.

Example:

- Meeting note: `Prepare follow-up summary format`
- Circleback creates one task in Linear
- Linear moves it from `Inbox` to `AI起案中`
- Work output or script change is captured in GitHub

## Success criteria for week 1

1. At least 3 real tasks entered Linear
2. At least 1 task came from a meeting
3. At least 1 GitHub issue or change captured real work history
4. The queue stayed short enough to review in under 10 minutes

## Do not do in week 1

1. Do not mirror every Obsidian task into Linear
2. Do not treat GitHub and Linear as equal task masters
3. Do not auto-send or auto-close anything externally
4. Do not create more than one team
