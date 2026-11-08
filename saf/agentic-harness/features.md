---
layout: default
title: "Agentic Harness Features"
parent: Agentic Harness
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 1
---

# Agentic Harness Features
{: .no_toc }

Capability catalogue for the Agentic Harness.

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{% include milestone_legend.md %}

---

## Capabilities

Every capability below ships in the current pre-release, on the way to v1.0 (MVP/GA). A pre-release is not production-ready: see [Known alpha limitations]({% link saf/agentic-harness/limitations.md %}).

| Feature | Representative content | Milestone |
|---------|------------------------|-----------|
| Workflow & step resolution | `resolve-step` deduces the workflow instance and its next eligible step from the logs alone; a failed step is resolved again | Pre-release ✓ · target v1.0 (MVP/GA) |
| Skill and instruction prompt injection | Workflow instructions and skills injected into the orchestrator session, step instructions and skills into each worker session, when they open | Pre-release ✓ · target v1.0 (MVP/GA) |
| LLM resolution | `resolve-step-model` scores the model catalogue against each step's capability weights; each adapter binds the profile to a host model and refuses an unbound catalogue | Pre-release ✓ · target v1.0 (MVP/GA) |
| Condition checks | Preconditions gate the dispatch; delivery and postconditions decide the step outcome; a typed [condition language]({% link saf/agentic-harness/conditions.md %}) checked at configuration load | Pre-release ✓ · target v1.0 (MVP/GA) |
| Agent authorization | Every write authorized per path and per action against the access-control list; deletion denied in v1 | Pre-release ✓ · target v1.0 (MVP/GA) |
| Artifact validation | The writes of one tool call validated as one set against JSON Schema contracts; a valid set becomes one commit, an invalid one is reverted whole | Pre-release ✓ · target v1.0 (MVP/GA) |
| Step transactions | Step refs, artifact locks, and promotion of a passing step instance by one compare-and-swap ([Write governance]({% link saf/agentic-harness/write-governance.md %})) | Pre-release ✓ · target v1.0 (MVP/GA) |
| Logging | One append-only JSONL log per orchestrator or worker session; one entry per completed function call | Pre-release ✓ · target v1.0 (MVP/GA) |
| Recovery | `workflow-instance-busy` names the holding orchestrator session and prints the `end-session` command that releases the workflow instance | Pre-release ✓ · target v1.0 (MVP/GA) |
| Host adapters | One `github-copilot` adapter for the Copilot CLI, the GitHub Copilot app and VS Code (Session Target: Copilot) | Pre-release ✓ · target v1.0 (MVP/GA) |

Not yet: deletion of governed artifacts (declared in the privilege vocabulary, denied in v1), and concurrent workflow instances (a non-goal for now).
