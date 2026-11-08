---
layout: default
title: Outcomes and refusal codes
parent: Agentic Harness
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 6
---

# Outcomes and refusal codes

{: .no_toc }

Every harness function answers with a report whose `outcome.status` is either a success status of that function or one of four shared error statuses. Error statuses carry an `error` object with a `code`, a `message` and a retryable flag. The codes below are normative: implementations may add codes but never repurpose these. Messages are advisory prose.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Success statuses

| Function | Statuses |
|---|---|
| `start-session` | `started`, `not-applicable` |
| `resolve-workflow-instructions`, `resolve-workflow-skills`, `resolve-step-instructions`, `resolve-step-skills` | `resolved` |
| `resolve-step` | `step-resolution`, `no-next-step` |
| `resolve-step-model` | `resolved`, `not-applicable` |
| `check-step-preconditions` | `pass`, `fail`, `not-applicable` |
| `check-step-authorization` | `allowed`, `denied` |
| `check-step-artifact` | `valid`, `reverted` |
| `check-step-postconditions` | `pass`, `fail`, `not-applicable`; with `promotion: promoted` or `withheld` |
| `end-session` | `ended` |

`fail`, `denied` and `reverted` are normal answers, not errors: a precondition failed, a write was refused (see the [denial causes]({% link saf/agentic-harness/write-governance.md %}#authorization-function-8)), a write was invalid.

`not-applicable` means persisted state names no target for the call: `start-session` for a dispatch that is not a framework step, or a root agent that is not a framework orchestrator; functions 4, 5 and 10 when the calling orchestrator session has no step in flight (which also absorbs a duplicate step-ended signal). It is never journaled, and the hooks let the call through untouched.

`no-next-step` only observes that every step currently has a passing step instance. The harness never declares a workflow complete: that judgment is yours, at the user gate.

## Error statuses

| Status | Assigned to |
|---|---|
| `inquiry-error` | everything wrong with the request itself: it fails its contract, names an unknown workflow, or is illegitimate where it is made |
| `state-error` | persisted state contradicts an otherwise legitimate request |
| `configuration-error` | configuration found invalid while a function runs; normally the load refuses it first (exit 3) |
| `system-error` | the environment fails: Git, the disk, the logs |

## Refusal codes

| Code | Status | Raised by | Meaning | Journaled | What to do |
|---|---|---|---|---|---|
| `invalid-inquiry` | `inquiry-error` | any function | the request fails its input contract (for example a malformed `sessionId`) | no: exit 1, no report | an adapter or install defect; re-run the installer |
| `unknown-workflow` | `inquiry-error` | `resolve-step` | the workflow slug is not in the catalogue | yes | the orchestrator asks again with a catalogue slug |
| `not-facilitator` | `inquiry-error` | `resolve-step` | the calling agent is not the workflow's orchestrator, for example a bench agent asking the harness | yes | only the workflow's orchestrator asks |
| `session-unregistered` | `inquiry-error` | functions called for an orchestrator or worker session | the calling orchestrator or worker session is not registered | no (no log exists) | check that the hooks run, then open a new conversation with the orchestrator |
| `session-ended` | `state-error` | functions 0–10 | the calling orchestrator or worker session has already ended | no | open a new conversation with the orchestrator |
| `session-conflict` | `state-error` | `start-session` | a re-registration names a different agent for the same id | yes | a host or adapter defect; identities never change |
| `session-kind-mismatch` | `state-error` | functions 1–2 and 6–7 | an orchestrator function called from a worker session, or the reverse | yes | a host or adapter defect |
| `step-correlation-missing` | `state-error` | functions 6–7 | the worker session correlates to no unresolved step resolution | yes | a host or adapter defect, or an out-of-order call |
| `step-in-flight` | `state-error` | `resolve-step` | the orchestrator session already has a step in flight | yes | wait for the step's outcome, then ask again |
| `session-instance-bound` | `state-error` | `resolve-step` | the orchestrator session already drives a workflow instance of another workflow | yes | run the other workflow in a new conversation |
| `workflow-instance-busy` | `state-error` | `resolve-step` | another orchestrator session, not ended, holds an unfinished step resolution in this workflow instance | yes | follow [Recovering an interrupted workflow instance]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance) |
| `worker-session-bound` | `state-error` | `start-session` | the step resolution already registered its one worker session | no (the refused worker session has no log) | never re-dispatch a step; after a failure, the orchestrator asks `resolve-step` again |
| `condition-evaluation-failed` | `state-error` | functions 5 and 10 | a CEL expression failed while evaluating (not a false result); the message names the condition | yes | fix the condition in the workflow configuration |
| `artifact-schema-unresolved` | `state-error` | `check-step-artifact` | a written path resolves to no artifact schema; the whole set is discarded | yes | abnormal: function 8 should have denied it |
| `step-rebase-conflict` | `state-error` | `check-step-postconditions` | the step ref cannot be rebased onto the moved workspace branch, or the branch moved before the compare-and-swap | yes | nothing: the step instance is withheld and the step comes back; its retry starts from the new branch tip |
| `log-unreadable` | `system-error` | any function | a log cannot be opened (retryable) or is not valid JSONL log entries (not retryable) | when the log is writable | check the workspace's `logs/` folder |
| `log-creation-failed`, `log-append-failed` | `system-error` | any function | the log entry could not be written; the report is still returned, the entry is lost | no | check disk space and permissions |

## What journaled means

A completed call appends one entry to the log of the orchestrator or worker session it ran in. The exceptions are the ones the table marks: `not-applicable`, the `session-ended` refusal (no entry ever follows an ending entry), refusals with no log to write to (`session-unregistered`, `worker-session-bound`), and contract failures, which produce no report at all. An unclassified failure surfaces as `harness: system-error: …` on stderr with exit 4.

## How the answers reach the agent

In both hosts, the orchestrator's `resolve-step` and `resolve-step-model` reports arrive as a hook **denial** whose reason starts with `SAFe agentic harness RESULT (<function>)`; that is the successful answer, whatever its status. A reason starting with `SAFe agentic harness REJECTED` means the hook refused the request itself (wrong command form, a bench agent asking, an ungoverned conversation) and names the accepted line.

A hook that cannot start at all (moved checkout, malformed `.env`, unbound model, unreadable payload) exits 2. The host treats that as blocking: the tool call is denied, and the diagnostic is on the hook's stderr.
