---
layout: default
title: OTel Collector
parent: SIE — the Systemic Intelligence Engine
nav_order: 3
---

# OTel Collector

{: .no_toc }

> **In construction.** This product's documentation is being written.

The **OTel Collector** is the shared OpenTelemetry collector for SIE: a stock OpenTelemetry Collector deployment that receives the OTLP traces and logs emitted by the SIE services of a deployment — such as the **[Definition Manager]({% link sie/definition-manager/index.md %})** and the **[Definition Operator]({% link sie/operator/index.md %})** — and forwards them to a debug sink or one configured OTLP backend. Receiver authentication and production-tuned configurations are out of its current scope.
