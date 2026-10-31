---
layout: default
title: "DNA in Practice — Directives, Norms, Ascriptions"
parent: OIP Web Application
grand_parent: OIP — the Organizational Intelligence Platform
nav_order: 3
redirect_from:
  - /itip/general-usage/
  - /itip/web-application/general-usage/
---

# DNA in Practice — Directives, Norms, Ascriptions
{: .no_toc }

This page walks through the three DNA primitives as a user encounters them in OIP. Each section presents the grammar, practical examples, and how it appears in the OIP interface.

<details open markdown="block">
  <summary>Table of contents</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## Directive — Strategic Governance Intent

A **Directive** is a governance declaration. It is the formal act by which a governing entity (a team, board, or organization) opens a governance relationship with a governed entity (a service, platform, business unit) along a specific viability dimension.

Directives are **slow-changing** and **strategic**. They express *what must be achieved or avoided* — not how to measure it, not the technical threshold. A Directive may live unchanged for years while the Norms that operationalize it evolve.

### Grammar

A Directive follows a natural-language sentence structure:

```
{governing structure} {modal} {verb} {qualifier} ON {governed structure}
```

| Field | What it means | Examples |
|-------|--------------|---------|
| **Governing structure** | The entity that *owns* this governance intent | `enterprise-architecture-board`, `security-team`, `platform-team` |
| **Modal** | Obligation strength | `MUST`, `MUST_NOT`, `SHOULD`, `SHOULD_NOT`, `MAY` |
| **Verb** | Governance action | `ENSURE`, `PREVENT`, `MAINTAIN`, `OPTIMIZE`, `MINIMIZE`, `MAXIMIZE`, `MONITOR`, `ENABLE` |
| **Qualifier** | The viability dimension being governed (references an Archetype) | `ProductReliability`, `DataConfidentiality`, `ServicePerformance` |
| **Governed structure** | The entity being governed | `payment-gateway`, `customer-portal`, `data-pipeline` |

### Reading a Directive

```
enterprise-architecture-board MUST ENSURE ProductReliability ON payment-gateway
```

This reads: *"The enterprise architecture board declares that the payment gateway must ensure product reliability."*

There is no threshold, no technical detail — just the governance intent. The Directive establishes that:
- The `enterprise-architecture-board` is the governor
- `payment-gateway` is the governed entity
- `ProductReliability` is the viability dimension at stake
- The obligation is mandatory (`MUST`) and the direction is positive (`ENSURE`)

### More Directive examples

| Directive | What it means |
|-----------|--------------|
| `security-team MUST PREVENT DataExposure ON customer-portal` | The security team mandates that the customer portal must not expose sensitive data |
| `platform-team SHOULD OPTIMIZE ServicePerformance ON api-gateway` | The platform team recommends performance optimization for the API gateway |
| `compliance-office MUST MAINTAIN RegulatoryAdherence ON billing-service` | The compliance office requires continuous regulatory adherence for the billing service |
| `cto-office MAY ENABLE AICapability ON recommendation-engine` | The CTO's office permits (but does not require) AI capability adoption for the recommendation engine |

### What Directives are NOT

- **Not a policy document.** A Directive is a single, atomic governance statement — not a multi-page policy.
- **Not a technical constraint.** There is no threshold, metric, or CEL expression in a Directive. That is the Norm's job.
- **Not a one-time decision.** Directives are governed artifacts with a lifecycle (DRAFT → ACTIVE → DEPRECATED → RETIRED). They evolve, they are versioned, they are auditable.

### Using Directives in OIP

In OIP, you create Directives in the **Governance Authoring** workspace:

1. Navigate to **Governance > Directives > New Directive**
2. Select the **governing structure** (your team or board)
3. Choose the **modal** and **verb** from the dropdowns
4. Select or create the **qualifier** (viability dimension)
5. Select the **governed structure** (the entity you're governing)
6. Submit for governance approval (DRAFT → PROPOSED → APPROVED → ACTIVE)

OIP's Copilot can assist: describe your intent in natural language, and the AI suggests the structured Directive form.

---

## Norm — Tactical, Measurable Constraint

A **Norm** operationalizes a Directive. Where a Directive says *"ensure reliability"*, a Norm says *"availability must be ≥ 99.9% measured over 30 days"*. Norms are **measurable, machine-evaluable assertions** — they are how governance intent becomes enforceable.

Norms are **medium-speed** — more tactical than Directives, more strategic than raw implementation. A Directive may have multiple Norms, each constraining a different measurable aspect of the viability dimension.

### Grammar

A Norm follows this structure:

```
{governed structure} ON {qualifier}: WHEN {applicability} ASSERT {assertion} ({tolerance mode})
```

| Field | What it means | Examples |
|-------|--------------|---------|
| **Governed structure** | The entity being constrained (same as the Directive's governed structure) | `payment-gateway` |
| **Qualifier** | The viability dimension (same as or refining the Directive's qualifier) | `ProductReliability` |
| **Applicability** | When this Norm activates — a boolean condition | `"true"` (always), `ServiceTelemetry.environment == "production"` |
| **Assertion** | The compliance condition — a boolean expression over the qualifier's properties | `ServiceTelemetry.availability30d >= 0.999` |
| **Tolerance mode** | How violations are measured over time | `INSTANTANEOUS`, `AGGREGATED`, `SUSTAINED` |

### Reading a Norm

```
payment-gateway ON ProductReliability:
  WHEN ServiceTelemetry.environment == "production"
  ASSERT ServiceTelemetry.availability30d >= 0.999
  (SUSTAINED over P30D, threshold 0.95)
```

This reads: *"For the payment gateway, on the product reliability dimension: when the environment is production, assert that 30-day availability is at least 99.9%, sustained over a 30-day window with at most a 5% violation allowance."*

### Tolerance modes

| Mode | Meaning | Use when |
|------|---------|----------|
| **INSTANTANEOUS** | Every single evaluation must pass | Hard constraints: encryption standards, schema compliance |
| **AGGREGATED** | Aggregate (avg, p95, count...) over a time window must pass | SLO-style metrics: average latency, error rate |
| **SUSTAINED** | A percentage of evaluations over a time window must pass | Availability targets: allow brief dips within an error budget |

### More Norm examples

| Norm | What it measures |
|------|-----------------|
| `payment-gateway ON DataConfidentiality: ASSERT EncryptionStandard.algorithm == "AES-256" (INSTANTANEOUS)` | Every evaluation must confirm AES-256 encryption |
| `api-gateway ON ServicePerformance: ASSERT ServiceTelemetry.p95LatencyMs <= 200 (AGGREGATED over P1H, aggregation P95)` | 95th percentile latency must stay under 200ms, aggregated hourly |
| `billing-service ON RegulatoryAdherence: WHEN GDPR.dataCategory == "personal" ASSERT GDPR.retentionDays <= 730 (INSTANTANEOUS)` | Personal data retention must not exceed 2 years |

### Directive–Norm chain

Every Norm must be linked to a Directive. The chain linkage is:

```
Directive.purpose (governed structure) == Norm.structure (governed structure)
```

This means you cannot create a Norm on a structure that no Directive governs. The Directive *opens the scope*; the Norm *fills it with constraints*. If the architecture board hasn't declared a reliability Directive on the payment gateway, no one can attach reliability Norms to it.

This is deliberate: **governance must be intentional, not accidental.** Every constraint traces back to a declared governance intent.

### Using Norms in OIP

1. Navigate to **Governance > Norms > New Norm**
2. Select the **governed structure** (shows only structures with active Directives)
3. Select or create the **qualifier** Archetype
4. Write the **applicability** condition (or leave as `"true"` for unconditional)
5. Write the **assertion** expression using the qualifier's properties
6. Choose the **tolerance mode** and configure temporal parameters if needed
7. Submit for governance approval

OIP's Copilot can help: describe a natural-language NFR like *"The service should respond in under 200ms for 95% of requests"*, and the AI suggests the CEL assertion and tolerance mode.

---

## Ascription — The Governed Snapshot

An **Ascription** is the governed binding between a definition and its subject. Every artifact in OIP — every Structure, every Directive, every Norm, every Mechanism — is an Ascription. It is the universal "is-typed-by" statement that carries:

- **What** is being defined (the Definition — a stable identity)
- **As what** it is typed (the Archetype — a JSON Schema)
- **The governed content** (the statement — validated against the Archetype)
- **Its lifecycle state** (DRAFT → ... → RETIRED)
- **Its version** (assigned at approval, monotonically increasing)

Ascriptions are **fast-changing** and **technical**. They are what you actually create and edit in OIP day-to-day. When you "create a Structure" in OIP, you are creating an Ascription of type Structure. When you "update a Norm", you are creating a new Ascription version of an existing Norm Definition.

### Lifecycle states

Every Ascription follows the same lifecycle:

```
           ┌─────────┐
    CREATE │  DRAFT  │ ABANDON ──► ABANDONED
           └────┬────┘
                │ SUBMIT
           ┌────▼─────┐
           │ PROPOSED │ REJECT ──► REJECTED
           └────┬─────┘
                │ APPROVE
           ┌────▼─────┐
           │ APPROVED │    (version number assigned here)
           └────┬─────┘
                │ ACTIVATE
           ┌────▼─────┐              ┌───────────┐
           │  ACTIVE  │◄── RESTORE ──│ SUSPENDED │
           └──┬────┬──┘── SUSPEND ──►└───────────┘
              │    │
    DEPRECATE │    │
           ┌──▼────┘
           │ DEPRECATED │
           └──────┬─────┘
                  │ RETIRE
           ┌──────▼─────┐
           │  RETIRED   │
           └────────────┘
```

| Phase | States | What happens |
|-------|--------|-------------|
| **Authoring** | DRAFT | You're writing it. Not visible to governance. |
| **Review** | PROPOSED | Submitted for review. Governance can approve or reject. |
| **Ready** | APPROVED | Approved and versioned. Ready to activate. |
| **In-effect** | ACTIVE, DEPRECATED | Live and enforceable. Norms in ACTIVE state are evaluated. |
| **Paused** | SUSPENDED | Temporarily inactive (e.g., during maintenance). |
| **Terminal** | RETIRED, ABANDONED, REJECTED | Permanent end state. No further transitions. |

### Versioning

When you update a definition, you don't edit the existing Ascription. You create a **new Ascription** of the same Definition:

1. The existing Ascription stays ACTIVE (or whatever state it's in)
2. You create a new DRAFT Ascription under the same Definition
3. The new Ascription goes through the full lifecycle (DRAFT → PROPOSED → APPROVED → ACTIVE)
4. When the new one becomes ACTIVE, the old one auto-transitions to DEPRECATED

This means every change is auditable, every version is preserved, and you can always diff between versions.

### Using Ascriptions in OIP

You rarely interact with "Ascriptions" directly — OIP presents them as the definitions themselves (Structures, Directives, Norms, etc.). But understanding the Ascription model helps you understand:

- **Why everything has a lifecycle** — because everything *is* an Ascription
- **Why you can't edit an ACTIVE definition directly** — you create a new version (new Ascription)
- **Why approval is required** — every change goes through the governance lifecycle
- **Why you can diff versions** — each version is a separate Ascription with the same Definition identity

---

## Ontologies — Governance Building Blocks

Frameworks are **pre-built governance vocabularies** sourced from established standards (TOGAF, ISO 25010, GDPR, NIS2, etc.). They provide ready-made Archetypes, Directives, and Norms that you can adopt, compose, and customize in OIP.

Instead of starting governance from scratch, you compose **ontology stacks** — layered combinations of regulatory, quality, and architectural standards that apply to your systems.

### What ontologies provide

| Framework type | Examples | What they bring |
|---------------|---------|----------------|
| **Architecture** | TOGAF | Vocabulary for structures, behaviors, governance — organized by architecture domain (Business, Application, Data, Technology) |
| **Quality** | ISO 25010, ISO 25011, ISO 25012 | Quality dimension Archetypes (reliability, security, performance, data accuracy, etc.) that become qualifier dimensions for Directives and Norms |
| **Regulatory** | GDPR, NIS2, PCI-DSS | Pre-built Directives and Norms that encode regulatory requirements as machine-evaluable governance |
| **Industry** | ISO 27001, SOC 2 | Control frameworks translated into Directive/Norm pairs |

### Composing ontology stacks

In OIP, you compose frameworks into governance stacks:

1. **Browse** available ontologies in the ontology catalogue
2. **Inspect** their Directives and Norms to understand what governance they encode
3. **Compose** a multi-ontology stack (e.g., TOGAF + ISO 25010 + GDPR + NIS2)
4. **Resolve conflicts** where frameworks overlap or contradict
5. **Attach** the composed stack to your governed structures

Once attached, framework Norms are evaluated alongside your custom Norms — same lifecycle, same continuous compliance evaluation.

### Ontologies as vocabulary

Beyond governance constraints, frameworks provide the **vocabulary** you use to describe your IT landscape. TOGAF's architecture domains give you structured terminology for business, application, data, and technology layers. ISO quality models give you standardized dimensions for reliability, security, performance, and data quality.

OIP renders these vocabularies as browsable catalogs with framework-native labels. A TOGAF user sees "Application Component" where the underlying GSM model says "Structure". An ArchiMate user sees relationship types they recognize. The mapping is configurable per user profile.

**Next: [Usage Scenarios — Per IT Profile →]({% link oip/web-application/usage-scenarios/index.md %})**
{: .fs-5 .fw-300 }
