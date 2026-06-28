# Daily Runbook

## Morning

1. Review today's calendar.
2. Pull the files needed for the first meeting or work block.
3. Ask Codex for:
   - top 3 priorities
   - must-read materials
   - work that can be batched in the afternoon
4. Decide which tasks are:
   - human decision
   - AI draft
   - AI research
   - waiting

## During the day

Use Codex mainly for:

1. Finding past materials in Drive
2. Preparing meeting briefs
3. Summarizing long documents
4. Drafting replies for review
5. Turning notes into task candidates
6. Reviewing spreadsheets, PDFs, and Word drafts

Do not delegate final send, delete, publish, contract, or payment actions.

## After each useful task

Run:

```powershell
.\record_ai_effect.ps1 -Date 2026-06-28 -TaskType "slack_reply" -TaskName "Channel triage" -EstimatedManualMinutes 20 -ActualMinutes 8 -QualityScore 4 -MistakePrevented $true -Workflow "Slack triage" -PluginsUsed "Slack" -Notes "Reduced rereading and drafted 2 replies"
```

## End of day

1. Move unresolved work into the next queue.
2. Record one or more effect log entries.
3. Note repeated friction:
   - missing context
   - weak prompt
   - plugin gap
   - approval bottleneck
   - data access issue
