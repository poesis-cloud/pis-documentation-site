---
layout: default
title: The mental model
parent: SIE — the Systemic Intelligence Engine
nav_order: 0
---

# The mental model
{: .no_toc }

One loop, from definition to reality — and back.
{: .fs-5 .fw-300 }

1. TOC
{:toc}

---

## Kubernetes, generalized

Think **Kubernetes, generalized**: you declare desired state as typed, versioned, API-managed
definitions, and the engine continuously evaluates reality against them and acts to close the gap.
Kubernetes runs that loop on infrastructure; SIE can run it on **anything you can define**.

That is the whole idea — a small, fixed core of primitives, reconciled continuously, with everything
domain-specific expressed as typed definitions on top rather than as engine code.

## The loop

Humans, AI, and GSM Mechanisms realize four functions. Governance generates Directives; regulation
operationalizes them into Norms; supervision evaluates definitions and defined subjects against
those Norms; operations produce, evaluate, and normalize the state plane. Every function feeds back
into the one before it.

<div class="sie-loop" markdown="0">
<svg class="loopd" viewBox="0 0 1200 570" role="img" aria-label="Humans, AI, and GSM Mechanisms realize four functions: governance generates Directives; regulation operationalizes them into Norms; supervision evaluates definitions and subjects against the Norms — evaluating the state plane through operations in a round trip — and feeds back to regulation and operations; regulation feeds back to governance; operations produce, evaluate, and normalize the state plane.">
  <defs>
    <marker id="loopd-arr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0 L10 5 L0 10 z" class="loopd-arrhead" />
    </marker>
    <marker id="loopd-fbarr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0 0 L10 5 L0 10 z" class="loopd-fbarrhead" />
    </marker>
  </defs>

  <!-- actors -->
  <g class="loopd-actor">
    <rect x="415" y="12" width="120" height="42" rx="12" />
    <g transform="translate(429,24) scale(0.75)"><path class="loopd-ic" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle class="loopd-ic" cx="12" cy="7" r="4" /></g>
    <text x="452" y="38">Humans</text>
  </g>
  <g class="loopd-actor">
    <rect x="555" y="12" width="70" height="42" rx="12" />
    <g transform="translate(566,24) scale(0.75)"><path class="loopd-ic" d="M12 2 L14.5 9.5 L22 12 L14.5 14.5 L12 22 L9.5 14.5 L2 12 L9.5 9.5 Z" /></g>
    <text x="589" y="38">AI</text>
  </g>
  <g class="loopd-actor">
    <rect x="645" y="12" width="180" height="42" rx="12" />
    <g transform="translate(658,24) scale(0.75)"><rect class="loopd-ic" x="3" y="3" width="7" height="7" /><rect class="loopd-ic" x="14" y="3" width="7" height="7" /><rect class="loopd-ic" x="3" y="14" width="7" height="7" /><rect class="loopd-ic" x="14" y="14" width="7" height="7" /></g>
    <text x="682" y="38">GSM Mechanisms</text>
  </g>

  <!-- realization edges: actors to the function bus -->
  <g class="loopd-dash">
    <line x1="475" y1="54" x2="475" y2="88" />
    <line x1="590" y1="54" x2="590" y2="88" />
    <line x1="735" y1="54" x2="735" y2="88" />
    <line x1="135" y1="88" x2="1065" y2="88" />
    <line x1="135" y1="88" x2="135" y2="128" marker-end="url(#loopd-arr)" />
    <line x1="445" y1="88" x2="445" y2="128" marker-end="url(#loopd-arr)" />
    <line x1="755" y1="88" x2="755" y2="128" marker-end="url(#loopd-arr)" />
    <line x1="1065" y1="88" x2="1065" y2="128" marker-end="url(#loopd-arr)" />
  </g>
  <text class="loopd-edge" x="600" y="80" text-anchor="middle">realize</text>

  <!-- functions -->
  <g class="loopd-fn">
    <rect x="10" y="132" width="250" height="150" rx="14" />
    <g transform="translate(24,146) scale(0.62)"><circle class="loopd-ic" cx="12" cy="12" r="10" /><polygon class="loopd-ic" points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" /></g>
    <text class="loopd-fn-name" x="46" y="158">Governance</text>
    <text class="loopd-fn-body" x="24" y="184"><tspan x="24" dy="0">Generates Directives —</tspan><tspan x="24" dy="16">strategic intents / objectives</tspan></text>
  </g>
  <g class="loopd-fn">
    <rect x="320" y="132" width="250" height="150" rx="14" />
    <g transform="translate(334,146) scale(0.62)"><path class="loopd-ic" d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></g>
    <text class="loopd-fn-name" x="356" y="158">Regulation</text>
    <text class="loopd-fn-body" x="334" y="184"><tspan x="334" dy="0">Operationalizes Directives</tspan><tspan x="334" dy="16">by generating Norms —</tspan><tspan x="334" dy="16">tactical, measurable</tspan><tspan x="334" dy="16">constraints / objectives</tspan></text>
  </g>
  <g class="loopd-fn">
    <rect x="630" y="132" width="250" height="150" rx="14" />
    <g transform="translate(644,146) scale(0.62)"><circle class="loopd-ic" cx="11" cy="11" r="8" /><line class="loopd-ic" x1="21" y1="21" x2="16.65" y2="16.65" /></g>
    <text class="loopd-fn-name" x="666" y="158">Supervision</text>
    <text class="loopd-fn-body" x="644" y="184"><tspan x="644" dy="0">Evaluates Definitions and</tspan><tspan x="644" dy="16">defined subjects against</tspan><tspan x="644" dy="16">the Norms</tspan></text>
  </g>
  <g class="loopd-fn">
    <rect x="940" y="132" width="250" height="150" rx="14" />
    <g transform="translate(954,146) scale(0.62)"><polygon class="loopd-ic" points="5 3 19 12 5 21 5 3" /></g>
    <text class="loopd-fn-name" x="976" y="158">Operations</text>
    <text class="loopd-fn-body" x="954" y="184"><tspan x="954" dy="0">Produces and evaluates the</tspan><tspan x="954" dy="16">state plane, maintaining it</tspan><tspan x="954" dy="16">normalized from evaluation</tspan><tspan x="954" dy="16">feedbacks</tspan></text>
  </g>

  <!-- flow edges between functions -->
  <g class="loopd-flow">
    <line x1="260" y1="207" x2="320" y2="207" marker-end="url(#loopd-arr)" />
    <line x1="570" y1="207" x2="630" y2="207" marker-end="url(#loopd-arr)" />
    <line x1="880" y1="195" x2="940" y2="195" marker-end="url(#loopd-arr)" />
  </g>
  <g class="loopd-fb">
    <line x1="320" y1="238" x2="260" y2="238" marker-end="url(#loopd-fbarr)" />
    <line x1="630" y1="238" x2="570" y2="238" marker-end="url(#loopd-fbarr)" />
    <line x1="940" y1="218" x2="880" y2="218" marker-end="url(#loopd-fbarr)" />
    <line x1="880" y1="244" x2="940" y2="244" marker-end="url(#loopd-fbarr)" />
  </g>
  <text class="loopd-edge loopd-fb-t" x="290" y="258" text-anchor="middle">feedbacks</text>
  <text class="loopd-edge loopd-fb-t" x="600" y="258" text-anchor="middle">feedbacks</text>
  <text class="loopd-edge" x="290" y="194" text-anchor="middle">Directives</text>
  <text class="loopd-edge" x="600" y="194" text-anchor="middle">Norms</text>
  <text class="loopd-edge" x="910" y="186" text-anchor="middle">evaluates</text>
  <text class="loopd-edge loopd-fb-t" x="910" y="232" text-anchor="middle">feedbacks</text>
  <text class="loopd-edge loopd-fb-t" x="910" y="258" text-anchor="middle">feedbacks</text>

  <!-- edges to the state plane -->
  <g class="loopd-flow">
    <line x1="990" y1="282" x2="990" y2="426" marker-end="url(#loopd-arr)" />
    <line x1="1090" y1="282" x2="1090" y2="426" marker-end="url(#loopd-arr)" />
  </g>
  <text class="loopd-edge" x="983" y="368" text-anchor="end">evaluates</text>
  <text class="loopd-edge" x="1090" y="368" text-anchor="middle"><tspan x="1090" dy="0">produces ·</tspan><tspan x="1090" dy="12">maintains normalized</tspan></text>

  <!-- state plane -->
  <g class="loopd-plane">
    <rect x="10" y="430" width="1170" height="120" rx="14" />
    <g transform="translate(24,446) scale(0.62)"><polygon class="loopd-ic" points="12 2 2 7 12 12 22 7 12 2" /><polyline class="loopd-ic" points="2 17 12 22 22 17" /><polyline class="loopd-ic" points="2 12 12 17 22 12" /></g>
    <text class="loopd-fn-name" x="46" y="458">State plane</text>
    <text class="loopd-fn-body" x="24" y="486"><tspan x="24" dy="0">Your organization — its definitions, data, software, processes, teams, obligations —</tspan><tspan x="24" dy="17">the state the functions above define, realize, evaluate, and normalize.</tspan></text>
  </g>
</svg>
</div>

<style>
  .sie-loop {
    margin: 1.5rem 0 2rem;
    padding: 1.25rem;
    border-radius: 10px;
    background: #0b1020;
  }
  .sie-loop .loopd {
    display: block;
    width: 100%;
    height: auto;
    font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace;
  }
  .sie-loop rect {
    fill: rgba(255, 255, 255, .03);
    stroke: rgba(255, 255, 255, .18);
  }
  .sie-loop .loopd-actor rect { stroke-dasharray: 5 4; }
  .sie-loop .loopd-actor text { fill: #c3cdde; font-size: 13px; font-weight: 600; }
  .sie-loop .loopd-ic {
    fill: none;
    stroke: #2dd4bf;
    stroke-width: 2;
    stroke-linecap: round;
    stroke-linejoin: round;
  }
  .sie-loop .loopd-dash line { stroke: #2dd4bf; stroke-dasharray: 4 5; opacity: .55; }
  .sie-loop .loopd-fn-name {
    fill: #2dd4bf;
    font-size: 13.5px;
    font-weight: 600;
    letter-spacing: .12em;
    text-transform: uppercase;
  }
  .sie-loop .loopd-fn-body { fill: #c3cdde; font-size: 12.5px; }
  .sie-loop .loopd-flow line { stroke: #2dd4bf; stroke-width: 1.5; }
  .sie-loop .loopd-arrhead { fill: #2dd4bf; }
  .sie-loop .loopd-fb line { stroke: #818cf8; stroke-width: 1.4; stroke-dasharray: 6 4; opacity: .8; }
  .sie-loop .loopd-fbarrhead { fill: #818cf8; }
  .sie-loop .loopd-fb-t { fill: #818cf8; opacity: .85; }
  .sie-loop .loopd-edge { fill: #8493a9; font-size: 11px; }
  .sie-loop .loopd-plane rect { fill: rgba(45, 212, 191, .08); stroke: rgba(45, 212, 191, .35); }
</style>

## Reading the diagram

**Actors realize functions.** Humans, AI, and GSM Mechanisms are not separate layers of the
architecture — they are interchangeable realizers of the same four functions. A Norm may be
evaluated by a person, by an agent, or by a Mechanism executed in the Definition Operator; the loop does not
change shape.

**Governance → regulation.** Governance generates **Directives**: strategic intents and objectives.
Regulation operationalizes each Directive into **Norms** — tactical, measurable constraints. This is
the DNA grammar of [GSM]({% link gsm/index.md %}): Directives, Norms, Ascriptions.

**Supervision evaluates.** Supervision evaluates Definitions and the subjects they define against
the Norms, in a round trip through operations and the state plane. Its verdicts feed back into
regulation — the Norms were wrong or incomplete — and into operations — reality is out of
conformance.

**Operations close the gap.** Operations produce the state plane and keep it normalized from
evaluation feedback. This is the reconciliation step: the part Kubernetes performs on infrastructure
and SIE performs on anything defined.

**The state plane** is your organization itself — its definitions, data, software, processes, teams,
and obligations — the state the four functions define, realize, evaluate, and normalize.

## Where each product sits in the loop

- **[Definition Manager]({% link sie/definition-manager/index.md %})** holds the definitions and
  enforces their lifecycle — the API surface the whole loop reads and writes.
- **[Definition Operator]({% link sie/operator/index.md %})** evaluates Norms and executes Mechanisms — the
  runtime that realizes supervision and operations.
- The **[Blackboard Manager]({% link sis/blackboard-manager/index.md %})**, part of
  [SIS]({% link sis/index.md %}) rather than SIE, sources definitions collaboratively from
  evidence, keeping the model anchored to the state plane instead of drifting from it.
</content>
