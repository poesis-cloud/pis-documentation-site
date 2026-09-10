---
layout: default
title: "GSM Project Charter"
parent: GSM Specifications
grand_parent: GSM — the standard
nav_order: 6
redirect_from:
  - /gsm/charter/
---

# GSM Project Charter
{: .no_toc }

**Status:** Proposed — not in force
{: .fs-5 .fw-300 }

This charter describes the **proposed** governance for the GSM standard if it is contributed to a neutral standards consortium — the intended home is [OASIS Open](https://www.oasis-open.org/). It is a draft of intent by the originating maintainer (Poesis). It is **not** an enacted governance document, and it does not yet bind any party. Until enacted, the source repositories' existing `CONTRIBUTING`, `LICENSE`, and `GOVERNANCE` files remain authoritative.

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Mission

To define and steward **GSM** as an open, vendor-neutral standard for *defining and governing* software-intensive systems — the THINK-layer complement to runtime standards such as OpenTelemetry — so that governed definitions are portable across tools rather than locked in proprietary silos.

## 2. Scope

**In scope.** The normative model (the eight primitives, the DNA grammar, the Archetype type system, the `$gsm:*` vocabulary, the Ascription lifecycle, the expression-language profiles), the canonical JSON interchange, the conformance catalog, and supporting non-normative material (primer, glossary, mappings).

**Out of scope.** Specific storage engines, transports, UIs, the descriptive/observability counterpart (covered by other standards), and any single vendor's commercial product. A reference implementation MAY be stewarded as a separate sub-project under its own license.

## 3. Values

1. **Small, coherent core.** Additions are resisted by default; the burden of proof is on growth.
2. **Vendor neutrality.** No requirement may privilege one vendor, language, or platform.
3. **Backwards compatibility.** Breaking changes are rare, versioned, and migration-documented.
4. **Decisions in the open.** Substantive change happens through public proposals and review.
5. **Specification over implementation.** Conformance is defined so many implementations can interoperate; no implementation is privileged by the standard.

## 4. Roles

| Role | Responsibility |
|---|---|
| **Maintainers** | Stewards of the repositories; merge rights; release management; uphold this charter. |
| **Specification Editors** | Maintain normative documents for clarity and internal consistency; editors do not by themselves decide normative changes. |
| **Contributors** | Anyone proposing changes via the public process. |
| **Foundation liaison** (if hosted) | Coordinates with the hosting foundation's technical body and IP/marketing processes. |

The current maintainer is **Poesis** ([github.com/poesis-cloud](https://github.com/poesis-cloud)). Individual maintainer and editor names are **TBD** and would be recorded in a `MAINTAINERS` file at contribution time. Maintainer additions/removals are by maintainer supermajority.

## 5. Decision-making

- **Lazy consensus** is the default: a proposal open for a defined review window with no sustained objection is accepted.
- **Normative changes** (anything affecting conformance — primitives, vocabulary, lifecycle, expression profiles, interchange) require an explicit **maintainer supermajority** and a review window no shorter than the editorial-change window.
- **Editorial changes** (wording, examples, non-normative docs) may proceed by lazy consensus.
- **Sustained objection** escalates to a recorded maintainer vote; ties fail (status quo wins).

### 5.1 Change proposals

Substantive changes are raised as a written **GSM Change Proposal** (a tracked issue/PR) stating: motivation, the normative delta, conformance impact (which `GSM-*` requirement IDs change), backwards-compatibility analysis, and migration notes. Editors integrate accepted proposals; the [Conformance](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/conformance.md) catalog is updated with stable IDs.

## 6. Releases and versioning

- The specification uses **semantic versioning**. Pre-1.0 releases MAY break; from 1.0, breaking changes increment the major version.
- The eight base Archetype schemas and the seed meta-schema are versioned **with** the specification.
- Each release records its changes and any withdrawn/added conformance IDs.

## 7. Backwards-compatibility policy

Within a major version: no removal or semantic change of an existing primitive, enumeration value, `$gsm:*` keyword, lifecycle edge, or interchange member. Additions MUST be optional and MUST NOT alter the meaning of existing documents. Deprecations are announced at least one minor release before removal at the next major version.

## 8. Licensing and intellectual property (proposed)

- **Current repository license:** **BUSL-1.1** — source-available, not Open Source. It is a pre-publication holding license, replaced by the posture below when the specification is published.
- **Specification text:** **CC BY 4.0**.
- **Reference schemas and code:** **Apache-2.0** (an OSI-approved license).
- If hosted, the project would operate under the hosting foundation's **IP Policy** and trademark program, and contributions would be accepted under the **Developer Certificate of Origin (DCO)** or an equivalent CLA as the foundation requires.

This posture is a **proposal**; the repositories' current licenses remain authoritative until a formal relicensing is executed by the rights holder.

## 9. Code of Conduct

The project would adopt the hosting consortium's Code of Conduct — once an OASIS Technical Committee is chartered, the [OASIS Code of Conduct](https://www.oasis-open.org/policies-guidelines/oasis-participants-code-of-conduct/) applies to TC activities. Until then, contributor conduct is governed by the existing repository `CONTRIBUTING` guidance.

## 10. Amending this charter

Amendments follow the **normative-change** process (§5): a written proposal, a review window, and maintainer supermajority. Material amendments made after foundation hosting also follow the hosting foundation's requirements.
