---
layout: default
title: Compliance Analyst
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/compliance-analyst/
  - /itip/web-application/usage-scenarios/compliance-analyst/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Compliance Analyst
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **evaluate regulatory adherence** across the governed landscape. You **generate compliance reports** from live governance state. You **track gap resolution** from detection to closure.

OIP transforms compliance from periodic manual audits into continuous, evidence-based evaluation.

## Core workflows

### Evaluate regulatory adherence

Navigate to **Compliance > Adherence Matrix**. OIP generates a cross-reference matrix:

| | GDPR | NIS2 | PCI-DSS | ISO 27001 |
|---|---|---|---|---|
| **payment-gateway** | ✓ 12/12 | ✓ 8/8 | ⚠ 9/10 | ✓ 15/15 |
| **customer-portal** | ✓ 8/8 | — | — | ✓ 15/15 |
| **data-warehouse** | ⚠ 10/12 | ✓ 8/8 | — | ⚠ 14/15 |

Each cell shows Norms passing / Norms total. Amber (⚠) indicates gaps. Dash (—) means the framework is not applicable.

You can drill into any cell to see:
- Which specific Norms are failing
- The current measured value vs. the required threshold
- The owning team responsible for remediation
- The governance timeline (when the Norm was last evaluated)

### Generate compliance reports

OIP generates compliance documentation from live governance state:

- **Regulatory compliance report** — per framework, per Structure, showing adherence status, gap inventory, and remediation timeline
- **Audit evidence package** — Norm definitions, evaluation history, and evidence trail (who authored, who approved, when evaluated)
- **Gap analysis document** — all failing Norms with governance context, severity classification, and resolution status

Reports are generated from the same governance data that drives real-time evaluation. They are never stale.

### Track gap resolution

When a compliance gap is detected:

1. **Gap identified** — a Norm evaluation fails or a required preset is missing.
2. **Gap triaged** — you classify severity (critical / major / minor) based on regulatory impact.
3. **Remediation assigned** — Jira task created for the owning team. ServiceNow change request if infrastructure is involved.
4. **Progress tracked** — OIP's gap tracker shows resolution status per gap.
5. **Gap closed** — when the Norm re-evaluates to passing, the gap is automatically marked resolved.

The full lifecycle is auditable. Every state transition is timestamped and attributed.

### Cross-framework overlap analysis

Multiple regulatory frameworks often impose equivalent or overlapping constraints. OIP identifies these:

- **GDPR Article 32** (security of processing) and **ISO 27001 A.12** (operations security) both require encryption. OIP flags the overlap and shows the merged Norm.
- **NIS2 Article 21** (risk management) and **DORA Article 6** (ICT risk management) overlap on risk assessment. OIP shows which Norm satisfies both.

This avoids duplicate compliance effort and ensures that a single control satisfies multiple regulatory requirements.

## Using frameworks

### GDPR — Compliance evaluation

As a compliance analyst, you work with GDPR preset Norms at the evaluation level:

| GDPR Article | OIP Norm category | What you evaluate |
|---|---|---|
| Art. 5 — Principles | Data quality Norms (ISO 25012) | Are data minimization, accuracy, and storage limitation enforced? |
| Art. 25 — Data protection by design | Architecture Norms | Are privacy-by-design patterns implemented in governed Structures? |
| Art. 32 — Security of processing | Security Norms | Are encryption, access control, and resilience Norms passing? |
| Art. 33 — Breach notification | Incident response Norms | Is the 72-hour notification constraint enforceable and monitored? |

### NIS2 — Critical infrastructure compliance

NIS2 evaluation focuses on:

| NIS2 Article | Evaluation scope |
|---|---|
| Art. 21 — Cybersecurity risk management | Risk assessment Norms evaluated, frequency compliance verified |
| Art. 23 — Incident reporting | Incident response Norms: response time, notification chain, evidence preservation |
| Art. 24 — Supply chain security | Vendor assessment Norms, third-party dependency governance |

### ISO 25012 — Data quality compliance

Data quality Norms from ISO 25012 are directly evaluable:

| Quality characteristic | Compliance question | Norm assertion pattern |
|---|---|---|
| **DataAccuracy** | Is stored data correct? | Validation pass rate ≥ threshold |
| **DataCompleteness** | Are required fields populated? | Null rate ≤ threshold |
| **DataConsistency** | Do related datasets agree? | Reconciliation error rate ≤ threshold |
| **DataCurrentness** | Is data fresh enough? | Staleness ≤ max age |
| **DataCompliance** | Does data handling follow regulation? | Policy coverage = 100% |

## Example: Prepare for a regulatory audit

**Context**: An external auditor will assess GDPR and NIS2 compliance next month. You need evidence of continuous governance.

1. **Generate adherence matrix** — shows all governed Structures and their compliance state per framework.
2. **Export audit evidence** — for each Norm, export the definition, author, approval date, evaluation history, and current state.
3. **Identify gaps** — 2 Norms in amber. One is a data retention Norm pending observability integration. The other is a risk assessment Norm awaiting annual review.
4. **Verify remediation** — both gaps have Jira tickets assigned. Check timeline feasibility before audit date.
5. **Generate compliance report** — export the full report as the audit deliverable.

**Result**: Audit preparation is evidence-based and automated. The auditor receives traceable, timestamped governance evidence — not a manually assembled spreadsheet.

## Example: New regulation impact assessment

**Context**: A new regulation (e.g., EU AI Act) requires assessment of all AI-enabled Structures for bias, explainability, and risk classification.

1. **Identify affected Structures** — filter by Mechanism type or capability tag to find all Structures with ML/AI Mechanisms.
2. **Assess current coverage** — check whether existing Norms address explainability or bias requirements.
3. **Gap inventory** — list all Structures with no AI governance Norms.
4. **Propose new preset** — work with the Security Officer to author an AI Act preset with appropriate Directives and Norms.
5. **Attach and evaluate** — apply the new preset and immediately see the compliance state.

**Result**: A new regulatory requirement is assessed across the entire landscape in hours. Impact is quantified, not estimated.
