---
layout: default
title: Milestones & Versions
nav_order: 7
---

# Milestones & Versions

{: .no_toc }

This page is the **single, canonical reference** for every delivery statement in Poesis content — on this site and on [poesis.cloud](https://poesis.cloud). Wherever a page mentions a milestone tier or a version, this page defines what it means.

> **The clause.** Versions retain recorded release/content labels and planned milestones, not evidence of complete present functionality or hosted availability. Feature commitments separately show **Implemented** with a check badge or **Planned** with a clock. Planned is a company commitment; values describe what that commitment delivers, without implying delivery dates or measured outcomes. The only existing dated target is GSM document-set publication (approximately October 2026).

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Version semantics

Each **product** carries its own version line (solutions are not versioned):

- **0.x** — pre-GA. Each minor is a named feature batch. Anything may change.
- **1.0 — GA / production-ready**: commercially supportable, documented, covered by the product's stated quality gates.
- **1.x minors** — post-GA feature batches, backward compatible.
- **Majors ≥ 2** — breaking or architectural shifts only.

## Milestone vocabulary

| Marker | Meaning |
| --- | --- |
| **Recorded release (vX.Y)** | milestone shipped flag is true; recorded release/content metadata, not current feature acceptance |
| **Planned milestone (vX.Y)** | milestone shipped flag is false; ordered intent, not a recorded release or delivery date |
| **v1.0 (MVP/GA)** | the first-release scope — production-ready, commercially supportable |
| **v1.1, v1.2, …** | planned post-GA feature batches, in the order the product's timeline states |
| **v1.x** | post-GA scope that is open and not yet sequenced |
| **Unversioned** | exploratory / research-tier; may never ship |

Feature versions and commitment status are separate. **Planned** identifies a company commitment
whose implementation is incomplete; **Implemented** identifies the completed, stated content or
behavior. Existing foundations do not make an unfinished scope Implemented. Values follow their
own supporting features, capabilities or affordances; empty references and vision remain Planned.
Neither status establishes hosted service, certification or measured customer outcomes.

## Product version milestones

Versions are ordered, not scheduled. Timeline labels distinguish **Recorded release** from
**Planned milestone** using the milestone's shipped flag, preserving its original wording.
The feature tables independently give current names, scope and state. A recorded current version never creates an
invented shipped milestone.

{% include roadmap_timeline.html %}

## How versions depend on each other

1. **GSM Specifications have 1.0 content in source**. Publication is pending; SIE current-conformance alignment requires its own acceptance.
2. **Blackboard Manager GA gates the Code Sourcer GA** — the sourcer needs a stable server contract.
3. **The Agentic Harness has a recorded 1.0 release**. Organization and Workspace need compatible contracts and scoped acceptance; the release does not prove their integration.
4. **OIP GA does not gate on SIE GA** — OIP 1.0 may ship against SIE 0.x.
5. **Blackboard Manager GA also gates the SIE Bridge GA** — the same stable server contract the Code Sourcer depends on.
