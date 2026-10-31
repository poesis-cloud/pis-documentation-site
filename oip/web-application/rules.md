---
layout: default
title: Rules
parent: OIP Web Application
grand_parent: OIP — the Organizational Intelligence Platform
nav_order: 5
redirect_from:
  - /itip/rules/
  - /itip/web-application/rules/
---

# Rules

{: .no_toc }

These are the rules that govern how definitions behave in OIP. Understanding them prevents surprises when creating, updating, or deprecating governed definitions.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Lifecycle rules

Every definition in OIP — every Structure, Directive, Norm, Mechanism, and Archetype — follows the same Ascription lifecycle. This lifecycle is enforced by the engine; it cannot be bypassed.

### The lifecycle states

```
                         ┌──────────┐
                    ┌───>│ ABANDONED│ (terminal)
                    │    └──────────┘
              ┌─────┴─┐   SUBMIT    ┌──────────┐  APPROVE   ┌──────────┐
  CREATE ───> │ DRAFT  │──────────> │ PROPOSED │──────────> │ APPROVED │
              └────────┘            └─────┬────┘            └─────┬────┘
                                          │                       │
                                    REJECT│                ACTIVATE│
                                          ▼                       ▼
                                   ┌──────────┐            ┌──────────┐
                                   │ REJECTED │            │  ACTIVE  │◄──RESTORE──┐
                                   │(terminal)│            └────┬─┬───┘            │
                                   └──────────┘         SUSPEND│ │DEPRECATE  ┌─────┴────┐
                                                               ▼ │          │ SUSPENDED │
                                                        ┌──────┴─┐          └──────────┘
                                                        │SUSPEND.│──────────────►
                                                        └────────┘
                                                               │
                                                        DEPRECATE (also from SUSPENDED)
                                                               ▼
                                                        ┌────────────┐  RETIRE  ┌─────────┐
                                                        │ DEPRECATED │────────> │ RETIRED │
                                                        └────────────┘          │(terminal)│
                                                                                └─────────┘
```

### You cannot edit an ACTIVE definition directly

To modify an ACTIVE definition, you create a **new Ascription** of the same Definition. The new Ascription starts in `DRAFT` and goes through the full lifecycle. When the new version reaches `ACTIVE`, the previous one is automatically transitioned to `DEPRECATED`.

**Why**: governance requires that every change is reviewed and approved. Direct edits would bypass the review process.

### Terminal states are permanent

`RETIRED`, `ABANDONED`, and `REJECTED` are permanent. Once a definition reaches a terminal state, no further transitions are possible. There is no "undo retire."

### Version numbers are assigned at approval, not at creation

Versions are monotonically increasing integers assigned when an Ascription transitions to `APPROVED`. Drafts and proposals do not have version numbers. This means version numbers represent reviewed, approved snapshots — not editing iterations.

### Only one APPROVED Ascription per Definition at a time

A new Ascription of the same Definition cannot be `APPROVED` while another Ascription of that Definition is already in `APPROVED` state. You must activate (or abandon) the existing approved version first.

### Activation handoff is automatic

When a new Ascription reaches `ACTIVE`, the previously `ACTIVE` Ascription of the same Definition is automatically transitioned to `DEPRECATED`. You do not need to manually deprecate the old version.

---

## Governance chain rules

### You cannot create a Norm without a Directive

A Norm is always operationalized within a Directive's governance scope. The chain linkage is:

```
Directive.purpose (the governed Structure) == Norm.structure (the governed Structure)
```

A Norm without a corresponding Directive has no governance scope. The Directive expresses *governance intent*; the Norm expresses *how to measure compliance* with that intent.

### A Directive requires a governing Structure and a governed Structure

A Directive is a constitutive act between two Structures:

- The **governing Structure** (e.g., an architecture board) authors the Directive
- The **governed Structure** (e.g., a payment gateway) is the target

Both must exist before the Directive can be created. A Directive without a governing Structure has no authority. A Directive without a governed Structure has no target.

### Norms constrain the governed Structure's elements, not the governing Structure

A Norm's `assertion` evaluates against properties of the *governed* Structure. The governing Structure defines governance intent; the governed Structure bears the constraints.

---

## Identity rules

### Identity-bound properties cannot change across versions

Some properties are marked as **identity-bound** — they define what a definition *is*, not what it *contains*. Changing these values across versions of the same Definition is not allowed; it would constitute a different Definition.

Examples of identity-bound properties:

| Definition type | Identity-bound properties |
|----------------|--------------------------|
| Structure | `purpose` |
| Mechanism | `structure` (owning Structure), `function` |
| Effector | `mechanism`, `archetype` (output type) |
| Receptor | `mechanism`, `archetype` (input type) |
| Interaction | `effector`, `receptor` |
| Directive | `structure` (governing), `qualifier`, `purpose` (governed) |
| Norm | `structure` (governed), `qualifier`, `assertion` |

**If you need to change an identity-bound property, you must create a new Definition** — deprecate/retire the old one and create a fresh Definition with the new identity.

### Structure purpose must be globally unique

Among all **in-effect** Structures (those with status `ACTIVE` or `DEPRECATED`), no two can share the same `purpose`. The purpose is both the identity and the governance address.

### Mechanism function must be unique within its owning Structure

Among all in-effect Mechanisms belonging to the same Structure, no two can share the same `function`.

---

## Referee rules

### References must be in a compatible lifecycle state

When a definition references another definition (e.g., a Mechanism references its owning Structure, a Directive references its governing Structure), the referenced definition must be in a lifecycle state compatible with the transition being attempted.

The rules:

| Transitioning to | Referenced definition must be in |
|------------------|----------------------------------|
| DRAFT | Any non-terminal state |
| PROPOSED | Any non-terminal state |
| APPROVED | APPROVED, ACTIVE, or DEPRECATED |
| ACTIVE | ACTIVE or DEPRECATED |

**In practice**: you cannot activate a Mechanism if its owning Structure is not yet active. You cannot approve a Norm if the governed Structure hasn't been approved yet.

### The dependency chain must be resolved bottom-up

Because of referee preconditions, you must activate definitions in dependency order:

1. **Archetypes** first (they have no references to other definitions)
2. **Structures** (reference Archetypes for typing)
3. **Mechanisms** (reference their owning Structure)
4. **Effectors / Receptors** (reference their owning Mechanism and data Archetypes)
5. **Interactions** (reference an Effector and a Receptor)
6. **Directives** (reference governing Structure, governed Structure, and qualifier Archetype)
7. **Norms** (reference governed Structure and qualifier Archetype)

---

## Cascade rules

When a definition transitions, other definitions that depend on it may need to transition too. OIP handles this automatically through three cascade types.

### Constitutive cascades (Mechanism → Effector/Receptor)

When a Mechanism transitions, its Effectors and Receptors are cascaded to the same state. If any Effector or Receptor cascade fails, **the Mechanism transition is blocked**.

**Why**: Effectors and Receptors are constitutive parts of a Mechanism. A Mechanism cannot be active without its ports.

### Governing cascades (Structure → Mechanisms, Directives, Norms)

When a Structure transitions, its Mechanisms, Directives, and Norms are cascaded. If any individual cascade fails, **the Structure transition proceeds anyway** (no-op for the failed target).

**Why**: governance is best-effort propagation. A Structure deprecation shouldn't be blocked because one of its Norms has a dependency issue.

### Dependent cascades (Effector/Receptor → Interactions)

When an Effector or Receptor transitions to a degradation or terminal state, its connected Interactions are cascaded. If any cascade fails, the source transition proceeds anyway.

**Why**: Interactions depend on their ports but should not block port lifecycle management.

---

## Archetype rules

### Structural vs. rootless Archetypes

Not all Archetypes serve the same role:

| Archetype type | Has `$ref` chain to a GSM base? | Can type a definition? | Can qualify a Directive/Norm? |
|---|---|---|---|
| **Based** | Yes | Yes | Yes |
| **Rootless** | No | No (qualifier/data roles only) | Yes |

A based Archetype determines what kind of definition it types (Structure, Mechanism, etc.) via its `$ref` chain to a GSM base. A rootless Archetype is a vocabulary concept — quality dimensions, domain classifications, data types — used as qualifiers in Directives/Norms or as data types in Effector/Receptor ports.

### Tenant Archetypes extend base Archetypes via `$ref`

You do not modify base Archetypes. Tenant Archetypes extend them using a top-level `$ref` to the GSM base. Additional facets (applicable property sets) can be composed via `allOf`. The base Archetype chain is sealed — tenant schemas add properties but cannot override base constraints.

### The `statement` field IS the JSON Schema

An Archetype's `statement` is the governed JSON Schema document itself. When you create an Ascription of a definition typed by this Archetype, the `statement` of the Ascription is validated against this schema.

---

## Norm expression rules

### Applicability uses restricted CEL

The `applicability` field is a CEL expression in **axis-predicate normal form**:

```
ArchetypeName.property == "value" && ArchetypeName.otherProperty > 10
```

Restrictions:

- Only `&&` conjunction and `||` within a single axis
- No function calls, no variable bindings, no negation of compound expressions
- Default is `"true"` (unconditional — the Norm applies to all instances)

### Assertion uses standard CEL

The `assertion` field is a more permissive CEL expression returning boolean. It supports arithmetic, string operations, list operations, but no side effects.

The root identifier in the assertion references the qualifier Archetype by its `title`.

### Tolerance modes determine evaluation semantics

| Mode | Semantics | Required parameters |
|------|-----------|-------------------|
| **INSTANTANEOUS** | Every measurement must pass | None |
| **AGGREGATED** | A statistical aggregate over a time window must pass | `temporalWindow`, `temporalAggregation` |
| **SUSTAINED** | The assertion must hold for a sustained fraction of a time window | `temporalWindow`, `sustainedThreshold` |

Choosing the wrong tolerance mode will either generate false violations (INSTANTANEOUS on a metric that naturally fluctuates) or miss real violations (SUSTAINED on a metric that should never breach).

---

## Framework composition rules

### Preset Directives and Norms are read-only

Framework presets (GDPR, NIS2, PCI-DSS, ISO 27001) are sourced from the Poesis Normative SIE. They are **read-only** — you cannot modify preset Norms. You can:

- **Attach** presets to your Structures
- **Compose** multiple presets into stacks
- **Author tenant Norms** that complement presets

### Frameworks compose, they don't conflict

When multiple frameworks are attached to the same Structure, OIP resolves overlaps:

- Equivalent assertions across frameworks are merged (one Norm satisfies both)
- Complementary assertions coexist (each Norm evaluates independently)
- Contradictory assertions are flagged for manual resolution (rare — frameworks are designed to be compatible)

### Vocabulary mapping is per-framework

Each framework maps its concepts to OIP's domain labels. TOGAF uses "Application Component" for Structure, "Architecture Principle" for Directive. ISO 25010 uses quality characteristic names as Archetype titles. The underlying GSM primitive is the same; the label changes per framework context.
