---
layout: default
title: "Web Application Features"
parent: OIP Web Application
grand_parent: OIP — the Organizational Intelligence Platform
nav_order: 2
redirect_from:
  - /itip/features/
  - /itip/web-application/features/
---

# Web Application Features
{: .no_toc }

The Web Application's capabilities, grouped by functional component. Each section is one component of the product; the entries under it are the capabilities it provides. OIP is in active design.

Each capability carries the exact OIP **SemVer milestone** that delivers it: **1.0** is the GA scope and **1.1**–**1.5** is the ordered post-GA roadmap — see **[Milestones & Versions]({% link milestones.md %})** for the canonical version semantics and the delivery clause.

## Published feature catalogue

The product's published features on [poesis.cloud](https://poesis.cloud/solutions/oip/products/web-application) map onto the functional components below:

| Published feature | Functional component(s) |
|-------------------|-------------------------|
| IT artifact factory | [Deliverables](#deliverables) |
| GSM Definitions truth sourcing management | [Truth Sourcing](#truth-sourcing), [Review](#review) |
| IT compliance evaluation | [Evaluation](#evaluation) |
| IT Copilot | [Copilot](#copilot) |
| IT impact simulation | [Simulation](#simulation) |
| GSM Definitions management | [Definition](#definition), [Lenses](#lenses), [Overview](#overview) |
| GSM Ontology management | [Ontology](#ontology) |
| RBAC and ABAC | [Admin](#admin), role-specific [Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %}) |

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Governance posture at a glance.

| Capability | What it does | Version |
|------------|--------------|---------|
| Dashboard | Governance posture overview: definition counts, evaluation health, and recent changes | 1.1 |
| Activity | Chronological activity log / audit feed of governance events | 1.1 |

## Definition

The authoring core — create and manage the eight GSM primitives and drive the Ascription lifecycle.

| Capability | What it does | Version |
|------------|--------------|---------|
| Dashboard | Definition activity and health overview | 1.1 |
| Registry & Inventory | Browse, search, and filter every governed definition | 1.0 |
| Structures | Create and inspect **Structures** (systems, services, teams, platform components) | 1.0 |
| Archetypes | Create and inspect **Archetypes** — JSON-Schema-typed domain schemas | 1.0 |
| Directives | Author **Directives** in the Governance Authoring Workspace; view a Directive's Norms, history, and impact | 1.0 |
| Norms | Author and inspect **Norms** (CEL assertions) | 1.0 |
| Mechanisms | Author and inspect **Mechanisms** (Starlark rules) | 1.0 |
| Interactions | Wire and inspect **Interactions** (Effector ↔ Receptor coupling) | 1.0 |
| Ascription lifecycle | Bring a definition under governance, diff versions, and drive status transitions (DRAFT → … → RETIRED) | 1.0 |

## Evaluation

Appraisal of the governed model — the bilateral appraisal-indicator system, organized by class and zone, plus regulatory compliance views.

| Capability | What it does | Version |
|------------|--------------|---------|
| Dashboard | Aggregate appraisal posture across all indicator classes | 1.3 |
| Findings | Browse findings, overall and per bilateral class | 1.3 |
| AA · Source Fidelity | Ascription ↔ Ascription — sourced definitions stay faithful to their source | 1.3 |
| AC · Comitology Compliance | Ascription ↔ Comitology — changes followed the required decision procedure | 1.3 |
| DD · Directive Coherence | Directive ↔ Directive — Directives are mutually coherent | 1.3 |
| DN · Operationalization Integrity | Directive ↔ Norm — every Directive is properly operationalized into Norms | 1.3 |
| NN · Norm Coherence | Norm ↔ Norm — Norms are mutually coherent, with no conflicts | 1.3 |
| NA · Definition Compliance | Norm ↔ Ascription — in both the meta-governance and governance zones | 1.3 |
| NX · Execution Compliance | Norm ↔ eXecution — in both the meta-governance and governance zones | 1.3 |
| Adherence matrix | Regulatory adherence matrix across frameworks and Structures | 1.3 |
| Conformance | Conformance dashboard — drift of reality against governed intent | 1.3 |

## Ontology

Browse and compose sourced governance ontologies.

| Capability | What it does | Version |
|------------|--------------|---------|
| Catalog | Browse available ontologies — GDPR, NIS2, ISO 25000 (SQuaRE), TOGAF 9.2, SCAP, the IT ontology, and org ontologies such as ACME Corp | 1.0 |
| Ontology detail | Inspect an ontology's Directives, Norms, and vocabulary | 1.0 |
| Stack Composer | Compose multiple ontologies into one coherent governance stack | 1.0 |

## Lenses

Saved, multi-dimensional views over the governed model.

| Capability | What it does | Version |
|------------|--------------|---------|
| Browse | Browse saved lenses (named, filtered views) | 1.1 |
| Edit Lens | Create and edit a lens — multi-dimensional filters over the model | 1.1 |
| Diagram | Render a lens as a diagram (topology / governance overlay) | 1.1 |

## Simulation

Explore the consequences of a change before committing it.

| Capability | What it does | Version |
|------------|--------------|---------|
| Impact Analysis | Cascade / blast-radius analysis across dependent definitions | 1.5 |

## Copilot

A governed AI assistant grounded in the definitions.

| Capability | What it does | Version |
|------------|--------------|---------|
| Assistant | Conversational assistant that answers and drafts from the governed model — grounded and traceable, not hallucinated | 1.4 |

## Review

The human governance gates — the comitology of approving change.

| Capability | What it does | Version |
|------------|--------------|---------|
| Review Board | Governance approvals board for pending lifecycle transitions | 1.2 |
| Sessions | Conduct a governance review session | 1.2 |
| History | Past review decisions and their rationale | 1.2 |

## Truth Sourcing

Connect external reality and keep the governed model in sync.

| Capability | What it does | Version |
|------------|--------------|---------|
| Sources | Manage connected sources (repositories, API contracts, infrastructure) | 1.2 |
| Source detail | Inspect a single source and what it contributes | 1.2 |
| Sync Jobs | Track sourcing / sync runs and their outcomes | 1.2 |

## Deliverables

Generate governed artifacts from definitions.

| Capability | What it does | Version |
|------------|--------------|---------|
| Templates | Catalog of deliverable templates (the artifact catalog) | 1.1 |
| Template Editor | Author and edit deliverable templates | 1.1 |
| Generated & Jobs | Generated deliverables and the generation jobs that produce them | 1.1 |

## Admin

| Capability | What it does | Version |
|------------|--------------|---------|
| Users | Users, roles, and permissions | 1.0 |
| Integrations | External-system integration settings | 1.0 |

## Guided Workflows

End-to-end walkthroughs that thread several capability areas together. They map onto the role-based **[Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})**.

| Workflow | Threads together | Role | Version |
|----------|------------------|------|---------|
| Architect: Governance Authoring & Impact Analysis | Definition → Simulation | [Architect]({% link oip/web-application/usage-scenarios/architect.md %}) | 1.5 |
| Security Officer: Ontology Stack Composition | Ontologies → Evaluation | [Security Officer]({% link oip/web-application/usage-scenarios/security-officer.md %}) | 1.3 |
| Governance Review Ceremony | Review → Definition | [Project Manager]({% link oip/web-application/usage-scenarios/project-manager.md %}) | 1.2 |
| Evaluation Status Transition | Evaluation → Definition | [Operations]({% link oip/web-application/usage-scenarios/operations.md %}), [QA]({% link oip/web-application/usage-scenarios/qa-engineer.md %}) | 1.3 |

---

For the concepts behind these capabilities, see the **[OIP overview]({% link oip/web-application/index.md %})**; for hands-on, role-by-role workflows, the **[Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})**.
