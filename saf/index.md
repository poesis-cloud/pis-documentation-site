---
layout: default
title: "SAF — the Systemic Agentic Framework"
nav_order: 5
has_children: true
redirect_from:
  - /safe-agentic-framework/
---

# SAF — the Systemic Agentic Framework

{: .no_toc }

The **Systemic Agentic Framework (SAF)** is a governed, local-first way to run **SAFe** with AI agents. Portfolio, program and team workflows run on your own machine, inside your agent host — the GitHub Copilot app or Copilot CLI, or VS Code with GitHub Copilot Chat — and produce schema-validated SAFe artifacts (Epics, Features, Stories, ADRs, kanbans, gate records) in a Git repository you own. Every workflow ends at a human gate: agents draft, challenge and rewrite; the decision stays with you.

**Status.** The [Agentic Harness]({% link saf/agentic-harness/index.md %}) is at **v1.0.0-alpha.1**, a pre-release. The [SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %}) is used from its `main` branch. Installation is manual; marketplace distribution is planned.

SAF complements **[OIP]({% link oip/index.md %})** and is designed to integrate with **[SIE]({% link sie/index.md %})**: its artifact templates can be sourced as GSM Archetypes, and the planned [SIE Bridge]({% link saf/saf-sie-bridge/index.md %}) turns its execution history into GSM contributions.

## The framework's architecture

Four properties make it work:

1. **Local-first** — the agent loop runs on your machine, in your agent host, against a real Git working tree. Work state stays in your files; only what you push leaves through your Git host. (Model calls go to your agent host's model provider.)
2. **Governed** — three layer orchestrators and a specialist bench, with a human gate at the end of every workflow. The harness resolves every step, authorizes and validates every write, and only accepts a step that delivered its artifact.
3. **Sovereign** — work state lives in your own files and Git history, not in a vendor's cloud. Nothing is trapped in an unmanaged chat.
4. **Portable** — the harness is methodology- and host-agnostic: plain files, a fixed set of twelve functions, and host specifics isolated in thin adapters. Two hosts are supported today; the same workflows run on both.

You talk to the orchestrator of the layer your concern belongs to. A concern of another layer's grain is a handoff: the orchestrator tells you which orchestrator to invoke.

```mermaid
flowchart LR
    U["You<br/>value authority, own every gate"]
    subgraph HOST["Your agent host: GitHub Copilot app / CLI, or VS Code"]
      direction TB
      VMO["value-management-officer<br/>Portfolio: Epics"]
      RTE["release-train-engineer<br/>Program: Features"]
      SM["scrum-master<br/>Team: Stories"]
      BENCH["Specialist bench<br/>one worker per step"]
      H["Agentic Harness<br/>resolves, checks, records"]
    end
    WS["Workspace<br/>your Git repository"]
    GH["Your Git host"]
    U -->|"concern, assent, gate decision"| VMO
    U --> RTE
    U --> SM
    VMO -->|"dispatch steps"| BENCH
    RTE --> BENCH
    SM --> BENCH
    H -.->|"governs each step and write"| BENCH
    BENCH -->|"governed writes"| WS
    WS -->|"push and pull"| GH

    classDef orch fill:#10b981,stroke:#065f46,color:#ffffff;
    classDef fs fill:#e0e7ff,stroke:#6366f1,color:#1e1b4b;
    class VMO,RTE,SM orch
    class WS fs
```

*Each orchestrator drives one workflow at a time and returns its main artifacts to you at the gate. The full model is on the **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})** page.*

---

## Get started

- **[Quickstart]({% link saf/quickstart.md %})** — install the harness and the organization for the GitHub Copilot app / Copilot CLI or for VS Code.
- **[Running workflows]({% link saf/usage.md %})** — run a first workflow, continue it, recover an interrupted workflow instance.

## Products

- **[Agentic Harness]({% link saf/agentic-harness/index.md %})** — the deterministic execution core: it resolves workflow steps, models and the context of orchestrator and worker sessions, checks conditions, authorization and artifacts, governs every write through step transactions, and journals every step.
  - [Features]({% link saf/agentic-harness/features.md %}) — the capability catalogue with milestones
- **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})** — the SAFe-shaped framework application the harness executes: orchestrators, the specialist bench, skills, workflows, instructions, and artifact schemas.
  - [Features]({% link saf/safe-agentic-organization/features.md %}) — the capability catalogue with milestones
- **[Agentic Workspace]({% link saf/agentic-workspace/index.md %})** — the shared data plane storing the artifacts local agentic workflows produce. *Documentation in construction.*
  - [Features]({% link saf/agentic-workspace/features.md %}) — the capability catalogue with milestones
- **[SIE Bridge]({% link saf/saf-sie-bridge/index.md %})** — the client sourcer turning the harness-governed agentic-execution history into GSM contributions on the Blackboard Manager. *Documentation in construction.*
  - [Features]({% link saf/saf-sie-bridge/features.md %}) — the capability catalogue with milestones

**Next: [Quickstart →]({% link saf/quickstart.md %})**
{: .fs-5 .fw-300 }
