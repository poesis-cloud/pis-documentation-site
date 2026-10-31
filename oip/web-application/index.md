---
layout: default
title: "OIP Web Application"
parent: OIP — the Organizational Intelligence Platform
nav_order: 1
has_children: true
redirect_from:
  - /itip/web-application/
---

# OIP Web Application

{: .fs-5 .fw-300 }

## The missing piece: a THINK solution for IT

Every IT organization runs three fundamental activities:

| Activity | What it does | Existing solutions |
|----------|-------------|-------------------|
| **BUILD** | Design, develop, deliver | CI/CD pipelines, IDEs, SCM, DevOps platforms |
| **RUN** | Supervise, operate, maintain | Observability (Datadog, Grafana), incident management, ITSM |
| **THINK** | Govern, regulate, align | *...nothing coherent* |

BUILD has mature, automated toolchains. RUN has real-time observability and remediation platforms. Both are well-served markets with deep competition and proven products.

But **THINK** — the activity that is supposed to *align* BUILD and RUN — has no equivalent. What exists today is a patchwork: architecture wikis nobody maintains, compliance spreadsheets updated before audits, governance review boards that meet quarterly while the landscape changes daily. There is no continuous, machine-enforceable, structurally coherent solution for the **definition** of what IT systems should be.

**OIP is the first complete THINK solution for IT.**

That is a deliberately provocative claim, so let's be precise about what "complete" means:

1. **Coherent** — OIP centralizes all definition concerns (architecture, governance, compliance, quality, operational constraints) in a single governed model. Not scattered across tools, not reconciled after the fact — structurally unified from the start.

2. **Generative** — definitions in OIP are not passive documentation. They are the *generative source* from which execution is derived and against which observations are compared. What you define in OIP is what BUILD implements and what RUN monitors.

3. **Connected** — OIP naturally links to both BUILD (code repositories, CI/CD, deployment pipelines) and RUN (observability, CMDB, incident management). By providing the authoritative definition layer, OIP makes BUILD and RUN coherent *with each other* — because both now reference the same governed definitions.

This is the **Definition–Execution–Observation** triad:

```
            ┌──────────────┐
            │    THINK     │
            │  Definition  │  ◄── OIP lives here
            │  (OIP/SIE)   │
            └──────┬───────┘
                   │
         ┌─────────┴─────────┐
         │                   │
         ▼                   ▼
  ┌──────────────┐   ┌──────────────┐
  │    BUILD     │   │     RUN      │
  │  Execution   │   │ Observation  │
  │  (CI/CD,     │   │ (Datadog,    │
  │   DevOps)    │   │  Grafana)    │
  └──────────────┘   └──────────────┘
```

**Definition is generative**: it tells BUILD *what to produce* and tells RUN *what to measure against*. Without a coherent definition layer, BUILD and RUN operate in isolation — BUILD ships what it thinks is right, RUN monitors what it thinks matters, and nobody can prove they're aligned.

---

## What problems does OIP solve?

If you work in IT — in any role — you've experienced these:

- **Architecture documentation that's permanently outdated.** Maintaining it is manual. Reality moves faster than documents. The architecture model and the actual system diverge within weeks of any review.

- **Compliance audits that are painful, expensive, and theatrical.** Evidence must be manually assembled every time. The gap between "what we said we'd do" and "what actually runs" is only discovered under audit pressure.

- **Impact analysis done by gut feeling.** "If I change this service, what breaks?" — answered by asking the longest-tenured engineer, not by tracing actual dependencies.

- **Governance standards that exist but aren't followed.** No mechanism continuously checks whether reality conforms to intent. Policies decay into shelfware.

- **Incident post-mortems that reveal governance blind spots.** An outage traces back to a dependency nobody documented, a constraint nobody enforced, a change nobody assessed.

- **Months of manual work to answer "what do we have?"** — because the actual inventory of systems, dependencies, and interfaces exists only in people's heads.

These are not tooling gaps. They are symptoms of the same root cause: **IT systems have never been governed as integrated wholes.** Organizations decompose governance into silos — architecture, security, compliance, operations — each with its own vocabulary, artifacts, and review cycle. Then they spend enormous effort trying to reconcile the pieces after the fact. The coherence is always late, always incomplete, and always fragile — because it was never structural.

**OIP makes coherence structural.** Every definition — from enterprise architecture directives to individual service constraints — lives in the same governed model, follows the same lifecycle, and is continuously evaluated against reality.

---

## OIP in the market ecosystem

OIP occupies a space that existing tool categories partially address but never unify:

| Tool category | What it does well | What it misses |
|--------------|------------------|----------------|
| **EA tools** (LeanIX, Mega, Ardoq) | Architecture modeling, portfolio views | No continuous governance enforcement, no code-sourced truth, no compliance automation |
| **GRC platforms** (ServiceNow GRC, Archer) | Risk registers, control frameworks | Disconnected from architecture reality, no definition-level governance |
| **CMDB** (ServiceNow, BMC) | Asset inventory | Static snapshots, no governance intent, no quality/viability constraints |
| **Observability** (Datadog, Grafana) | Real-time monitoring | Monitors what *is*, not what *should be* — no governance context for alerts |
| **DevOps/CI-CD** (GitHub Actions, GitLab CI) | Build & deploy automation | Executes, but doesn't know *why* — no definition-level governance |

OIP is not a replacement for any of these. It is the **definition layer that connects them**. OIP provides the governed definitions that EA tools describe, that GRC platforms audit, that CMDBs inventory, that observability measures against, and that CI/CD implements.

---

## GSM: the standard THINK has been missing

RUN was not always well-served. A decade ago, observability looked much like THINK does today: every vendor shipped its own agent, its own format, its own semantics — a fragmented, lock-in-ridden mess. Then **OpenTelemetry** changed it: one open, vendor-neutral, semantic standard for telemetry that every tool could emit and every backend could consume. It became the lingua franca of RUN.

THINK is still waiting for its OpenTelemetry. The definition of what systems *should be* — architecture, governance, compliance, quality — lives in incompatible, proprietary silos that nobody can compose or verify.

**GSM is the intended standard.** What OpenTelemetry did for *observing* systems — a shared semantic model that ended fragmentation — GSM does for *defining* them: one vendor-neutral standard (a candidate open standard) that pairs a generative governance **grammar** (DNA) with shared **semantics** (Archetypes).

---

## How OIP works: DNA governance

OIP is built on **SIE (Systemic Intelligence Engine)**, which implements the **Generative System Model (GSM)** — the vendor-neutral standard for defining systems.

At the heart of GSM is a generative governance grammar called **DNA**. Its
three layers also express governance tempo:

| Letter | Primitive | What it does |
|--------|-----------|-------------|
| **D** | Directive | A **strategic operational intent** — declares what a system *must* achieve or avoid |
| **N** | Norm | A **tactical assertion and measure** — operationalizes a Directive into an enforceable, machine-evaluable constraint |
| **A** | Ascription | Binds any definition to its governed subject — the versioned, lifecycle-managed snapshot |

DNA is OIP's universal axis for defining IT systems. It descends from strategy to measurement: a **Directive** sets the slow-changing strategic operational intent, a **Norm** makes it tactical — the assertions and measures that turn intent into something machines can enforce — and an **Ascription** versions every change. Every piece of governed information — from an enterprise architecture principle to a single service's latency threshold — is expressed as DNA.

This is not metaphorical. DNA has a precise grammar:

- A **Directive** reads: *"The architecture board MUST ENSURE availability OF the payment gateway"*
- A **Norm** reads: *"The payment gateway ON availability: ASSERT availability30d >= 0.999 (SUSTAINED over 30d)"*
- An **Ascription** binds these definitions to their subjects with a governed lifecycle (DRAFT → PROPOSED → APPROVED → ACTIVE → ... → RETIRED)

[General Usage]({% link oip/web-application/general-usage.md %}) walks through each DNA primitive in detail with practical examples.

---

## Frameworks — extending the standard

GSM's core is deliberately minimal: eight primitives and the DNA grammar. That fixed core is small enough to stay coherent yet universal enough to describe any system — but a grammar alone doesn't know what *reliability*, *data confidentiality*, or *GDPR Article 32* mean. That **semantics** — the domain meaning a definition carries — comes from **Frameworks**.

A Framework is an established body of knowledge — TOGAF, ISO 25010, ISO 25012, GDPR, NIS2, DORA, SOC 2 — **sourced into GSM**. Sourcing renders the framework in GSM's own terms: domain **Archetypes** that build on GSM's base schemas with new viability dimensions and structural types, plus ready-made **Directives** and **Norms** that encode the framework's requirements as governance you can actually enforce. An Archetype is all three layers at once — **vocabulary** (a named domain type), **grammar** (it slots into DNA as a qualifier or typing), and **semantics** (its schema fixes each property — its constraints, its relationships, and a normative *description* that states what the property actually means — so the meaning travels with the type rather than living in someone's head).

So frameworks both **constitute** and **extend** the standard:

- They **constitute** governance — filling the grammar with the real Directives and Norms an organization must honor, drawn straight from the authoritative source instead of reinvented project by project.
- They **extend** the semantics — adding domain types, and the meaning they carry, on top of the fixed core, the way OpenTelemetry's semantic conventions extend its small core without changing it. The eight primitives never fork; the shared vocabulary grows.

And because every framework speaks the same DNA, they compose. A regulatory standard, a quality model, and an architecture framework layer into one coherent governance fabric — no reconciliation, no silos. Adopt a framework and its governance is *already* expressed, versioned, and enforceable in your model.

[General Usage]({% link oip/web-application/general-usage.md %}) covers the ontology catalogue and how to compose ontology stacks in practice.

---

## Grounding AI and agents in governed truth

Semantics is what lets anyone — human or machine — *act upon* a definition instead of merely reading it. Because every GSM definition is typed by an **Archetype**, its meaning is explicit and machine-readable, so humans and **AI and agentic systems** alike can reason and generate from it directly. That gives generative models something they rarely have: a governed, semantic account of what a system *is*, what it *must* do, and *why* — meaning to act on, not prose to reinterpret on every call.

**GSM and its sourcers are the logical evolution of a RAG.** Where a RAG *indexes* raw documentation and code for AI context, GSM's sourcers go one step further and *structure* it — parsing documentation, specs, and repositories into governed definitions once. The result is a **write-once, read-many (WORM)** corpus: the costly parse-and-structure work is paid a single time, then humans and agents consume those definitions repeatedly, with no re-parsing or re-interpretation on each call.

This is where the economics tip. The AI does the expensive cognitive work — turning raw material into a structured definition — exactly **once**. Because the result is governed and structured, OIP's **deterministic generators** (an artifact factory, a document renderer, a scaffolder) can then project that definition into concrete outputs — diagrams, reports, code skeletons, compliance evidence — any number of times, identically, at *zero marginal cost*. Without a structured definition to draw on, every one of those outputs means asking an LLM again: paying tokens each time, waiting each time, and accepting a slightly different answer each time. Define once with AI; regenerate forever for free.

And because GSM's primitives encode **causality** — Mechanisms with their Effectors and Receptors, and the Interactions that couple them — a definition carries not just *what* a thing is but *what causes what*. That is what enables recursive causal reasoning — the why behind the why behind the why — which is precisely what intelligence *is*.

Reasoning over a governed, causal model instead of retrieved text makes the payoff compound:

- **Grounded** — generation is anchored in governed truth, not training priors, so hallucination drops.
- **Deterministic** — output is harnessed by GSM's types and lifecycle, not left to free-form invention.
- **Higher quality** — authoritative, typed context yields verifiable results.
- **Lower cost** — precise structured context shrinks the tokens, and the retries, that vague prompting wastes.

This is what makes OIP's Copilot more than a chatbot: it reasons over a *governed, causal model*, not a pile of documents.

---

## IT systems are socio-technical systems

Before diving into DNA mechanics, one foundational insight that shapes everything in OIP:

**IT systems are fundamentally human systems, not technical systems.**

This is not philosophy — it's an observable structural reality. Consider:

- **Who decides what a service does?** A product owner, an architect, a tech lead — humans. The service's purpose, boundary, and quality requirements are human governance decisions that *precede* any code.

- **Who decides how services interact?** API contracts, integration patterns, data flows — all defined by humans (architects, developers) before they are implemented. The interaction topology is a governance artifact.

- **Who decides what "healthy" means?** SLOs, SLAs, compliance thresholds — defined by humans (ops engineers, compliance analysts, business owners). The system doesn't know it's healthy; humans define the criteria and machines measure against them.

- **Who decides when something changes?** Change approval boards, PR reviews, deployment gates — human governance processes that control how and when the technical system evolves.

- **When an incident happens, what failed?** Almost always: a governance gap. A dependency nobody documented. A constraint nobody enforced. A change nobody assessed. The technical failure is the symptom; the governance failure is the cause.

The technical layer — code, infrastructure, networks — is a *medium*, not the system itself. The system is the socio-technical whole: humans defining intent, machines executing it, observations feeding back to human decisions.

**OIP embraces this.** Definition IS the generative part — the human governance decisions from which we execute, and against which we compare observations. Code repositories, running services, telemetry data — these are downstream artifacts of definition decisions. OIP governs the definitions, and in doing so, governs the entire lifecycle.

DNA is the lever that makes this practical: a universal, machine-enforceable grammar for expressing human governance intent over technical systems. Every Directive is a human decision. Every Norm is a human constraint made measurable. Every Ascription is a governed snapshot of that decision at a point in time.

**Next: [General Usage — DNA in Practice →]({% link oip/web-application/general-usage.md %})**
{: .fs-5 .fw-300 }
