---
layout: default
title: "Definition Manager Features"
parent: Definition Manager
grand_parent: SIE — the Systemic Intelligence Engine
nav_order: 1
redirect_from:
  - /sie-definition/features/
---

# Definition Manager Features
{: .no_toc }

Capability catalogue for the Definition Manager, grouped by functional component. Capabilities of the other SIE products live on their own pages — see the [Definition Operator features]({% link sie/operator/features.md %}), the [MCP]({% link sie/mcp/index.md %}) product for Model Context Protocol access, the engine-level [SIE Roadmap]({% link sie/roadmap.md %}), and, for definition sourcing, the SIS [Blackboard Manager features]({% link sis/blackboard-manager/features.md %}).

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{% include milestone_legend.md %}

---

## Capabilities

| Feature | Representative content | Milestone |
|---------|------------------------|-----------|
| GSM Definitions management RESTful API | Create, read, update, query every governed definition; live OpenAPI; isolated tenant schemas | Shipped · v1.0 (MVP/GA) |
| GSM Definitions lifecycle enforcement | Ascription lifecycle as a validated state machine (DRAFT → … → RETIRED) with referee preconditions | Shipped · v1.0 (MVP/GA) |
| GSM Definitions retention | Definitions and history retained as versioned state transitions | Shipped · v1.0 (MVP/GA) |
| GSM Definitions lifecycle events mediation | Lifecycle state transitions published as events other services and agents can react to, instead of polling | v1.1 |
