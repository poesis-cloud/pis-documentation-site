---
layout: default
title: "GSM → OASIS Submission Playbook"
parent: GSM Specifications
grand_parent: GSM — the standard
nav_order: 10
redirect_from:
  - /gsm/cncf-submission-playbook/
  - /gsm/specifications/cncf-submission-playbook/
---

# GSM → OASIS Submission Playbook
{: .no_toc }

**A short guide to how OASIS standardization works and how GSM approaches it**
{: .fs-5 .fw-300 }

This page explains, at a high level, how a specification becomes a standard at [OASIS Open](https://www.oasis-open.org/) and the path GSM follows. It is a public process reference. Detailed, dated execution tracking lives outside this site.

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## The standards track

OASIS work products progress through defined stages. A specification enters as a contribution and earns each stage.

| Stage | Bar | Signal |
|---|---|---|
| **Working Draft** | TC-internal drafting | "Being drafted" |
| **Committee Specification Draft** | TC approval; one or more public reviews | "Stable enough for public scrutiny" |
| **Committee Specification** | Special-majority TC ballot after public review | "TC-endorsed" |
| **Candidate OASIS Standard** | Statements of Use from implementing organizations; further public review | "Implemented and in use" |
| **OASIS Standard** | Membership-wide call for consent | "Consortium-endorsed open standard" |
| **ISO/IEC JTC 1** (optional) | Submission of an approved OASIS Standard | "International standard" (the path of UBL → ISO/IEC 19845 and ebXML → ISO 15000) |

GSM targets a **Committee Specification** first, then the OASIS Standard track.

## How chartering works

1. **Prerequisites.** OASIS membership; a draft charter stating scope, deliverables, audience, and the **IPR mode**; support from Eligible Persons across multiple member organizations (the TC Process minimum membership); a public repository with governance, a Code of Conduct, and contribution terms.
2. **Propose.** Submit the draft charter to OASIS TC Administration; a public charter-comment period follows before the TC is called.
3. **Form.** The TC holds its first meeting, elects chairs and editors, and receives the GSM specification as an **initial contribution** under the TC's IPR mode.
4. **Iterate in the open.** Committee Specification Drafts and public reviews, toward Committee Specification and beyond.

> Process details evolve — confirm the current [TC Process](https://www.oasis-open.org/policies-guidelines/tc-process/) and [IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr/) before submitting.

## How GSM engages the community

Acceptance is built before the charter is filed, in the open:

- **Membership and co-proposers.** Join OASIS at the appropriate tier; recruit co-proposing member organizations (design partners, regulated adopters, tool vendors) — the same relationships that later provide **Statements of Use**.
- **Adjacent OASIS communities.** GSM's natural neighbors are the policy family (XACML), topology (TOSCA), legal/regulatory rules (LegalRuleML), security exchange (CSAF/STIX), and the Coalition for Secure AI. The plan is to present GSM to these communities and incorporate feedback.
- **Composition, not competition.** GSM is positioned as the definitional complement to OpenTelemetry, CloudEvents, and the policy/supply-chain projects — it gives them a shared, portable source of truth.

## What is already prepared

| Artifact | Where |
|---|---|
| Normative specification | [Specification](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/specification.md) |
| Conformance catalog (stable IDs) | [Conformance](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/conformance.md) |
| Non-normative onboarding | [Primer](primer.md) |
| Cloud-native relevance | [Cloud-Native Use Cases](cloud-native-use-cases.md) |
| Proposed governance | [Charter](charter.md) |
| Draft charter proposal | [OASIS TC Proposal](oasis-tc-proposal.md) |
| Repo artifacts (`GOVERNANCE.md`, `MAINTAINERS.md`, `CODE_OF_CONDUCT.md`, ready-to-adapt submission) | [github.com/poesis-cloud/gsm-specifications](https://github.com/poesis-cloud/gsm-specifications) |

## The remaining path, in brief

1. Make the public repository submission-ready (governance, Code of Conduct, maintainers, DCO).
2. Execute the open-license posture at publication (specification text → CC BY 4.0; reference code → Apache-2.0).
3. Join OASIS and recruit co-proposing member organizations.
4. Grow contribution and adoption signals beyond a single organization (the future Statements of Use).
5. Submit the TC charter proposal and iterate in public.
