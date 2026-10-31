---
layout: default
title: Developer / Tech Lead
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/developer/
  - /itip/web-application/usage-scenarios/developer/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Developer / Tech Lead
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **consult** governed definitions as your authoritative architecture specification. You **verify** that code-sourced definitions match governance expectations. You **check** Norm compliance before merging code.

OIP replaces stale Confluence pages and outdated architecture diagrams with a live, governed source of truth — always current, always traceable.

## Core workflows

### Consult architecture specifications

When starting work on a component, navigate to its Structure in OIP:

1. Open **Structures > payment-gateway**.
2. OIP serves the complete governed definition:
   - Structure properties (purpose, owning team, data classification)
   - Attached Directives — what the architecture board requires
   - Attached Norms — measurable constraints you must satisfy
   - Quality requirements — from ISO 25010 (ProductReliability, ProductSecurity) and ISO 25012 (DataAccuracy)
   - Interaction graph — which other Structures this component connects to, through which Effectors and Receptors

This is the authoritative specification. It is the live governed definition, not a document that may be months out of date.

### Review code-sourced definitions

OIP ingests definitions directly from your code repository — module boundaries, class structures, API contracts, dependency graphs, deployment topology. These become first-class governed definitions.

The **Reconciliation view** compares:

| Column | What it shows |
|--------|--------------|
| **Authored definitions** | What the architecture *should be* — authored by architects |
| **Code-sourced definitions** | What the code *actually implements* — ingested from your repo |
| **Drift indicators** | Where the two diverge |

Drift means your implementation has diverged from the governed architecture. This is caught during development, not weeks later at an architecture review.

### Check Norm compliance before PR

Before submitting a pull request, verify that your implementation satisfies the Norm assertions:

1. Open the Structure's **Compliance** tab.
2. Check each Norm assertion against the current code-sourced state.
3. Red indicators flag violations (e.g., missing encryption standard, exceeded latency bounds, uncovered quality dimension).

This is not a manual checklist. OIP evaluates Norm assertions against the actual code-sourced definitions.

**Jira integration**: compliance status is reflected on the linked story/epic. Your PR review includes governance status automatically.

### Browse generated diagrams

OIP generates architecture and design diagrams from governed definitions:

- **Structure topology** — the component with its Mechanisms, Effectors, Receptors, and Interactions
- **Governance overlay** — Directives and Norms overlaid onto the topology, showing which constraints apply where
- **Reconciliation diff** — side-by-side comparing authored vs code-sourced definitions

Diagrams are available in PlantUML source, C4, SVG, and PDF. Use whichever format fits your workflow.

## Using frameworks

### TOGAF (as a consumer)

As a developer, you consume TOGAF-structured definitions rather than author them. OIP presents:

- **Application Architecture** — the Structure you implement, its position in the component landscape
- **Technology Architecture** — platform constraints, infrastructure requirements
- **Architecture Contracts** — the Norms that constrain your implementation choices

Filter by TOGAF domain to see just the architectural context relevant to your work.

### ISO 25010 — Quality requirements as code targets

ISO 25010 quality characteristics translate directly into implementable requirements:

| Quality characteristic | What it means for your code |
|---|---|
| **PerformanceEfficiency** | Latency bounds, throughput targets, resource limits |
| **ProductReliability** | Fault tolerance, circuit breakers, retry policies, availability targets |
| **ProductSecurity** | Encryption standards, authentication/authorization requirements, input validation |
| **Maintainability** | Modularity metrics, coupling constraints, test coverage expectations |

Each Norm assertion references these quality characteristics. When you see a failing Norm, the quality dimension tells you *what category* of concern it addresses.

### ISO 25012 — Data quality constraints

If your component handles data, ISO 25012 dimensions define what *quality* means for that data:

- **DataAccuracy** — are values correct? Validation rules, format constraints.
- **DataCompleteness** — are required fields present? Schema enforcement.
- **DataConsistency** — do related data items agree? Cross-reference integrity.
- **DataCurrentness** — is data fresh enough? TTL and refresh policies.

These appear as Norm assertions on your Structure when it processes quality-sensitive datasets.

## Example: Verify implementation before PR

**Context**: You are implementing the `fraud-detection` Mechanism of the Payment Gateway. The architecture board has defined quality Norms.

1. **Consult the Mechanism specification** — open *Structures > payment-gateway > Mechanisms > fraud-detection*. Read the Receptors (input contracts), Effectors (output contracts), and attached Norms.
2. **Implement** — write code aligned with the specification.
3. **Check reconciliation** — OIP ingests your branch. The reconciliation view shows whether your implementation's API contract matches the governed Effector/Receptor definitions.
4. **Check Norm compliance** — verify that quality assertions pass (latency, accuracy, security constraints).
5. **Submit PR** — Jira status updates automatically. Reviewers see governance compliance alongside code changes.

**Result**: Architecture drift is caught during development, not in a review meeting weeks later.

## Example: Understand a Mechanism change

**Context**: The architecture team has deprecated `fraud-detection-v1` and published `fraud-detection-v2` with a new ML-based approach. You need to understand what changed.

1. **Compare versions** — OIP shows the old and new Mechanism side by side: changed Receptors, new Effectors, updated Norms.
2. **Check Interaction impact** — see which other Mechanisms connect to the changed ports.
3. **Read updated Norms** — a new explainability Norm requires ML output to include confidence scores.
4. **Consult generated diagrams** — the updated topology diagram shows the new Interaction paths.

**Result**: You understand the full scope of the change from governed definitions — not from a Slack message or a meeting summary.
