# Linear Workflow

Updated: 2026-06-28

## Purpose

Linear is the execution queue for work that AI can prepare and humans can review.

It is not the master archive and not the full project record.

## What goes into Linear

Put an item into Linear only if it needs action soon.

Good candidates:

1. Draft a follow-up note
2. Review a long attachment
3. Summarize meeting decisions
4. Prepare a request list
5. Compare document versions
6. Turn notes into a first draft

## What stays out of Linear

Keep these in Obsidian or source systems instead.

1. Full meeting records
2. Stable reference notes
3. Long-term ideas
4. Items with no owner
5. Items with no next action

## Status meaning

### `Inbox`

New item not yet triaged.

### `AI起案中`

AI can prepare the next version now.

### `人確認待ち`

AI output exists and needs judgment before the next move.

### `実行中`

Human or system work is in progress.

### `完了`

The requested output is done and any needed history is preserved.

## Daily rhythm

### Morning

1. Review `Inbox`
2. Promote only today's items
3. Move AI-ready work to `AI起案中`

### Midday

1. Clear short AI drafts
2. Push judgment items to `人確認待ち`

### End of day

1. Close finished items
2. Leave only real next actions
3. Move ambiguous items back to notes, not into backlog clutter

## Intake rules by source

### From Circleback

Accept only owned tasks with a concrete next action.

### From Obsidian

Promote only current work, not the full board.

### From GitHub

Create or link a Linear item when the work needs queue visibility.

### Manual

Use manual intake for urgent or judgment-heavy items.

## Good title format

Use short action titles.

Examples:

- `福井市 収集資料依頼の初稿を作る`
- `南小国 減額変更の説明文を確認する`
- `会議メモから次アクションを3件に絞る`

## Completion rule

Before closing:

1. The output exists
2. The next action is no longer open
3. Any reusable result or script change is captured in GitHub
4. Any project judgment is reflected in Obsidian if needed
