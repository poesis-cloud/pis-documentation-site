---
layout: default
title: "SIE — the Systemic Intelligence Engine"
nav_order: 2
has_children: true
---

# SIE — the Systemic Intelligence Engine

{: .no_toc }

The **Systemic Intelligence Engine (SIE)** is the reference implementation of **[GSM]({% link gsm/index.md %})**: the engine that hosts governed definitions, enforces their lifecycle, evaluates Norms, executes Mechanisms, and keeps the sourcing pipeline auditable. Domain applications such as **[ITIP]({% link itip/index.md %})** are built on top of it.

What Kubernetes is to software infrastructures, the Systemic Intelligence Engine is to governed systems: a small, fixed core of primitives, reconciled continuously, with everything domain-specific expressed as typed definitions on top. Start with **[The mental model]({% link sie/mental-model.md %})** for the loop that makes this work.

## Products

- **[Definition Manager]({% link sie/definition-manager/index.md %})** — the authoritative API, lifecycle enforcer, and store of every governed GSM Definition; the heart of the engine.
- **[Operator]({% link sie/operator/index.md %})** — the GSM Definition runtime, evaluating Norms and executing Mechanisms. *Documentation in construction.*
- **[Definition Blackboard Manager]({% link sie/definition-blackboard-manager/index.md %})** — the collaborative agentic Definition-sourcing pipeline, with a sealed, byte-stable contribution lifecycle and an append-only audit ledger. *Documentation in construction.*

## Roadmap

Engine-level capabilities planned across the SIE products — analytics over the governed model and environmental presets — are catalogued in the **[SIE Roadmap]({% link sie/roadmap.md %})**.
