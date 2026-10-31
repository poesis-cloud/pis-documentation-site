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

The **Systemic Agentic Framework (SAF)** is a governed, local-first way to run **SAFe** with AI agents. Multi-agent orchestrations — portfolio, program, and iteration — run on your own machine inside your agent host (VS Code / GitHub Copilot today; the harness is host-agnostic), producing standard, schema-validated SAFe artifacts — Epics, Features, Stories, ADRs, kanbans, gate records — synchronized through your organization's own git host. A human ★ gate closes every layer: agents propose through evidence and sequence; the decision stays with you.

SAF complements **[OIP]({% link oip/index.md %})** and integrates with **[SIE]({% link sie/index.md %})**: its artifact templates can be sourced as GSM Archetypes, and its agents can consume the organization's governed definitions as context while they work.

## The framework's architecture

Four properties make it work:

1. **Local-first** — the agent loop runs on each user's machine, in the IDE, against the real working tree. Sensitive information never leaves the machine; only the artifacts you commit sync out transparently to your organization's git host.
2. **Governed** — a portfolio → program → iteration hierarchy of role agents, with a human ★ gate at every layer. An org chart with human authority, not a flat swarm.
3. **Sovereign** — work state lives in your own files and git history (the event log), not a vendor's cloud. Nothing is trapped in an unmanaged session.
4. **Portable** — the harness is methodology- and host-agnostic: plain files, a stable CLI, host-specifics isolated behind a thin adapter. The same familiar agentic work method follows you from host to host — VS Code today, another IDE, CI runner, or agent host tomorrow — with no relearning.

Three orchestrators, one per SAFe layer, drive the model — dispatched from a single entry point, `@vmo-orchestrator`:

```mermaid
flowchart LR
    CS["Central Supervisor<br/>human value authority<br/>owns every gate"]

    subgraph FW["SAFe Agentic Organization in your IDE"]
      direction TB
      subgraph PORT["Portfolio layer - vmo-orchestrator"]
        direction LR
        VMO["vmo-orchestrator"]
        ELBC["Epic Lean Business Case<br/>Agents: BO, EA, Sec, RAI"]
        AV["Architectural Vision<br/>Agents: EA, BO"]
        SPR["Strategic Portfolio Review<br/>Agents: BO, EA"]
        PB["Participatory Budgeting<br/>Agents: BO, EA"]
        PS["Portfolio Sync<br/>Agents: VMO, Epic owners"]
      end
      subgraph PROG["Program or ART layer - rte-orchestrator"]
        direction LR
        RTE["rte-orchestrator"]
        FBR["Feature Backlog Refinement<br/>Agents: PM, Arch, Dev, QA, UX, Sec"]
        ARE["Architectural Runway Extension<br/>Agents: SA, Sec, DevOps, Dev"]
        PIP["PI Planning<br/>Agents: the ART"]
        SD["System Demo<br/>Agents: the ART"]
        ASY["ART Sync<br/>Agents: Arch, leads"]
        IA["Inspect and Adapt<br/>Agents: the ART"]
      end
      subgraph ITER["Team or Iteration layer - sm-orchestrator"]
        direction LR
        SM["sm-orchestrator"]
        IP["Iteration Planning<br/>Agents: PO, pairs"]
        SBR["Story Backlog Refinement<br/>Agents: PO"]
        PAIR["Pair micro-cycle<br/>Agents: Dev, Dev, Sec"]
        VS["Verification and Sign-off<br/>Agents: QA, Sec"]
        DSR["Daily, Review, Retro<br/>Agents: the team"]
      end
      FSL["local filesystem blackboard<br/>portfolio artifacts in Markdown"]
    end

    subgraph CENTRAL["Central systems synced from the git host"]
      direction TB
      GH["Git host<br/>GitHub or GitLab<br/>boards, issues, artifact files"]
      JIRA["Ticketing, Jira<br/>SAFe Epics, Features, Stories, PIs"]
      CONF["Knowledge base, Confluence<br/>ADRs, PRDs, reports"]
      GH -->|"tickets"| JIRA
      GH -->|"knowledge"| CONF
    end

    CS ==>|"strategic intent to governed delivery"| VMO
    VMO -.->|"dispatch approved Epic to demoed Features"| RTE
    RTE -.->|"dispatch committed Feature to merged Stories"| SM
    VMO -->|"returns Epic gates"| CS
    RTE -->|"returns Architecture, Demo, PR gates"| CS
    SM -->|"returns Story, PR packet gates"| CS
    VMO --> FSL
    RTE --> FSL
    SM --> FSL
    FSL -->|"sync push or pull, the only external link"| GH

    classDef orch fill:#10b981,stroke:#065f46,color:#ffffff;
    classDef fs fill:#e0e7ff,stroke:#6366f1,color:#1e1b4b;
    classDef ext fill:#fde68a,stroke:#b45309,color:#3f2d00;
    class VMO,RTE,SM orch
    class FSL fs
    class GH,JIRA,CONF ext
```

*Each orchestrator is an entry point carrying your use case for its layer, and **returns that layer's ★ gates to you**. The framework's only external link is the git host — Jira and Confluence sync from there. The full model is on the **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})** page.*

---

## Products

- **[Agentic Harness]({% link saf/agentic-harness/index.md %})** — the deterministic execution core: it resolves workflows, steps, models, and session context, checks conditions, authorization, and artifacts, and journals every step.
  - [Features]({% link saf/agentic-harness/features.md %}) — the capability catalogue with milestones
- **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})** — the SAFe-shaped framework application the harness executes: orchestrators, the specialist agent bench, skills, workflows, instructions, and artifact schemas.
  - [Features]({% link saf/safe-agentic-organization/features.md %}) — the capability catalogue with milestones
- **[Agentic Workspace]({% link saf/agentic-workspace/index.md %})** — the shared data plane storing the artifacts local agentic workflows produce. *Documentation in construction.*
  - [Features]({% link saf/agentic-workspace/features.md %}) — the capability catalogue with milestones
- **[SIE Bridge]({% link saf/saf-sie-bridge/index.md %})** — the client sourcer turning the harness-governed agentic-execution history into GSM contributions on the Blackboard Manager. *Documentation in construction.*
  - [Features]({% link saf/saf-sie-bridge/features.md %}) — the capability catalogue with milestones

**Next: [Quickstart — your first orchestrated PR →]({% link saf/quickstart.md %})**
{: .fs-5 .fw-300 }
