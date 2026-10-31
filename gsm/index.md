---
layout: default
title: "GSM — the standard"
nav_order: 4
has_children: true
---

# GSM — the standard

{: .no_toc }

The **Generative System Model (GSM)** is the vendor-neutral systemic standard at the foundation of Poesis. It is not a product you deploy — it is the shared model that every Poesis product implements: the **[SIE]({% link sie/index.md %})** engine hosts and enforces it, and domain applications such as **[OIP]({% link oip/index.md %})** translate it into their domain.

GSM is the vendor-neutral standard for *defining systems*, as OpenTelemetry is the vendor-neutral standard for *observing* them. Its generative governance grammar makes system definitions governed, typed, versioned, and machine-evaluable instead of trapping them in prose or proprietary tools.

GSM is at **v1.0** — normative content frozen while publication preparation continues — source-available under **BUSL-1.1** and developed as a candidate for contribution as an open standard. BUSL-1.1 is a source-available license, not an Open Source license.

## What GSM fixes

- **DNA — the generative governance grammar.** Every governed concern is expressed as a **Directive** (strategic intent), a **Norm** (a tactical, machine-evaluable assertion), and an **Ascription** (the versioned, lifecycle-managed binding of a definition to its subject).
- **Eight primitives.** Structure, Mechanism, Effector, Receptor, Interaction, Archetype, Directive, Norm — a deliberately small, fixed core.
- **Archetypes — the shared semantics.** Typed domain schemas that carry meaning (vocabulary, grammar, and constraints) so it travels with the type rather than living in prose.

## Products

- **Specifications** — the core spec: eight primitives, the DNA generative
  governance grammar, Archetyping, and the systemic lifecycle, prepared as a
  standards-track document set (intended home: OASIS Open). *Publication
  pending — the specification document set is being finalized for release.*
- **[Research Lab]({% link gsm/research-lab/index.md %})** — non-normative
  hypotheses, cases, and open decisions that may inform future GSM Change
  Proposals. Current **v1.0.0-beta.1**.
  - [Features]({% link gsm/research-lab/features.md %}) — the capability catalogue with milestones
- **[Ontology]({% link gsm/ontology/index.md %})** — domain, standard, and legal vocabularies sourced into GSM, ready to enforce. *Documentation in construction.*
  - [Features]({% link gsm/ontology/features.md %}) — the capability catalogue with milestones

Research published here is part of the technical documentation but is not part
of the normative Specification. GSM also has an academic-publication track (a
paper and a book); that track remains separate from this documentation site.
