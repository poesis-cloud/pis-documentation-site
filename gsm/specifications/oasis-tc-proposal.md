---
layout: default
title: "GSM — OASIS TC Proposal (Draft)"
parent: GSM Specifications
grand_parent: GSM — the standard
nav_order: 7
redirect_from:
  - /gsm/cncf-sandbox-proposal/
  - /gsm/specifications/cncf-sandbox-proposal/
---

# GSM — OASIS TC Charter Proposal (Draft)
{: .no_toc }

**Status:** Draft charter proposal — not submitted
{: .fs-5 .fw-300 }

This is a **draft** proposal to charter an [OASIS Open](https://www.oasis-open.org/) **Technical Committee (TC)** to standardize the Generative System Model (GSM). It follows the charter elements required by the [OASIS TC Process](https://www.oasis-open.org/policies-guidelines/tc-process/). It has **not** been submitted to OASIS, and nothing here implies OASIS review or acceptance. Fields that depend on people or relationships not yet established are marked **TBD** rather than filled speculatively.

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Proposer contact

- **Originating maintainer:** Poesis — [github.com/poesis-cloud](https://github.com/poesis-cloud)
- **Primary contact:** TBD
- **Co-proposers:** TBD — the TC Process requires support from Eligible Persons across multiple OASIS member organizations.
- **Maintainers file:** to be added at contribution time (see [Charter §4](charter.md)).

## 2. Proposed TC name

**OASIS Generative System Model (GSM) TC** *(working name; final naming per OASIS naming policies)* — a vendor-neutral standard for defining and governing software-intensive systems, developed as a candidate open standard.

## 3. Statement of purpose

GSM is a small, fixed vocabulary for expressing **what a software-intensive system must be** — its purpose, obligations, and constraints — as **typed, versioned, machine-evaluable definitions** rather than prose. It standardizes the **THINK** layer of IT (definition and governance), complementing the BUILD layer (pipelines) and the RUN layer (observability). The standard specifies eight primitives, a three-tempo governance grammar (Directives, Norms, Ascriptions), an extensible Archetype type system, a normative lifecycle, two sandboxed expression-language profiles, and a canonical JSON interchange so that governed definitions are portable across conforming tools.

## 4. Statement on alignment with the OASIS portfolio

OASIS Open develops open standards for governance, policy, security, and interoperability — XACML (access control and policy), TOSCA (topology), LegalRuleML and Akoma Ntoso (legal and regulatory rules), STIX/TAXII/CSAF (security exchange), UBL (business interchange) — and hosts the Coalition for Secure AI. GSM is a **machine-evaluable definition-and-governance standard**: it sits squarely inside that portfolio. Modern systems carry compliance, security, reliability, and architectural obligations that today live in non-portable, tool-specific prose; GSM provides an **open, vendor-neutral, machine-evaluable** way to express those obligations and bind them to subjects across their lifecycle — directly serving OASIS's goals of interoperability and avoidance of lock-in.

## 5. Fit, alignment, and gap

- **Fit.** GSM is model-and-interchange first, infrastructure-independent, and implementable by many tools — the same shape as UBL, TOSCA, CloudEvents, and OpenTelemetry.
- **Alignment.** It composes with existing ecosystems rather than competing: OpenTelemetry produces the descriptive evidence a GSM Norm is evaluated against; a GSM Effector's output may be carried as a CloudEvent; policy engines (XACML-family, OPA) enforce the obligations GSM makes portable.
- **Gap it fills.** There is no open, vendor-neutral standard for the *definition/governance* (THINK) layer. Governance is fragmented across architecture wikis, compliance spreadsheets, and proprietary GRC tools whose models do not interoperate. GSM closes that gap.

**Representative use cases** (full detail: [Cloud-Native Use Cases](cloud-native-use-cases.md)):

- **SLO governance** — Norms express SLOs; OpenTelemetry supplies the evidence.
- **Admission & policy** — the Directive/Norm is the authoritative obligation; OPA/Gatekeeper, Kyverno, and XACML-family engines enforce.
- **Supply chain** — provenance/signing/SBOM obligations as DNA; sigstore, SLSA, in-toto, and TUF as evidence.
- **Zero-trust / mesh** — service coupling as Interactions governed by Norms; SPIFFE/SPIRE, Istio, and Linkerd realize them.
- **Progressive delivery** — rollout guardrails as Norms; Argo, Flux, and Flagger realize them.
- **Continuous compliance & data protection** — GDPR/NIS2/DORA sourced into Archetypes; the `$gsm:dataProtection` vocabulary governs data handling.
- **Platform & FinOps** — golden-path and cost obligations over application definitions; Backstage, Crossplane, and OpenCost realize/observe them.

## 6. Comparable / adjacent work (landscape)

- **OpenTelemetry** — RUN layer (telemetry). Complementary, not overlapping.
- **CloudEvents** — event interchange. GSM reuses it as a carrier, not a substitute.
- **Open Policy Agent / XACML / policy-as-code** — evaluates rules against current state. GSM governs the *definition of the state* (slow-moving identity and obligations) with a full lifecycle and governance grammar; the two are complementary.
- **TOSCA** — topology and orchestration definitions; GSM adds the governance grammar and lifecycle over definitions. Complementary.
- **Enterprise-architecture frameworks (TOGAF, ArchiMate) and quality/regulatory standards (ISO 25010, GDPR, NIS2, DORA)** — these are *sourced into* GSM as Archetypes and DNA, not replaced.

## 7. Vendor neutrality

The standard mandates no vendor, language, runtime, or storage technology. Conformance is defined for documents, producers, consumers, and processors so that independent implementations interoperate. The reference implementation is one conformant processor among potential others and holds no privileged status in the specification.

## 8. Why OASIS, and why a TC

- **Why OASIS.** Neutral stewardship is what turns a model into a standard. GSM's domain — governance, policy, interoperability — is OASIS's core portfolio, and OASIS offers a real standards track: Committee Specification → Candidate OASIS Standard → **OASIS Standard**, with optional submission to ISO/IEC JTC 1 (the path taken by UBL → ISO/IEC 19845 and ebXML → ISO 15000).
- **Why a TC.** A Technical Committee is the formal standards-track vehicle. It requires multi-organization participation from chartering onward, which sets the vendor-neutrality expectation honestly; OASIS Standard approval additionally requires Statements of Use from implementing organizations.

## 9. Scope of work and deliverables (high level)

- **Deliverables:** the GSM specification (standards-track), the conformance requirement catalog and reference test fixtures, and the canonical JSON interchange schemas.
- **Out of scope:** implementations (including the Poesis reference implementation), which remain outside the TC.
- **Near term:** charter the TC; contribute the specification as the initial contribution; iterate through Committee Specification Drafts with public reviews.
- **Mid term:** independent implementations beyond the reference (the future Statements of Use); framework-mapping guides (TOGAF/ISO/GDPR → GSM); Committee Specification.
- **Longer term:** Candidate OASIS Standard → OASIS Standard; broaden domain adoption beyond IT governance.

Dates are intentionally omitted; this is an early-stage draft.

## 10. Governance and maintainers

Proposed pre-chartering governance is documented in the [Charter](charter.md): maintainer roles, lazy-consensus default with supermajority for normative change, a written change-proposal process, and semantic versioning. Once chartered, the OASIS TC Process governs the TC's work. Current steward: Poesis.

## 11. Contributing and Code of Conduct

Once chartered, contribution follows the OASIS TC Process and IPR Policy, and OASIS's Code of Conduct applies to TC activities. Until then, the source repositories' `CONTRIBUTING` and `CODE_OF_CONDUCT` guidance applies.

## 12. License and IPR mode

- **Current repository license:** BUSL-1.1 (source-available, not Open Source).
- **Specification text:** CC BY 4.0 (proposed, at publication).
- **Reference schemas and implementation:** Apache-2.0 (proposed, OSI-approved).
- **Proposed TC IPR mode:** **Non-Assertion** — the most adoption-friendly OASIS IPR mode.

The relicensing is **proposed**; current repository licenses remain authoritative until formally updated by the rights holder. The initial contribution to the TC is then made under the OASIS IPR Policy.

## 13. Trademark and IP

**No trademark donation is required by the OASIS route.** Poesis retains all its marks (Poesis, SIE, OIP, certification marks, and the GSM name); TC and work-product naming will be aligned with OASIS naming policies. The specification text is contributed to the TC under the OASIS IPR Policy. Specific terms are **TBD** and subject to the rights holder's formal decision.

## 14. External dependencies

The standard depends only on open specifications: JSON ([RFC 8259](https://www.rfc-editor.org/rfc/rfc8259)), JSON Schema 2020-12, UUIDv7 ([RFC 9562](https://www.rfc-editor.org/rfc/rfc9562)), [CEL](https://github.com/google/cel-spec), and [Starlark](https://github.com/bazelbuild/starlark). It requires no proprietary component.

## 15. Adopters

- **SIE (Systemic Intelligence Engine)** — the reference implementation (a GSM Processor) within the Poesis project.
- **OIP (Organizational Intelligence Platform)** — a domain application built on SIE within the Poesis project.

No external (third-party) adopters are claimed at this draft stage.

## 16. Existing sponsorship / funding

Developed within the **Poesis** project. No external consortium or vendor funding; OASIS membership dues would be borne by Poesis. Co-proposing member organizations: **TBD**.

---

### Related documents

- [Specification](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/specification.md) — the normative standard.
- [Primer](primer.md) — non-normative introduction.
- [Conformance](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/conformance.md) — testable requirement catalog.
- [Charter](charter.md) — proposed project governance.
