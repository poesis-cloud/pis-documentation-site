---
layout: default
title: GSM Model
parent: GSM Specifications
grand_parent: GSM — the standard
nav_order: 11
---

The model directory contains GSM's normative machine-readable model artifacts.
When prose and these artifacts disagree, the artifacts are authoritative.

## Artifacts

| Artifact | Role |
| --- | --- |
| [GSM class model](https://github.com/poesis-cloud/gsm-specifications/blob/main/model/gsm.puml) | Defines the eight primitives, the generative governance grammar, statement closure, references, and systemic invariants. |
| [Ascription lifecycle](https://github.com/poesis-cloud/gsm-specifications/blob/main/model/gsm-ascription-lifecycle.puml) | Defines lifecycle states, transitions, preconditions, and cascades. |
| [Starlark Rule API](rule-api-starlark.py) | Defines the sandboxed API available to Mechanism rules. |

The PlantUML files are published as inspectable source so implementations can
trace prose requirements back to their normative model definitions. The Rule
API is published as a typed Python-shaped contract; it is not an executable
Python implementation.

## Relationship to other GSM artifacts

- The [Specification](https://github.com/poesis-cloud/gsm-specifications/blob/main/docs/specification.md)
  explains the model and defines normative conformance language.
- The [base Archetype schemas](../schemas/) provide the JSON interchange
  contracts for the eight primitive subject types.
- Research is non-normative and may question these model boundaries without
  changing them until a Change Proposal is accepted.
