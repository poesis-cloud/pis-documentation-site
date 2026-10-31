---
layout: default
title: QA / Test Engineer
nav_exclude: true
redirect_from:
  - /itip/usage-scenarios/qa-engineer/
  - /itip/web-application/usage-scenarios/qa-engineer/
---

[← Usage Scenarios]({% link oip/web-application/usage-scenarios/index.md %})
{: .fs-3 .fw-300 }

# QA / Test Engineer
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What you do in OIP

You **reference quality requirements** from governed definitions as test acceptance criteria. You **verify** that quality governance covers the dimensions your testing addresses. You **trace** test results back to governance Norms.

OIP gives you authoritative, machine-readable quality requirements — not vague NFR statements buried in a requirements document.

## Core workflows

### Reference quality requirements as test criteria

Every Norm assertion in OIP is a testable statement. Navigate to a Structure's Norms and read them as acceptance criteria:

| Norm assertion | Test translation |
|---|---|
| `ServiceTelemetry.p99LatencyMs <= 500` | Performance test: verify p99 latency ≤ 500ms under load |
| `ServiceTelemetry.availability30d >= 0.999` | Reliability test: sustained availability over 30-day simulation |
| `DataStore.encryptionStandard == "AES-256"` | Security test: verify encrypted storage uses AES-256 |
| `DataValidation.nullRate <= 0.01` | Data quality test: verify null rate ≤ 1% on required fields |

Norm assertions are CEL expressions evaluated against typed Archetype properties. They are precise, unambiguous, and directly convertible to test assertions.

### Verify quality governance coverage

Navigate to **Quality > Coverage Matrix** to check whether all quality dimensions relevant to your testing scope have governing Norms:

| Quality model | Characteristic | Norms defined? | Test coverage? |
|---|---|---|---|
| ISO 25010 | PerformanceEfficiency | ✓ 3 Norms | ✓ Load tests mapped |
| ISO 25010 | ProductReliability | ✓ 2 Norms | ⚠ Chaos test missing |
| ISO 25010 | ProductSecurity | ✓ 4 Norms | ✓ Security scan mapped |
| ISO 25012 | DataAccuracy | ✓ 1 Norm | ✓ Validation tests |
| ISO 25012 | DataCompleteness | ⚠ No Norm | — No test criteria |

Amber indicators mean a quality dimension has no governing Norm — and therefore no testable criteria. Flag these to the architect.

### Trace test results to governance

When tests fail, you can trace each failure to its governing Norm:

1. **Test assertion fails** — p99 latency is 620ms, threshold is 500ms.
2. **Find the Norm** — `ServiceTelemetry.p99LatencyMs <= 500` on `payment-gateway`.
3. **Find the Directive** — `enterprise-architecture-board MUST MINIMIZE latency ON payment-gateway`.
4. **Find the regulatory context** — the Directive traces to a PCI-DSS performance requirement.

This traceability chain (test result → Norm → Directive → regulation) is the evidence that your test validates a real governance requirement, not an arbitrary threshold.

## Using frameworks

### ISO 25010 — Product quality as test taxonomy

ISO 25010 provides the quality taxonomy that organizes your test strategy:

| Characteristic | Sub-characteristics | Test category |
|---|---|---|
| **PerformanceEfficiency** | Time behavior, Capacity, Resource utilization | Performance testing, load testing, stress testing |
| **ProductReliability** | Availability, Fault tolerance, Recoverability | Reliability testing, chaos engineering, disaster recovery testing |
| **ProductSecurity** | Confidentiality, Integrity, Non-repudiation | Security testing, penetration testing, vulnerability scanning |
| **Maintainability** | Modularity, Reusability, Analyzability | Code quality (static analysis), dependency analysis |
| **Compatibility** | Co-existence, Interoperability | Integration testing, contract testing |
| **Usability** | Learnability, Operability, Accessibility | Usability testing, accessibility audit |
| **FunctionalSuitability** | Completeness, Correctness, Appropriateness | Functional testing, acceptance testing |
| **Portability** | Adaptability, Installability, Replaceability | Environment testing, migration testing |

Each Norm in OIP references an ISO 25010 quality characteristic. This maps your test plan to the governance taxonomy.

### ISO 25012 — Data quality testing

For data-intensive Structures, ISO 25012 dimensions map to data quality tests:

| Characteristic | Test strategy |
|---|---|
| **DataAccuracy** | Validate values against known sources; cross-reference checks |
| **DataCompleteness** | Null/missing field analysis on representative datasets |
| **DataConsistency** | Cross-dataset reconciliation; referential integrity checks |
| **DataCurrentness** | Staleness detection; verify refresh frequency meets governance |
| **DataCompliance** | Policy enforcement: retention, anonymization, access control |

### ISO 25011 — Service quality (when applicable)

For services exposed to end users, ISO 25011 extends quality testing to service-level concerns:

- **ServiceAvailability** — end-to-end service availability testing
- **ServiceReliability** — service continuity under degraded conditions
- **ServiceRecoverability** — service recovery time and completeness

## Example: Build a test plan from governed Norms

**Context**: You are creating a test plan for the Payment Gateway. You want tests grounded in governance requirements, not ad-hoc assumptions.

1. **List all Norms** — navigate to *Structures > payment-gateway > Norms*. There are 15 Norms.
2. **Categorize by quality model** — sort by ISO 25010 characteristic:
   - PerformanceEfficiency: 4 Norms (latency, throughput, resource limits)
   - ProductReliability: 3 Norms (availability, fault tolerance, recoverability)
   - ProductSecurity: 5 Norms (encryption, auth, access control, vulnerability, audit logging)
   - DataAccuracy: 2 Norms (validation, reconciliation)
   - DataCompleteness: 1 Norm (required fields)
3. **Write test cases** — each Norm assertion becomes a test assertion. The tolerance mode tells you the evaluation approach (instantaneous check vs. statistical aggregate vs. sustained window).
4. **Map coverage** — verify your test plan covers all Norm-governed quality dimensions. Flag any dimensions with no Norms (governance gap) or Norms with no tests (test gap).

**Result**: A test plan traceable to governance requirements. Every test validates a real constraint. Every governance constraint has a corresponding test.

## Example: Trace a test failure to regulation

**Context**: A load test shows p99 latency at 620ms. The threshold from the test plan is 500ms. You need to report the impact.

1. **Find the Norm** — `ServiceTelemetry.p99LatencyMs <= 500` (INSTANTANEOUS tolerance).
2. **Find the Directive** — `MUST MINIMIZE latency ON payment-gateway`, owned by `enterprise-architecture-board`.
3. **Find the preset** — the Directive traces to PCI-DSS Requirement 6 (develop secure and performant systems).
4. **Report** — "Load test failure violates PCI-DSS-traced performance Norm. Remediation required before release."

**Result**: Test failures are reported with full governance traceability — not just "a number exceeded a threshold."
