---
layout: default
title: Project / Product Manager
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/project-manager/
  - /itip/web-application/usage-scenarios/project-manager/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Project / Product Manager
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **track governance readiness** across your project scope. You **monitor** definition lifecycle state to know whether architecture is complete before development proceeds. You **coordinate** deliverables and verify that governance gaps are resolved.

OIP gives you continuous visibility into architecture governance state — not a one-time checkpoint at an architecture review meeting.

## Core workflows

### Governance dashboard

Navigate to **Projects > [your project]**. OIP shows all Structures in the project scope with their governance state:

| Indicator | Meaning |
|-----------|---------|
| **Green** | All Directives approved, all Norms operationalized, regulatory presets attached |
| **Amber** | Some Directives still in DRAFT or PROPOSED; Norms pending operationalization |
| **Red** | Missing required Directives, no regulatory presets, governance gaps unresolved |

Each Structure's state follows the [Ascription lifecycle]({% link oip/web-application/general-usage.md %}#the-ascription-lifecycle): `DRAFT` → `PROPOSED` → `APPROVED` → `ACTIVE`.

### Track lifecycle progression

The governance dashboard shows where each definition sits in the lifecycle:

```
payment-gateway:
  Structure:       ACTIVE    ✓
  Directives:      3/3 ACTIVE ✓
  Norms:           5/6 ACTIVE ⚠ (1 in PROPOSED)
  Regulatory:      GDPR ✓  PCI-DSS ✓  NIS2 ✓
  Deliverables:    2/3 published ⚠
```

You can drill into any amber/red indicator to see exactly what is pending and who owns it.

### Jira synchronization

Governance state is reflected in Jira bidirectionally:

| OIP entity | Jira mapping |
|-------------|-------------|
| Structure | Epic |
| Directive | Story (governance intent) |
| Norm | Story (operationalized constraint) |
| Lifecycle transition | Jira workflow transition |
| Governance gap | Backlog item with priority |

Your Jira board shows governance completeness alongside delivery progress. Architecture governance is not a separate track — it is part of the same sprint view.

### Deliverable readiness

OIP tracks which architecture deliverables are published and which are still in progress:

- **Architecture Decision Records** — linked to motivating Directives
- **Solution design documents** — generated from governed definitions
- **API specifications** — authoritative contracts for development teams
- **Compliance evidence** — regulatory coverage documentation

Deliverables are served directly from OIP. No manual export needed (Confluence sync is available for wider distribution).

## Using ontologies

### TOGAF ADM — Architecture Development Method

As a PM, the TOGAF ADM lifecycle maps to your governance checkpoints:

| ADM phase | OIP governance checkpoint |
|-----------|---------------------------|
| Preliminary | Ontology stack composed, governing Structures defined |
| Architecture Vision | Directives authored and in PROPOSED state |
| Business / Application / Technology Architecture | Structures defined, Norms authored |
| Opportunities & Solutions | All Norms operationalized, gap analysis complete |
| Migration Planning | All definitions APPROVED, deliverables published |
| Implementation Governance | Definitions ACTIVE, code-sourced reconciliation running |

Filter views by ADM phase to see which architectural governance activities are complete and which are pending.

### ISO 25010 / 25012 — Quality governance coverage

Your governance dashboard shows quality dimension coverage:

- Are all quality characteristics addressed by Norms? (ProductReliability, ProductSecurity, PerformanceEfficiency)
- Are data quality dimensions covered for data-processing Structures? (DataAccuracy, DataCompleteness)
- Which quality dimensions have no Norm — a governance gap?

This helps you ensure the architecture framing is complete before development begins.

## Example: Track governance readiness for a project

**Context**: Your project delivers 3 new microservices for the Customer Portal. You need to verify governance is complete before development sprints begin.

1. **Open governance dashboard** — navigate to *Projects > Customer Portal*. See all 3 Structures with their status.
2. **Check lifecycle state** — Structure A is ACTIVE (green), Structure B is APPROVED (green), Structure C has 2 Directives still in PROPOSED (amber).
3. **Drill into gaps** — Structure C's owner hasn't finalized the latency Directive. You see the owner and can follow up directly.
4. **Check Jira** — the governance gap surfaces as a backlog item in the current sprint.
5. **Track deliverables** — 2 of 3 design documents are published. The third is in DRAFT.

**Result**: You have continuous, quantified visibility into governance readiness. No surprises at the architecture review. Development starts only when the governance baseline is complete.
