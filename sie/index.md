---
layout: default
title: "SIE — the Systemic Intelligence Engine"
nav_order: 2
has_children: true
---

# SIE — the Systemic Intelligence Engine

{: .no_toc }

The **Systemic Intelligence Engine (SIE)** is the reference implementation of **[GSM]({% link gsm/index.md %})**: the engine that hosts governed definitions, enforces their lifecycle, evaluates Norms, and executes Mechanisms. Definitions sourced from external artifacts reach it through **[SIS]({% link sis/index.md %})**, and domain applications such as **[OIP]({% link oip/index.md %})** are built on top of it.

What Kubernetes is to software infrastructures, the Systemic Intelligence Engine is to governed systems: a small, fixed core of primitives, reconciled continuously, with everything domain-specific expressed as typed definitions on top. Start with **[The mental model]({% link sie/mental-model.md %})** for the loop that makes this work.

## Products

- **[Definition Manager]({% link sie/definition-manager/index.md %})** — the authoritative API, lifecycle enforcer, and store of every governed GSM Definition; the heart of the engine.
- **[Definition Operator]({% link sie/operator/index.md %})** — the GSM Definition runtime, evaluating Norms and executing Mechanisms. *Documentation in construction.*
- **[OTel Collector]({% link sie/otel-collector/index.md %})** — the shared OpenTelemetry collector receiving the traces and logs of the SIE services. *Documentation in construction.*
- **[MCP]({% link sie/mcp/index.md %})** — the planned Model Context Protocol server giving AI agents governed SIE context; early stage. *Documentation in construction.*

## Roadmap

Engine-level capabilities planned across the SIE products — analytics over the governed model and environmental presets — are catalogued in the **[SIE Roadmap]({% link sie/roadmap.md %})**.
