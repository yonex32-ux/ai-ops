# NotebookLM YouTube Workflow

Updated: 2026-06-28

## Goal

Turn useful YouTube videos into reusable knowledge for work.

## Recommended pattern

1. Queue the YouTube URL locally.
2. Add it to a NotebookLM notebook.
3. Let NotebookLM index the transcript.
4. Pull out:
   - summary
   - claims
   - numbers
   - workflow ideas
   - reusable prompts
5. Save only the high-value output back into the normal work system.

## Best use cases

1. AI tool usage ideas
2. Product or workflow demos
3. Water industry interviews or talks
4. Meeting, writing, or planning methods
5. Software walkthroughs worth reusing later

## Do not use it for

1. Generic motivational content
2. Videos without clear work relevance
3. Content you will never operationalize

## Standard flow

### Step 1

Append candidate videos to `youtube_learning_queue.csv`.

### Step 2

Use NotebookLM to add the URL as a source.

Expected source type: `url`

Expected content extracted: transcript or page content

### Step 3

Ask for a structured extraction.

Suggested request:

```text
この動画から、業務で再利用できる実践論点だけを抽出してください。要約、重要な主張、具体例、すぐ試せる運用、注意点、私の業務に合う使い方に分けてください。
```

### Step 4

Record one effect entry in `effect_log.csv` if the video led to:

- a faster workflow
- a better prompt
- a prevented mistake
- a repeated task template

## Notebook structure recommendation

Use three notebooks instead of mixing everything.

1. `YT_AI_Workflows`
   AI tools, Codex, automation, prompts
2. `YT_Water_Industry`
   water, PPP/PFI, utility, policy, case studies
3. `YT_Tool_Demos`
   product walkthroughs and software how-tos

## Weekly review

At the end of the week:

1. Count videos added
2. Count videos that produced a reusable workflow
3. Count videos that produced no action
4. Keep only the channels and topics with a high conversion rate
