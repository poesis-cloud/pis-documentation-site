---
layout: default
title: Operations / SRE Engineer
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/operations/
  - /itip/web-application/usage-scenarios/operations/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# Operations / SRE Engineer
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **monitor compliance drift** against governed quality constraints. You **inspect** near real-time architecture state sourced from observability platforms. You **trigger remediation** when Norm violations are detected.

OIP connects your observability stack to the governance plane. You act on governed constraints, not ad-hoc alerts.

## Core workflows

### Monitor compliance drift

Observability platforms (Datadog, Grafana, Prometheus) collect SLI/SLO metrics. OIP ingests this telemetry and continuously evaluates [Norm assertions]({% link oip/web-application/general-usage.md %}#the-norm) against live data.

When a Norm evaluation fails, OIP flags a compliance drift:

```
VIOLATION: payment-gateway
  Norm: availability-30d
  Assertion: ServiceTelemetry.availability30d >= 0.999
  Current value: 0.9973
  Tolerance: SUSTAINED (30d window)
  Governing Directive: "MUST ENSURE availability ON payment-gateway"
  Regulatory preset: NIS2
```

The violation includes full governance context — which Directive it traces to, which regulatory preset it belongs to, and what the tolerance mode is.

### Inspect near real-time architecture state

Navigate to **Operations > Architecture State**. OIP shows the current state of all governed Structures:

| Column | What it shows |
|--------|--------------|
| **Structure** | The governed component |
| **Compliance status** | Green / Amber / Red based on Norm evaluation |
| **Drift indicators** | Code-sourced definitions vs. authored definitions |
| **Active violations** | Norms currently in violation with duration |
| **Last telemetry** | Timestamp of most recent observability data |

This is the live architecture state — not a diagram drawn months ago. It reflects what is actually running.

### Trigger remediation workflows

When a compliance drift is detected:

1. **ServiceNow incident** — OIP creates an incident linked to the violated Norm, including governance context and current metric values.
2. **Jira remediation task** — created in the owning team's backlog with the violated Norm as acceptance criteria.
3. **Governance loop tracking** — OIP tracks resolution: Norm re-evaluation → compliance restored → incident closed.

The remediation workflow is governance-driven. The Norm defines *what* must be fixed. The tolerance mode defines *how quickly* a violation must be resolved.

### Tolerance modes in practice

The [three tolerance modes]({% link oip/web-application/general-usage.md %}#the-norm) determine how OIP evaluates compliance:

| Mode | Ops meaning | Example |
|------|------------|---------|
| **INSTANTANEOUS** | Every single measurement must pass | `ResponseTime.p99Ms <= 500` — any single violation is a breach |
| **AGGREGATED** | Statistical aggregate must pass | `ErrorRate.percent <= 0.1` over 1h window — individual spikes allowed |
| **SUSTAINED** | Continuous compliance over a time window | `Availability.percent >= 99.9` over 30d — sustained performance required |

AGGREGATED and SUSTAINED modes are where SRE practices (error budgets, burn rates) map directly into OIP Norms.

## Using frameworks

### ISO 25010 — Operational quality characteristics

ISO 25010 quality characteristics map to your monitoring targets:

| Characteristic | Ops concern | Typical metrics |
|---|---|---|
| **ProductReliability** | Availability, fault tolerance, recoverability | Uptime %, MTTR, error rate |
| **PerformanceEfficiency** | Latency, throughput, resource utilization | p50/p95/p99 latency, RPS, CPU/memory |
| **ProductSecurity** | Runtime security posture | TLS compliance, auth failure rate, vulnerability scan |

Norms using these characteristics are your governance-driven SLOs.

### ISO 25012 — Data quality in production

For data pipelines and data-processing services:

| Characteristic | Ops concern |
|---|---|
| **DataCurrentness** | Is data fresh enough? Staleness detection, refresh lag |
| **DataAvailability** | Is the data accessible when needed? Storage uptime, query success rate |
| **DataRecoverability** | Can data be restored after failure? Backup validation, RPO/RTO compliance |

## Example: Detect and remediate compliance drift

**Context**: The Payment Gateway is in production. The SRE team monitors via Datadog. OIP has ingested SLI metrics.

1. **Drift detected** — OIP flags: `availability-30d` Norm in violation. Current value 99.73%, threshold 99.9%.
2. **Inspect context** — the Norm traces to a NIS2 regulatory preset and the architecture board's availability Directive.
3. **Trigger remediation** — ServiceNow incident created. Jira task added to the payments team's sprint.
4. **Investigate** — the Reconciliation view shows a recent deployment changed a timeout configuration. Code-sourced definitions diverged from governed values.
5. **Resolution** — team fixes the configuration. OIP re-evaluates: compliance restored. Incident auto-closed.

**Result**: Compliance monitoring is continuous and automated. The governance context tells you *why* the metric matters, not just that a number is wrong.

## Example: Set up observability-driven governance for a new service

**Context**: A new service is being deployed. You want observability-driven Norm evaluation from day one.

1. **Check governed Norms** — open the Structure's Norms tab. See the quality Norms defined by the architect.
2. **Map to metrics** — each Norm assertion references a quality dimension. Map those to your telemetry sources (Datadog monitors, Grafana dashboards, Prometheus rules).
3. **Configure telemetry ingestion** — OIP's observability integration ingests metrics and evaluates Norms continuously.
4. **Verify initial state** — the Operations dashboard shows all Norms green (or flags gaps if telemetry is missing).

**Result**: Governance-driven monitoring from the first deployment. SLOs are defined by architecture Norms, not invented ad-hoc by the ops team.
