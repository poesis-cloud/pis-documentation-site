---
layout: default
title: "SIE Roadmap"
parent: SIE — the Systemic Intelligence Engine
nav_order: 4
---

# SIE Roadmap
{: .no_toc }

Engine-level capabilities planned across the SIE products — the analytical and contextual layers SIE will expose over the governed model. Product-scoped capabilities live on each product's Features page: [Definition Manager]({% link sie/definition-manager/features.md %}), [Definition Operator]({% link sie/operator/features.md %}). Definition-sourcing capabilities live with the SIS [Blackboard Manager]({% link sis/blackboard-manager/features.md %}).

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{% include milestone_legend.md %}

---

## Governance intelligence (analytics)

The analytical layer SIE will expose over the governed model. None are implemented yet; all are post-GA (v1.x of the owning product) unless marked exploratory.

| Functional component | Representative features | Milestone |
|----------------------|-------------------------|-----------|
| Descriptive analytics | State monitoring & audit trail; structural observation (coupling, critical path); temporal observation (trend / drift detection) | v1.x |
| Diagnostic analytics | Causal attribution & root-cause; anomaly detection; constraint conflict / coherence / gap diagnostics | v1.x |
| Predictive analytics | Forecasting; blast-radius & risk propagation; what-if / Norm simulation | v1.x |
| Prescriptive analytics | Remediation recommendation; homeostasis (closed-loop); LLM-assisted DNA bootstrap | v1.x |
| Assurance & safety | Provenance & lineage; uncertainty / confidence; LLM-output assurance; automation guardrails | v1.x |
| Emergence & cross-domain inference | Emergence detection; code → business cross-domain impact | Unversioned (exploratory) |

## Environmental context and system presets

| Functional component | Representative features | Milestone |
|----------------------|-------------------------|-----------|
| System presets | Regulatory / geopolitical / industry-standard presets; preset import & instantiation; preset composition & conflict detection | v1.x |
