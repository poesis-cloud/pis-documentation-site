---
layout: default
title: Agentic Harness
parent: SAF — the Systemic Agentic Framework
nav_order: 3
has_children: true
redirect_from:
  - /safe-agentic-framework/safe-as-the-harness/
---

# Agentic Harness

{: .no_toc }

The **Agentic Harness** is the deterministic execution core of the Systemic Agentic Framework. It resolves workflow steps, models, and the context of orchestrator and worker sessions (instructions and skills, injected when they open). It checks step conditions, write authorization and artifacts, and journals all of it, from persisted state and validated configuration only. The agents generate content, judge within a step and use host tools; the harness resolves, checks and records.

The harness does not orchestrate. The **orchestrator agent** converses with you, starts a workflow on your assent and dispatches its steps; the harness answers what comes next and whether each step delivered.

The harness core is **methodology- and host-agnostic**. It knows nothing of SAFe and nothing of any agent host: the embedding framework and the workspace are supplied as environment-anchored paths (`FRAMEWORK_DIR`, `FRAMEWORK_WORKSPACE_DIR`), and each host binding is a separate adapter with its own specification.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What ships

The harness is the Copilot plugin `poesis-saf-agentic-harness`, installed through the [Quickstart]({% link saf/quickstart.md %}). It ships:

- **the harness core**: the twelve functions, from `start-session` to `end-session`, driven by declarative workflow contracts with CEL conditions;
- **step transactions**: each step instance writes onto its own step ref, under artifact locks, and enters workspace state only by promotion;
- **the condition language**, type-checked when the configuration loads;
- **the recovery procedure** for a workflow instance an interrupted orchestrator session left busy;
- **JSON Schema contracts** for the configuration, the logs and the adapter bindings;
- **one host adapter**, `github-copilot`, for the Copilot CLI, the GitHub Copilot app and VS Code (Session Target: Copilot).

Requirements: Python 3.10 or later, Git 2.38 or later, and a Git identity in the governed workspace.

## What it does

- **Step resolution** — `resolve-step` returns the next eligible step of a workflow instance, deduced from the logs alone; no agent selects steps. A failed step is resolved again.
- **Model resolution** — `resolve-step-model` scores the framework's model catalogue against the step's declared capability weights and returns a canonical model profile; each host adapter maps that profile to a host model.
- **Context injection** — the orchestrator session receives its workflow instructions and skills when it opens; each worker session receives its step's instructions and skills.
- **Condition checks** — preconditions gate the dispatch of a step; delivery and postconditions decide its outcome. Conditions are written in a typed [condition language]({% link saf/agentic-harness/conditions.md %}).
- **Write governance** — every write is authorized against the access-control list, validated against its artifact schema, and committed onto the step instance's step ref; only a passing step instance is promoted into the workspace branch. See [Write governance]({% link saf/agentic-harness/write-governance.md %}).
- **Journaling** — every completed function call appends one entry to the log of the orchestrator or worker session it ran in (the few exceptions are listed in [Outcomes and refusal codes]({% link saf/agentic-harness/outcomes.md %})), so the delivery history is an audit trail, not a chat scrollback.

## How it is invoked

There is no general-purpose harness CLI for you to drive. `harness.py` is one entry point into the twelve functions (`python3 harness.py <function> [flags]`), and its callers are:

- **the host adapter's hooks**, which call `start-session`, `end-session`, the context functions and the check functions at the host's lifecycle events;
- **the orchestrator**, which asks for `resolve-step` and `resolve-step-model` with one plain command that the hook runs for it (see [How the orchestrator asks the harness]({% link saf/usage.md %}#how-the-orchestrator-asks-the-harness));
- **you**, in one case only: ending the orchestrator session that holds an interrupted workflow instance with `end-session` ([recovery procedure]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance)).

## Reference

- [Session model]({% link saf/agentic-harness/sessions.md %}) — orchestrator and worker sessions; workflow, step and artifact instances.
- [Functions]({% link saf/agentic-harness/functions.md %}) — the twelve functions at a glance.
- [Write governance]({% link saf/agentic-harness/write-governance.md %}) — authorization, validation, step refs, artifact locks, promotion.
- [Condition language]({% link saf/agentic-harness/conditions.md %}) — variables, the typing rule, examples.
- [Outcomes and refusal codes]({% link saf/agentic-harness/outcomes.md %}) — statuses, error codes, what to do.
- [Known alpha limitations]({% link saf/agentic-harness/limitations.md %}) — what the harness does not do yet.
- [Features]({% link saf/agentic-harness/features.md %}) — the capability catalogue with milestones.

## In the SAF solution

| Product | Role |
|---|---|
| **Agentic Harness** (this product) | the deterministic execution engine — methodology- and host-agnostic |
| [SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %}) | the SAFe-shaped framework application the harness executes |
| [Agentic Workspace]({% link saf/agentic-workspace/index.md %}) | the shared data plane the harness checks and commits into |

The canonical harness-core specification — terminology, invariants, the twelve-function contract, design and implementation — is [`def/core/spec.md`](https://github.com/poesis-cloud/saf-agentic-harness/blob/main/def/core/spec.md). The host binding has its own specification: [`github-copilot`](https://github.com/poesis-cloud/saf-agentic-harness/blob/main/def/adapter/github-copilot/spec.md).
