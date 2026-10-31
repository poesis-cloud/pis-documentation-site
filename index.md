---
layout: default
title: "Poesis Documentation"
nav_exclude: true
permalink: /
---

# Poesis Documentation

Welcome to the user documentation for **Poesis** products.

Poesis builds products that bring **systemic governance** to organizations — replacing fragmented, manual, and permanently outdated governance practices with a continuous, machine-enforceable governance fabric.

---

## Solutions

Poesis is layered: the **GSM** standard, the **SIE** engine that implements it, **SIS** to source definitions into it, domain applications built on top such as **OIP** for the IT domain, **SAF** to build them, and **SIM**, an early-stage language model grounded in GSM and SIE context. Each solution below groups the products it ships. Delivery language across this site follows the canonical **[Milestones & Versions]({% link milestones.md %})** page.

### [OIP — Organizational Intelligence Platform]({% link oip/index.md %})

The first domain application built on SIE. OIP is where all IT profiles converge — architects, developers, ops engineers, project managers, security officers, compliance analysts — to define, govern, and visualize the IT landscape through a single governed source of truth.

- **[Web Application]({% link oip/web-application/index.md %})** — the application every IT profile works in
  - [Overview]({% link oip/web-application/index.md %}) — the THINK gap, the Definition–Execution–Observation triad, and DNA governance grammar
  - [Getting Started]({% link oip/web-application/getting-started.md %}) — first steps in the application
  - [Features]({% link oip/web-application/features.md %}) — the capability catalogue
  - [General Usage]({% link oip/web-application/general-usage.md %}) — Directives, Norms, Ascriptions, and Frameworks in practice
  - [Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %}) — role-specific workflows per IT profile
  - [Rules]({% link oip/web-application/rules.md %}) — governance rules every user must know

### [SIE — Systemic Intelligence Engine]({% link sie/index.md %})

The reference implementation of GSM: the engine that hosts governed definitions, enforces their lifecycle, evaluates Norms, and executes Mechanisms.

- **[Definition Manager]({% link sie/definition-manager/index.md %})** — the authoritative API, lifecycle enforcer, and store of every governed GSM Definition. *Documentation in construction.*
  - [Features]({% link sie/definition-manager/features.md %}) — the capability catalogue with milestones
- **[Definition Operator]({% link sie/operator/index.md %})** — the GSM Definition runtime for Norms and Mechanisms. *Documentation in construction.*
  - [Features]({% link sie/operator/features.md %}) — the capability catalogue with milestones
- **[OTel Collector]({% link sie/otel-collector/index.md %})** — the shared OpenTelemetry collector for the SIE services. *Documentation in construction.*
- **[MCP]({% link sie/mcp/index.md %})** — the planned Model Context Protocol server giving AI agents governed SIE context; early stage. *Documentation in construction.*
- [Roadmap]({% link sie/roadmap.md %}) — engine-level capabilities planned across the SIE products

### [SIS — Systemic Intelligence Sourcing]({% link sis/index.md %})

Sources GSM definitions from external artifacts — starting with code repositories — through a collaborative blackboard, feeding the SIE Definition Manager.

- **[Code Sourcer]({% link sis/code-sourcer/index.md %})** — client pipeline that sources IT artifacts — code, API contracts, infrastructure — into governed GSM definitions on the Blackboard Manager. *Documentation in construction.*
  - [Features]({% link sis/code-sourcer/features.md %}) — the capability catalogue with milestones
- **[Blackboard Manager]({% link sis/blackboard-manager/index.md %})** — collaborative definition-sourcing service with a sealed, byte-stable contribution lifecycle and an append-only audit ledger. *Documentation in construction.*
  - [Features]({% link sis/blackboard-manager/features.md %}) — the capability catalogue with milestones

### [GSM — the standard]({% link gsm/index.md %})

The **Generative System Model (GSM)** is the vendor-neutral standard for the THINK side of IT — *defining and governing* systems, the way OpenTelemetry standardized *observing* them. It turns governance from prose that *describes* systems into definitions that *generate* them, and every Poesis product implements it. GSM is at v1.0 — normative content frozen, publication of the document set pending — source-available under BUSL-1.1 and developed as a candidate for contribution as an open standard.

- **Specifications** — eight primitives, DNA grammar, Archetyping, and the systemic lifecycle. *Publication pending — the specification document set is being finalized for release.*
- **[Research Lab]({% link gsm/research-lab/index.md %})** — non-normative research into GSM semantics. Current **v1.0.0-beta.1**.
  - [Features]({% link gsm/research-lab/features.md %}) — the capability catalogue with milestones
- **[Ontology]({% link gsm/ontology/index.md %})** — domain, standard, and legal vocabularies sourced into GSM, ready to enforce. *Documentation in construction.*
  - [Features]({% link gsm/ontology/features.md %}) — the capability catalogue with milestones

### [SAF — Systemic Agentic Framework]({% link saf/index.md %})

A governed, local-first, multi-agent way to run SAFe — today in VS Code / GitHub Copilot, portable to any host the harness adapts to. Portfolio–program–iteration orchestration runs on your own machine, with a human gate at every layer, producing standard SAFe artifacts synchronized through your own git host.

- [Overview]({% link saf/index.md %}) — the solution, its architecture, and its products
- [Quickstart]({% link saf/quickstart.md %}) — install and run your first orchestrated PR in under 30 minutes
- **[Agentic Harness]({% link saf/agentic-harness/index.md %})** — the deterministic execution core: step resolution, condition checks, artifact validation, journaling
  - [Features]({% link saf/agentic-harness/features.md %}) — the capability catalogue with milestones
- **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})** — orchestrators, layers, ceremonies, agents, and the filesystem ⇆ central-systems sync
  - [Features]({% link saf/safe-agentic-organization/features.md %}) — the capability catalogue with milestones
- **[Agentic Workspace]({% link saf/agentic-workspace/index.md %})** — the shared remote workspace for agentic workflow artifacts. *Documentation in construction.*
  - [Features]({% link saf/agentic-workspace/features.md %}) — the capability catalogue with milestones
- **[SIE Bridge]({% link saf/saf-sie-bridge/index.md %})** — the client sourcer turning harness-governed execution history into GSM contributions on the Blackboard Manager. *Documentation in construction.*
  - [Features]({% link saf/saf-sie-bridge/features.md %}) — the capability catalogue with milestones

### [SIM — Systemic Intelligence Model]({% link sim/index.md %})

An early-stage effort toward a language model grounded in GSM definitions and SIE governed context. Nothing is released yet.

- **[LM]({% link sim/lm/index.md %})** — the SIM language model, exploring training against GSM / SIE governed context. *Documentation in construction.*
