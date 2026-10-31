---
layout: default
title: "The GSM Manifesto"
parent: GSM Specifications
grand_parent: GSM — the standard
nav_order: 1
redirect_from:
  - /gsm/manifesto/
---

# The GSM Manifesto

> IT has learned to **build** systems and to **run** them. It has never learned to **think** them systematically — to govern, regulate, and align them as coherent wholes.
>
> The **Generative System Model (GSM)** exists to close that gap. It turns governance from prose that *describes* systems into definitions that *generate* them — typed, versioned, machine-evaluable, and open.
>
> This is a call to **define** systems rather than merely describe them, and to do it in the open, on shared ground — so the THINK layer of IT finally has the common standard that BUILD and RUN already enjoy.

---

## The gap

Every IT organization runs three activities. It **builds** systems, it **runs** them, and — in principle — it **thinks** them: governs, regulates, and aligns them.

BUILD and RUN have won their toolchains. Pipelines, source control, and DevOps platforms automate the building. Observability, incident management, and telemetry automate the running. THINK has no equivalent. The activity meant to *align* the other two survives in architecture wikis, compliance spreadsheets, and quarterly review boards.

The consequence is structural, not accidental. The **definition** of what a system should be — its purpose, its constraints, its obligations — lives in scattered, hand-maintained prose that drifts from reality the moment it is written. Governance becomes archaeology: something reconstructed under audit pressure, not something the system carries with it.

THINK deserves a standard. This is the case for one.

---

## The inversion: from describing to defining

Classical practice describes systems. GSM defines them. The difference is not cosmetic — it is a reversal of direction.

A **description** is a snapshot. It records what a system *is*, after the fact, in language meant for humans to read. A **definition** points the other way: it declares what a system *must become*, and it carries the governance machinery to get there. Description flows *from* the system; definition flows *into* it.

This is the **Generative Inversion**, and it is the core of GSM. A definition is not passive documentation trailing behind the system. It is the generative source: the thing **BUILD** implements and the thing **RUN** measures against. When build-side execution and run-side observation both reference the same governed definitions, they become coherent *with each other* — not by manual reconciliation, but by construction.

There is a hard reason this must be made explicit. As long as "what the system should be" lives implicitly in human heads and prose, it cannot be machine-checked, composed, or enforced. The implicit coupling a human mind carries effortlessly becomes an engineering problem the moment software — or an AI — is asked to reason over it. Making the definition explicit, typed, and machine-evaluable is what unlocks automation. This is the **Automation Gap**, and closing it is GSM's purpose.

---

## A grammar and a semantics

A standard for the THINK layer needs two things a wiki can never offer: a shared **grammar** for expressing governance, and shared **semantics** so that expression means the same thing everywhere. GSM provides both, on a deliberately small core.

**DNA — the generative governance grammar.** Every governed concern is expressed in three primitives:

- a **Directive** — strategic operational intent, declaring what a system must achieve or avoid;
- a **Norm** — a tactical, machine-evaluable assertion that operationalizes a Directive into something a machine can measure;
- an **Ascription** — the versioned, lifecycle-managed binding of a definition to the subject it governs.

DNA descends from slow-changing strategy to fast-moving measurement, and versions every step along the way. One enterprise principle and one service's latency threshold are expressed in the same grammar.

**Archetypes — the shared semantics.** A grammar alone does not know what *reliability* or *data protection* means. That meaning lives in **Archetypes**: typed domain schemas that fix vocabulary, grammar, and constraints, so meaning travels with the type instead of living in someone's memory.

**A small, fixed core.** GSM is **eight primitives** — Structure, Mechanism, Effector, Receptor, Interaction, Archetype, Directive, Norm — plus the DNA grammar. The core stays small so it stays coherent, and stays universal so everything else can build on it. Established frameworks — TOGAF, ISO 25010, ISO 25012, GDPR, NIS2, DORA — *source into* the core rather than forking it. Because every framework speaks the same DNA, they compose into one governance fabric instead of accumulating as silos.

---

## Why it must be open

A decade ago, RUN looked like THINK looks today. Every vendor shipped its own agent, its own format, its own semantics; telemetry was fragmented and locked in. **OpenTelemetry** changed that with a single open, vendor-neutral standard that every tool could emit and every backend could consume. It became the common ground of the RUN side.

THINK is still waiting for its OpenTelemetry.

GSM is the vendor-neutral standard for *defining systems*, the way OpenTelemetry is the vendor-neutral standard for *observing* them. Its generative governance grammar makes those definitions governable. A system definition should be portable: any tool should be able to produce it, and any tool should be able to consume it, without translation and without lock-in.

This is why GSM is open by design. It is implemented today by **SIE (Systemic Intelligence Engine)** — the reference implementation that hosts the model and runs its governance — and applied by **OIP**, the first domain application built on SIE. But the model is not the implementation. The standard is meant to be shared, so the THINK layer becomes common ground rather than fragmented territory.

---

## The principles

1. **Define systems; do not merely describe them.** A description records what a system *is*. A definition declares what it *must become* and carries the machinery to get there. We build from definitions.

2. **Make the implicit explicit.** Governance that lives in heads, wikis, and spreadsheets cannot be checked, composed, or enforced. What is not explicit cannot be automated.

3. **Definition is generative.** A definition is the single source from which execution is derived and against which observation is compared. BUILD implements it; RUN measures against it.

4. **Govern through a shared grammar.** Every governed concern — from an enterprise principle to a single threshold — is expressed as DNA: a Directive that sets intent, a Norm that makes it machine-evaluable, an Ascription that binds and versions it.

5. **Let meaning travel with the type.** Semantics belong in Archetypes — typed schemas that fix vocabulary, grammar, and constraints — not in free-form prose. Shared meaning makes definitions portable across tools and domains.

6. **Keep the core small and fixed; let frameworks source into it.** Eight primitives and one grammar. Frameworks map onto the core without forking it, so every standard composes into one fabric.

7. **Version every binding; govern its lifecycle.** Nothing governed is static. Every Ascription moves through an explicit, auditable lifecycle, so change is deliberate and traceable rather than silent drift.

8. **Close the loop continuously.** A definition is not filed and forgotten. Reality is evaluated against it without pause, and divergence is surfaced as it occurs — not discovered at audit time.

9. **Govern the whole, not the code.** IT systems are socio-technical. The decisions that matter are human governance decisions that precede and constrain the technical layer; the model governs those decisions, with code and telemetry downstream.

10. **Be open, or be fragmented.** A THINK layer owned by one vendor is not a standard. One open, vendor-neutral model, so every tool can emit and consume the same governed definitions.

---

## An invitation

GSM is young, and it is open. The model is implemented today by SIE and applied by OIP, but the standard belongs to everyone who governs systems — and it sharpens with every domain that adopts it.

- **See it applied.** Read how OIP brings GSM to IT governance in the **[OIP overview](https://docs.poesis.cloud/oip/)**.
- **Express your governance in it.** Learn the DNA grammar — Directives, Norms, and Ascriptions — in **[General Usage](https://docs.poesis.cloud/oip/web-application/general-usage/)**, and see how each IT role works in **[Usage Scenarios](https://docs.poesis.cloud/oip/web-application/usage-scenarios/)**.
- **Help refine it.** GSM grows by being sourced, stressed, and extended. Follow the work and contribute on **[GitHub](https://github.com/poesis-cloud)**.

Define once. Govern continuously. In the open.
