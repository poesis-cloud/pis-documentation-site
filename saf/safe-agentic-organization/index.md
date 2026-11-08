---
layout: default
title: SAFe Agentic Organization
parent: SAF — the Systemic Agentic Framework
nav_order: 4
has_children: true
redirect_from:
  - /safe-agentic-framework/distributed-agentic-safe/
---

# SAFe Agentic Organization
{: .no_toc }

The **SAFe Agentic Organization** is the SAFe-shaped framework application the [Agentic Harness]({% link saf/agentic-harness/index.md %}) executes: 14 agents, 37 skills, 25 workflows, their instructions, and the JSON Schemas and templates of every artifact kind. It is not one agent that "does Scrum". It is a *distributed* system: SAFe governance is split across specialized agents at three layers, and the work state is externalized to committed artifacts in a Git repository. We call this model **Distributed Agentic SAFe**, to contrast it with *centralized* agentic, where a single monolithic agent tries to hold the whole lifecycle in one context window.

This page describes the organization's `main` branch. The [Quickstart]({% link saf/quickstart.md %}) installs it as the Copilot plugin `poesis-saf-agentic-organization`. Its repository is [`poesis-cloud/saf-agentic-organization`](https://github.com/poesis-cloud/saf-agentic-organization).

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Centralized vs. distributed

| Axis | Centralized agentic | **Distributed Agentic SAFe** |
|---|---|---|
| Orchestration | one monolithic agent owns the whole lifecycle | **3 layer orchestrators** + a specialist bench |
| Context | a single shared memory | **no shared memory**: committed artifacts are the bus |
| State | implicit, in-chat, lost on reset | **externalized** as committed artifacts; Git history is the event log |
| Execution | the agent decides what to do next | the **harness resolves every step**; one worker per step, one artifact per step |
| Models | one model does everything | **deterministic per-step routing** by capability score |
| Human control | ad hoc, easy to bypass | a **human gate at the end of every workflow**; the human is the value authority |
| Scaling | vertical (bigger prompt, bigger context) | **horizontal** (divide and conquer, one unit at a time) |

---

## The orchestrators

You talk to one orchestrator per layer. Each writes, or thickens, work items of **its layer's grain**, inside the matching SAFe activity:

| Orchestrator | Layer | Grain | Gates it brings you to |
|---|---|---|---|
| `value-management-officer` | Portfolio | Epic (business or enabler) | ★ Epic Gate |
| `release-train-engineer` | Program / ART | Feature (business or enabler) | ★ Architecture Gate, ★ Demo Gate |
| `scrum-master` | Team | Story (business or enabler) | ★ Story Gate, ★ PR Gate |

You don't pick business versus enabler; the workflow judges it. A concern of another layer's grain is a **handoff**: the orchestrator tells you which orchestrator to invoke, and never mints a thinner item to absorb a thicker intent.

Orchestrators hold no Epic, Feature or Story privilege. They act the mediation steps of their own ceremonies (sync records, kanbans, manifests, plans, objectives, pain points), and every `status:` change of a work item is one run of a `*-transition` workflow whose owner step commits it.

## The specialist bench

The steps are acted by framework-owned specialists, each dispatched as one worker session per step instance:

| Agent | Typical artifacts |
|---|---|
| `business-owner` | strategic themes, portfolio vision and roadmap, Epics, Lean Business Cases, budget allocations, portfolio review decisions |
| `enterprise-architect` | architecture vision, Enabler Epics |
| `product-manager` | Features, product vision and roadmap, risks, releases |
| `system-architect` | Enabler Features and Stories, NFR lists, ADRs, architecture runway, architecture reviews |
| `product-owner` | Stories |
| `developer` | feasibility reviews, code changes |
| `quality-engineer` | QA sign-offs |
| `security-expert` | security reviews |
| `operator` | operability reviews |
| `ux-designer` | UX reviews |
| `tech-writer` | on the bench; acts no step in the current workflow catalogue |

---

## How you work with it

1. **Any concern, any form.** You state a concern; you don't name a ceremony. The orchestrator maps it to the one workflow of its layer whose SAFe purpose matches, or hands you to another orchestrator. A concern that matches no catalogue purpose is not a usecase here: IT concerns (impact, bug, spike, debt, decision) map onto an existing activity at Epic, Feature or Story grain.
2. **Workflows are challenge loops.** Specialists draft, challenge and rewrite until the challengers agree enough. Owner rewrites absorb the findings; challengers write no owner content.
3. **The human gate.** Each workflow delivers its **main** artifacts to you. You accept, raise concerns, or reject them; a rejection reiterates the workflow as a new workflow instance. Challenge and mediation artifacts (reviews, minutes, kanbans, manifests) are evidence, not what you are asked to judge.
4. **No valid step without artifact.** Every step commits a change to exactly one artifact instance of its declared kind, whatever the outcome, and records its decision in that artifact's `stepOutcomes`. Agent replies are indicative; committed artifacts are the only evidence.

How a run unfolds, step by step, is on [Running workflows]({% link saf/usage.md %}).

### Step outcomes

Each step appends one entry to the artifact it commits:

```yaml
stepOutcomes:
  - step: feature-backlog-refinement/draft-enabler   # <workflow-slug>/<step-slug>
    outcome: none        # written | revised | confirmed | no-change | none
    date: "2026-11-05"
    note: No enabler needed — the runway already provides tenant-scoped auth (ADR-12).
    friction: The Epic named no tenant boundary; had to infer it.   # optional
```

| Outcome | Meaning |
|---|---|
| `written` | the artifact was created |
| `revised` | its content changed |
| `confirmed` | reviewed and still valid, content unchanged |
| `no-change` | out of scope on this run, deliberately untouched |
| `none` | not needed; the artifact records that decision (for example an enabler with `status: not-needed`) |

The appended entry guarantees a change, so `confirmed` and `no-change` steps still deliver. Workflow friction goes in the `friction` note; only the `improvement-backlog` workflow turns it into a pain point.

---

## The workflow catalog

25 workflows, grouped by layer. The **mains** are the artifacts presented at the human gate.

### Portfolio — `value-management-officer`

| Workflow | Purpose | Mains | Steps |
|---|---|---|---|
| `epic-lean-business-case` | write a portfolio bet | `epic`, `lean-business-case`, `epic-enabler` | 7 |
| `architectural-vision` | portfolio runway and NFR backbone; records its decisions on Epics, writes no Epic | `architecture-vision` | 4 |
| `epic-vision-alignment` | write the Vision's decisions on ONE Epic into it | `epic-enabler`, `epic`, `lean-business-case` | 3 |
| `strategic-investment-planning` | allocate or guardrail ART funding | `budget-allocation` | 3 |
| `strategic-portfolio-review` | keep, pivot, stop or re-rank | `strategic-themes`, `portfolio-vision`, `portfolio-roadmap`, `architecture-vision` | 5 |
| `portfolio-sync` | portfolio snapshot; registers ONE product per run | `portfolio-sync`, `portfolio-manifest`, `product-manifest`, `portfolio-kanban` | 4 |
| `epic-transition` | move ONE Epic (and its enabler) to a new `status:` | `epic`, `epic-enabler`, `portfolio-kanban` | 3 |

### Program — `release-train-engineer`

| Workflow | Purpose | Mains | Steps |
|---|---|---|---|
| `feature-derivation` | split an approved Epic into ART Features, one business Feature per run (refused while no Epic is approved) | `feature`, `feature-enabler` | 2 |
| `feature-backlog-refinement` | write a PI-ready Feature | `feature`, `feature-enabler` | 8 |
| `architectural-runway-extension` | extend the ART runway; its decisions written into the Features by their owners | `nfr-list`, `adr`, `architecture-runway`, `feature`, `feature-enabler` | 10 |
| `feature-transition` | move ONE Feature (and its enabler) to a new `status:` | `feature`, `feature-enabler`, `program-kanban` | 3 |
| `pi-planning` | ART commit for the PI | confirms vision, roadmap, Feature and runway; writes `objectives` | 8 |
| `art-sync` | mid-PI dependencies and impediments | mediation record | 3 |
| `system-demo` | inspect the integrated increment; the demo gate | mediation / gate record | 1 |
| `inspect-and-adapt` | PI improvement | `inspect-and-adapt` record | 2 |
| `improvement-backlog` | record or update ONE pain point | `pain-point` | 1 |
| `release-on-demand` | ship an accepted increment | `release-on-demand` | 2 |

### Team — `scrum-master`

| Workflow | Purpose | Mains | Steps |
|---|---|---|---|
| `team-backlog-refinement` | write a ready-enough Story, including the Feature → Story split | `story`, `story-enabler` | 7 |
| `story-transition` | move ONE Story (and its enabler) to a new `status:` | `story`, `story-enabler` | 2 |
| `iteration-planning` | commit the iteration | `team-manifest`, `plan` | 4 |
| `pair-programming` | implement an already-OK Story | `code-change` | 1 |
| `verification` | is this Story done | `qa-signoff` | 1 |
| `team-sync` | daily inspect and adapt | mediation record | 1 |
| `iteration-review` | inspect the increment at iteration end | mediation record | 1 |
| `iteration-retrospective` | team improvement | mediation record | 1 |

Some workflows carry harness-checked [conditions]({% link saf/agentic-harness/conditions.md %}): `feature-derivation` refuses to start while no business Epic is `portfolio-backlog` or `implementing`, and withholds a Feature whose parent Epic is not approved; `epic-transition` withholds a transition while the Epic or its Enabler Epic still carries an item the Architectural Vision closes as `open`.

---

## Model routing

Each step declares capability weights (deep reasoning, coding, tool use, long context, writing quality, instruction following, schema adherence, …). The harness scores the organization's model catalogue (`conf/model-profiles.conf.yaml`) against them and returns a canonical model profile; each host adapter maps it to a host model. On `main` the catalogue holds `claude-fable-5`, `claude-opus-4.8`, `claude-sonnet-5`, `claude-opus-4.8-fast` and `claude-haiku-4.5`. Both adapters refuse, at every hook load, a catalogue slug they do not bind.

## Repository layout

The repository root is host-agnostic source; the installable artifact is a bundle rendered per host.

| Folder | Content |
|---|---|
| `agents/` | the orchestrators and the specialist bench (`<name>.agent.md`) |
| `skills/` | SAFe ceremony, practice, authoring and orchestration playbooks |
| `instructions/` | step instructions, grouped by the actor that runs the step |
| `workflows/` | the workflow catalog, by layer (`portfolio/`, `program/`, `team/`) |
| `conf/` | `access-control-list`, `model-profiles`, `workspace` (the workspace layout) |
| `artifacts/` | artifact JSON Schemas, grouped by the producing actor |
| `templates/` | artifact templates, by layer and actor |
| `builds/` | the Copilot plugin renderer (`plugin/`) |

---

## Planned: sync with central systems

The organization does not sync with central systems on `main`: you share the workspace by pushing its branch to your Git host. The artifact templates already reserve a `github:` field for a board sync. The intended model mirrors the committed artifacts to the systems your organization runs, with clear authority:

| Concern | Authority | Direction |
|---|---|---|
| Content (title, body, WSJF, risk, parent, estimates) | **local** wins | push overwrites the board projection |
| Status (non-gate board columns) | **remote** wins | pull writes the board column back to frontmatter |
| **Gate-crossing moves** (Epic, Architecture, Demo, PR, and `→ done`) | **neither** | never auto-applied; recorded as a request for you to decide |

Because the artifacts are template-shaped and schema-validated, such a sync can emit textbook SAFe (the Epic → Feature → Story hierarchy, WSJF, acceptance criteria, PI assignment, dependencies) to a Git host, a ticketing system (Jira) or a knowledge base (Confluence), instead of anyone hand-typing cards.

## Build around it — proposed extensions

1. **Provider-agnostic sync engine** *(flagship)* — a `RepositoryProvider` interface (`provision / push / pull / status`) with **GitHub**, **GitLab**, **Jira** and **Confluence** adapters, so the same templated-artifact sync drives any backend, with zero change to the framework side.
2. **Workspace conformance gate (CI)** — a required check that validates every committed artifact against its schema on the canonical branch, so drift cannot merge.
3. **Mission control — live state and replay** — render the current kanbans from frontmatter and reconstruct the timeline from the Git history of `status:` changes.
4. **Open blackboard protocol** — formalize the *read committed input → commit output* contract so third-party agents can join the bench.
5. **Organizational context over MCP** — an MCP server that streams governed organizational definitions into every agent (see the [SAF overview]({% link saf/index.md %}) and the planned SIE [MCP]({% link sie/mcp/index.md %}) product).

---

## See also

- **[Quickstart]({% link saf/quickstart.md %})** — install the organization and the harness for your host.
- **[Running workflows]({% link saf/usage.md %})** — run, continue and recover a workflow instance.
