---
layout: default
title: Functions
parent: Agentic Harness
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 3
---

# Functions

{: .no_toc }

Everything the harness exposes is exactly one of twelve functions, numbered in the order they occur in a workflow instance. Every log entry names the function that produced it.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## The twelve functions at a glance

| # | Function | What it answers | When | Called by |
|---|---|---|---|---|
| 0 | `start-session` | Which orchestrator or worker session just opened, under which parent? For a worker session, it also creates the step ref. | An orchestrator or worker session opens | hook |
| 1 | `resolve-workflow-instructions` | Which workflow instructions does the orchestrator session load? | The orchestrator session opens | hook |
| 2 | `resolve-workflow-skills` | Which skills does the orchestrator session load? | The orchestrator session opens | hook |
| 3 | `resolve-step` | What is the next eligible step of this workflow instance, or is there none (`no-next-step`)? | On assent, then after each step outcome | orchestrator (run by the hook) |
| 4 | `resolve-step-model` | Which model profile serves this step's dispatch? | Between resolution and dispatch | orchestrator (run by the hook) |
| 5 | `check-step-preconditions` | May this step start? | At dispatch; a fail denies the dispatch | hook |
| 6 | `resolve-step-instructions` | Which instructions does the step's worker session load? | The worker session opens | hook |
| 7 | `resolve-step-skills` | Which skills does the step's worker session load? | The worker session opens | hook |
| 8 | `check-step-authorization` | Is this write a granted privilege of the acting agent? Claims the artifact lock. | Before every write | hook |
| 9 | `check-step-artifact` | Is the written artifact schema-valid? Commits it onto the step ref, or reverts it. | After every write | hook |
| 10 | `check-step-postconditions` | Did this step deliver? Promotes the step instance, or withholds it. | When the dispatch returns | hook |
| 11 | `end-session` | Which orchestrator or worker session just ended? Closes its log. | When the host lets the adapter observe the end (best-effort) | hook; you, during [recovery]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance) |

Grouped by scope:

- **Orchestrator and worker sessions (0, 11)** — open and close an orchestrator or worker session and its log.
- **Workflow context (1–2)** — the orchestrator's instructions (selection, step-resolution handling, reports handling, `no-next-step` handling) and its procedure skills.
- **Resolution (3–4)** — pure functions over the logs and the configuration; they read no artifacts.
- **Step (5–10)** — in step order: gate the dispatch, inject the step's context, guard every write, evaluate delivery and promote.

## Inputs and reports

Every function takes the same envelope: the `sessionId` and nullable `parentSessionId` of the calling orchestrator or worker session, supplied by the hook and never by the agent. A few functions add one field: `agent` (function 0), `workflowSlug` (function 3, the only agent-supplied parameter of the whole contract), `artifactPath` and `action` (function 8), `artifactPaths` (function 9).

Every function answers with a **report**: a `context` (`function`, `sessionId`, `parentSessionId`, `workflowInstanceId`), an `outcome` (`status`, plus an `error` object on error statuses), and its own payload. The report is persisted byte for byte as the log entry. The statuses are listed in [Outcomes and refusal codes]({% link saf/agentic-harness/outcomes.md %}).

The JSON Schemas live in the repository under [`contracts/api/`](https://github.com/poesis-cloud/saf-agentic-harness/tree/v1.0.0-alpha.1/contracts/api).

## The command line

`harness.py` is the single entry point:

```bash
python3 harness.py <function> --session-id <id> [--parent-session-id <id>] [function flags]
```

It needs `FRAMEWORK_DIR` (and the layout the framework's `.env` declares) in its environment. The adapters' hooks set both; you only use it directly to run the `end-session` command the harness prints during [recovery]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance).

Exit codes when no report can be returned:

| Exit | Meaning |
|---|---|
| 1 | The inquiry fails its input contract (`invalid-inquiry`) |
| 2 | Usage: no function, an unknown one, or `FRAMEWORK_DIR` unset |
| 3 | The configuration is invalid at load |
| 4 | An unclassified failure (`harness: system-error: …` on stderr) |

## Configuration is checked before any function runs

Every invocation loads and validates the whole configuration first: the layout from `.env`, the access-control list, the model catalogue, the workspace layout, the workflow catalogue, and every condition. A violation stops the invocation before any function runs: exit 3, with `harness: configuration-error: <code>: <message>` on stderr. The rules include unique step and condition slugs, resolvable step references, acyclic step graphs, actors that exist in the access-control list, artifact slugs that resolve to schemas, instruction and skill references that resolve to files, and the [condition typing rule]({% link saf/agentic-harness/conditions.md %}#typing-checked-at-configuration-load).
