---
layout: default
title: Enterprise / Solution Architect
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/architect/
  - /itip/web-application/usage-scenarios/architect/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Enterprise / Solution Architect
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You are the primary **governance author**. You define Structures, write Directives and Norms, compose ontology stacks, and produce architecture deliverables — all from governed definitions.

OIP replaces the disconnected toolchain (EA tool + Confluence + spreadsheets + manual audits) with a single governed workspace where every definition is versioned, lifecycle-managed, and machine-evaluable.

## Core workflows

### Define Structures

A Structure is any dynamic entity with causal behavior — an application, a service, a team, a platform component. In TOGAF terms: an *Application Component*.

1. Navigate to **Governance > Structures** and create a new Structure.
2. Copilot suggests applicable TOGAF archetypes (`PhysicalApplicationComponent`, `LogicalApplicationComponent`) based on the description you provide.
3. Ascribe the Structure with its properties — purpose, data classification, owning team.

```json
{
  "purpose": "payment-gateway",
  "dataClassification": "pci-restricted",
  "owningTeam": "payments-team"
}
```

Every Structure starts in `DRAFT` and follows the [Ascription lifecycle]({% link oip/web-application/general-usage.md %}#the-ascription-lifecycle).

### Author Directives

Directives express governance intent. You write them using the [Directive grammar]({% link oip/web-application/general-usage.md %}#the-directive):

```
enterprise-architecture-board MUST ENSURE availability ON payment-gateway
enterprise-architecture-board MUST MINIMIZE latency ON payment-gateway
enterprise-architecture-board MUST ENSURE encryption ON cardholder-data-storage
```

Each Directive is owned by a governing Structure (the architecture board, a domain governor) and targets a governed Structure.

### Author Norms (Copilot-assisted)

Each Directive is operationalized into one or more measurable Norms using the [Norm grammar]({% link oip/web-application/general-usage.md %}#the-norm):

```
payment-gateway ON availability:
  WHEN scope == "production"
  ASSERT ServiceTelemetry.availability30d >= 0.999
  (SUSTAINED: 30d window, threshold 0.999)
```

Copilot assists: given a natural-language NFR like *"99.9% uptime over 30 days"*, it suggests the CEL assertion and tolerance mode.

### Compose ontology stacks

Ontologies provide pre-built governance vocabulary. You compose them into layered stacks:

1. Navigate to **Presets > Compose Stack**.
2. Select layers: **Geopolitical** (EU), **Regulatory** (GDPR, NIS2), **Industry** (PCI-DSS), **Cross-framework** (ISO 27001).
3. OIP resolves cross-preset interactions and flags overlaps.
4. Copilot proposes merged Norms where assertions are equivalent across frameworks.

The stack becomes the normative baseline for all Structures under your governance scope.

### Produce architecture deliverables

All architecture deliverables are authored within OIP from governed definitions:

- **Architecture Decision Records** — linked to the Directives and Norms that motivated them
- **Solution design documents** — generated from Structure topology, Mechanism details, and Interaction graphs
- **Component specifications** — authoritative framing for development teams
- **Regulatory coverage maps** — visual mapping of which preset frameworks cover which governance dimensions

Deliverables are published and served from OIP. No manual export to Confluence required (though sync is available).

## Using ontologies

### TOGAF

TOGAF archetypes structure the definition vocabulary for enterprise architecture. When defining Structures:

| TOGAF concept | GSM mapping | What you author |
|---|---|---|
| Business Function | Structure (function: business) | Purpose, capabilities, owning org unit |
| Application Component | Structure (function: application) | API contracts, dependencies, quality requirements |
| Technology Component | Structure (function: technology) | Platform, infrastructure, deployment shape |
| Architecture Principle | Directive | Governance intent — `MUST / SHOULD` statements |
| Architecture Contract | Norm | Measurable constraints with tolerance modes |

Filter views by TOGAF domain (Business / Application / Data / Technology Architecture) to work in familiar terms.

### ISO 25010 — Product Quality

Use ISO 25010 quality characteristics as the vocabulary for Norm assertions on software Structures:

- **ProductReliability** — availability, fault tolerance, recoverability
- **ProductSecurity** — confidentiality, integrity, non-repudiation
- **PerformanceEfficiency** — time behavior, capacity, resource utilization
- **Maintainability** — modularity, reusability, analyzability

Each characteristic is a sourced Archetype in OIP. You reference these in Norm `assertion` fields to create quality-governed definitions.

### ISO 25012 — Data Quality

For data-processing Structures, use ISO 25012 dimensions:

- **DataAccuracy**, **DataCompleteness**, **DataConsistency** — inherent quality
- **DataAvailability**, **DataRecoverability** — system-dependent quality

These apply when a Structure handles personal data, financial data, or other quality-sensitive datasets.

## Example: Onboard a new application under regulatory governance

**Context**: A new Payment Gateway service processes personal data and handles card transactions. It must comply with GDPR, PCI-DSS, and NIS2.

1. **Define the Structure** — create `payment-gateway` with purpose and data classification.
2. **Attach regulatory presets** — select GDPR, PCI-DSS, NIS2 from the Normative catalog. Copilot proposes applicable Directives and Norms.
3. **Author tenant Directives** — express governance intent specific to your organization.
4. **Author tenant Norms** — operationalize each Directive into measurable constraints.
5. **Generate governance diagram** — OIP produces a topology diagram showing the Structure, its Mechanisms, and regulatory coverage.
6. **Submit for approval** — transition to `PROPOSED` → governance review → `APPROVED` → `ACTIVE`.

**Result**: The Payment Gateway has a machine-evaluable compliance baseline before a single line of code is written.

## Example: Map an existing EA landscape into OIP

**Context**: 120+ applications documented in LeanIX/Mega/Ardoq need continuous governance.

1. **Bulk-import** — use *Import > Architecture Inventory* (CSV/JSON). Each row maps to a Structure.
2. **Attach cross-framework presets** — ISO 27001, SOC 2.
3. **Map existing NFRs** — bind NFR statements to Norm assertions. Copilot assists with CEL translation.
4. **Filterable landscape view** — group by TOGAF domain, overlay ISO 25010 quality, check ISO 25012 data quality coverage.

**Result**: The entire landscape is under continuous evaluation. Drift from ISO 27001 controls is detected automatically — not at the next annual audit.
