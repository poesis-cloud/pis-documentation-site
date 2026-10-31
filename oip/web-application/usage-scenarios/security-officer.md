---
layout: default
title: Security Officer
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/security-officer/
  - /itip/web-application/usage-scenarios/security-officer/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Security Officer
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **audit regulatory coverage** across the IT landscape. You **verify** that security governance posture is complete and continuously enforced. You **manage** security frameworks as composable preset stacks.

OIP makes security governance continuous and machine-evaluable — not a periodic manual audit.

## Core workflows

### Audit regulatory preset coverage

Navigate to **Governance > Regulatory Coverage**. OIP renders a coverage map showing:

- Which Structures have regulatory presets attached
- Which presets are applied (GDPR, NIS2, PCI-DSS, ISO 27001, DORA)
- Where coverage gaps exist — Structures that *should* have a preset but don't

The coverage map is filterable by:
- **Regulatory framework** — show all Structures governed by GDPR
- **Data classification** — show all Structures handling personal data
- **Compliance state** — show only Structures with active violations

### Verify security governance posture

For each Structure, OIP shows:

| Aspect | What you see |
|--------|-------------|
| **Security Directives** | `MUST ENSURE encryption ON cardholder-data-storage` |
| **Security Norms** | `DataStore.encryptionStandard == "AES-256"` with boolean tolerance |
| **Norm evaluation state** | Pass / Fail / Pending — evaluated against code-sourced and telemetry data |
| **Regulatory traceability** | Which preset framework each Norm originates from |

You can verify that every security requirement from every applicable regulation has been translated into a measurable Norm, and that each Norm is actively evaluated.

### Manage security framework presets

Security frameworks are sourced into OIP as preset Directives and Norms:

| Framework | Scope | Example preset Directives |
|-----------|-------|---------------------------|
| **GDPR** | Data protection, privacy | `MUST ENSURE lawfulness ON personal-data-processing` |
| **NIS2** | Critical infrastructure cybersecurity | `MUST ENSURE incident-response-capability ON critical-infrastructure` |
| **PCI-DSS** | Payment card data security | `MUST ENSURE encryption ON cardholder-data-storage` |
| **ISO 27001** | Information security management | `MUST PRESERVE confidentiality ON information-assets` |
| **DORA** | Financial services ICT resilience | `MUST ENSURE operational-resilience ON financial-services-ict` |

You compose these into layered stacks (see [framework composition]({% link oip/web-application/general-usage.md %}#frameworks-and-stacks)). Copilot resolves overlaps and flags where multiple frameworks assert equivalent constraints.

### Review Norm violations with governance context

When a security Norm is violated, OIP provides:

1. **The violation** — which Norm failed, current vs expected value
2. **The Directive** — the governance intent behind the Norm
3. **The regulatory source** — which preset framework the Norm came from
4. **Impact scope** — which other Structures share the same Norm (systemic risk assessment)
5. **Remediation path** — Jira/ServiceNow integration creates actionable tickets

This is not "an alert fired." This is a traceable chain from regulatory requirement → governance intent → measurable constraint → measured violation.

## Using frameworks

### GDPR — Data protection governance

GDPR presets in OIP include:

| Directive | Norm assertion | Quality dimension |
|-----------|---------------|-------------------|
| `MUST ENSURE lawfulness ON personal-data-processing` | `DataProcessing.legalBasis != null` | DataCompliance |
| `MUST ENSURE data-minimization ON personal-data-collection` | `DataCollection.retentionDays <= policy.maxRetention` | DataRelevancy |
| `MUST ENSURE breach-notification ON personal-data-processing` | `IncidentResponse.notificationDelayHours <= 72` | — |
| `MUST ENSURE right-to-erasure ON personal-data-storage` | `DataDeletion.automatedEnabled == true` | DataCompleteness |

### NIS2 — Critical infrastructure

NIS2 presets target organizations identified as essential or important entities:

| Directive | Norm assertion |
|-----------|---------------|
| `MUST ENSURE incident-response-capability ON critical-infrastructure` | `IncidentResponse.teamAssigned == true` |
| `MUST ENSURE risk-assessment ON critical-infrastructure` | `RiskAssessment.lastReviewDays <= 365` |
| `MUST ENSURE supply-chain-security ON critical-infrastructure` | `SupplyChain.vendorAssessmentComplete == true` |

### ISO 27001 — Information security controls

ISO 27001 Annex A controls map to OIP Directives. Each control objective becomes a Directive; each control implementation becomes a Norm assertion.

### PCI-DSS — Payment card security

PCI-DSS requirements map directly to security Norms:

| Requirement | Norm assertion |
|-------------|---------------|
| Req 3: Protect stored cardholder data | `DataStore.encryptionStandard == "AES-256"` |
| Req 6: Develop secure systems | `Vulnerability.criticalUnpatched == 0` |
| Req 10: Track and monitor access | `AccessLog.retentionDays >= 365` |

## Example: Audit security posture for a new application

**Context**: The Payment Gateway has been onboarded. You need to verify its security governance posture.

1. **Open regulatory coverage** — navigate to *Governance > Regulatory Coverage > payment-gateway*.
2. **Check preset attachment** — GDPR ✓, PCI-DSS ✓, NIS2 ✓. All applicable presets are attached.
3. **Review security Norms** — 12 security Norms active. 11 passing, 1 pending (encryption audit not yet evaluated — no telemetry data).
4. **Flag the gap** — the pending Norm needs observability integration. Create a Jira task for the ops team.
5. **Generate compliance evidence** — export the coverage map and Norm evaluation state as audit documentation.

**Result**: Security governance posture is verified from governed definitions, not from a manual spreadsheet. Missing coverage is visible immediately.

## Example: Respond to a new regulatory requirement

**Context**: A new NIS2 amendment adds a supply-chain risk assessment requirement. It must apply to all critical infrastructure Structures.

1. **Check existing presets** — the NIS2 preset doesn't yet include the new requirement.
2. **Author a new preset Directive** — `MUST ENSURE supply-chain-risk-assessment ON critical-infrastructure`.
3. **Author the Norm** — `SupplyChain.riskAssessmentDays <= 180` with SUSTAINED tolerance.
4. **Apply to scope** — OIP shows all Structures tagged as critical infrastructure. The new Norm propagates to all of them.
5. **Check compliance** — immediate evaluation shows which Structures already satisfy the requirement and which have gaps.

**Result**: A new regulation is translated into machine-evaluable governance within hours, not months. Compliance is immediately measurable.
