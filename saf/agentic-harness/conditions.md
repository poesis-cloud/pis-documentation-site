---
layout: default
title: Condition language
parent: Agentic Harness
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 5
---

# Condition language

{: .no_toc }

A step declares **conditions** in its workflow configuration. **Preconditions** gate the step's dispatch (function 5); **postconditions** decide, with delivery, whether its step instance passes and is promoted (function 10). Conditions read persisted state only: committed artifacts and the logs, never what an agent remembers.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Two kinds of condition

A **step condition** names another step of the same workflow:

```yaml
- slug: after-derive-business
  kind: precondition
  step: derive-business
```

As a precondition, the named predecessor must have a passing step instance in the current workflow instance. These predecessors also drive `resolve-step`: it returns the first remaining step, in authored order, whose predecessors all passed. A `kind: postcondition` step condition, naming a successor, is documentation only and is never checked.

A **state condition** is two CEL expressions: `setSelector.setQuery` selects a set, bound to `selected`, and `setPredicate` is a boolean evaluated over it.

```yaml
- slug: an-approved-epic-exists
  kind: precondition
  setSelector:
    setQuery: >-
      workspace.filter(e, e.kind == 'epic'
      && e.data.status in ['portfolio-backlog', 'implementing'])
  setPredicate: selected.size() > 0
```

Condition slugs are unique within a step: every check is logged with the full condition object, its outcome and, on fail, a `failureMessage`. A step without preconditions passes vacuously, with a logged entry.

## Variables

```text
workspace    the artifact instances in the state being evaluated (artifacts only, no logs)
  a.kind     artifact kind (schema slug), from the workspace layout
  a.path     workspace path
  a.data     authored content, validated by the kind's schema
workflows    workflow instances, from the logs
  w.slug     its workflow definition
  w.id       the workflow instance id
steps        step instances of every workflow instance, from the logs, oldest first
  s.slug     its step definition
  s.id       its worker session id (1 step instance = 1 worker session)
  s.workflow its workflow instance id (joins workflows by w.id)
  s.actor    the actor agent
  s.outcome  'pass' | 'fail' | 'in-flight'
  s.artifact { kind, path } | null   the artifact instance it delivered (joins workspace by path)
workflow     the current workflow instance (an element of workflows)
step         the current step instance
selected     in setPredicate only: the result of setQuery
```

Everything else is plain CEL: `filter`, `exists`, `exists_one`, `all`, `map`, `size`, `has`, `in`, `==`, `&&`, `||`. There is no per-kind artifact map: you select a kind with a guard on `a.kind`.

**Step instance fields.** `s.outcome` is `'pass'` when function 10 passed the step instance, `'fail'` when function 10 concluded it otherwise (a `fail` or an error outcome), and `'in-flight'` while nothing concluded it; a crashed or abandoned step instance stays `'in-flight'`. `s.artifact` is the `{kind, path}` of the delivered artifact instance, or `null`.

**`step` in a postcondition** is the current step instance, an element of `steps` with `outcome: 'in-flight'`; `step.artifact` is the delivery being evaluated, its `path` `null` when no single artifact instance was delivered.

**`step` in a precondition** is the step instance about to start, not yet in `steps`: `step.slug`, `step.workflow` and `step.actor` are set, `step.id` is `null`, `step.outcome` is `'in-flight'`, and `step.artifact` is `{kind: <declared kind>, path: null}`.

## Which state is evaluated

- **`workspace`** holds the artifact instances of the state the condition checks: the workspace branch for a precondition, the step state being promoted for a postcondition.
- **`workflows` and `steps`** come from this machine's logs only, which are local. The current `workflow` and its step instances are always complete; for another workflow instance, rely on artifact content, which syncs through Git.

The names follow the planes: `workspace` is the artifact plane, `workflows` and `steps` expose the log plane.

## Typing, checked at configuration load

A read of `a.data.<property>` is valid only where the kind of `a` is fixed by a **guard in the same macro**: the macro that binds `a`, the read sitting anywhere inside it, nested macros included. The guard is either:

- `a.kind == '<literal>'`; or
- a **path join** of `a.path` with the `artifact.path` of a step instance whose `s.slug` is a literal step of a known workflow: the current one (`step` itself, or `s.workflow == workflow.id`), or one fixed by a literal workflow slug through `w.slug == '<literal>'` joined by `s.workflow == w.id`. The kind is that step's declared artifact.

A macro ranging over the result of a guarded `filter`, `selected` included, reads elements of that kind. The loader checks `<property>` against that kind's schema.

Each of these is a **configuration load error**, never a false pass. The harness refuses to run until it is fixed (exit 3):

| Error | Code |
|---|---|
| an `a.data` read without a guard | `unguarded-artifact-data` |
| a property the kind's schema does not declare | `undeclared-artifact-property` |
| an unknown artifact kind | `unknown-artifact-kind` |
| an unknown step or workflow slug | `unknown-condition-step`, `unknown-condition-workflow` |
| a name that is no variable of the language | `unknown-condition-variable` |
| in a precondition, a current-workflow step that is not a declared predecessor (directly, or through its predecessors) | `precondition-step-not-predecessor` |
| in a precondition, a path join with `step` (its path is `null`) | `precondition-step-path-join` |
| an expression that does not compile | `uncompilable-condition-expression` |

When the load can fix every kind a condition reads, only those kinds are read from the evaluated state; otherwise every kind is.

## At runtime

An empty `selected` is a normal value: the predicate decides. A false predicate is a normal `fail` check. A CEL expression that **fails while evaluating** (an evaluation error, not a false result) is `state-error` with code `condition-evaluation-failed`, journaled, naming the condition slug; as a postcondition, it withholds the step instance like any error.

## Examples

A postcondition from the organization's `feature-derivation` / `derive-business` (artifact `feature`): the Feature it delivers names an approved Epic as its parent, or names none.

```yaml
- slug: parent-epic-approved
  kind: postcondition
  setSelector:
    setQuery: >-
      workspace.filter(f, f.path == step.artifact.path && f.data.parentEpic != null)
  setPredicate: >-
    selected.all(f, workspace.exists(e, e.kind == 'epic'
    && e.data.id == f.data.parentEpic
    && e.data.status in ['portfolio-backlog', 'implementing']))
```

`f` is guarded by the path join with `step`, so `f.data.parentEpic` is checked against the `feature` schema; `e` is guarded by `e.kind == 'epic'`.

A postcondition that rewrites the artifact instance an earlier step of this workflow instance delivered:

```yaml
- kind: postcondition
  slug: rewrites-drafted-artifact
  setSelector:
    setQuery: >-
      steps.filter(s, s.workflow == workflow.id && s.slug == 'discovery-and-draft'
      && s.outcome == 'pass' && s.artifact.path == step.artifact.path)
  setPredicate: selected.size() == 1
```

A precondition on the artifact a declared predecessor (`build`) delivered in this workflow instance:

```yaml
- kind: precondition
  slug: build-passed
  setSelector:
    setQuery: >-
      workspace.filter(a, steps.exists(s, s.workflow == workflow.id
      && s.slug == 'build' && s.outcome == 'pass' && s.artifact.path == a.path))
  setPredicate: selected.size() == 1 && selected.all(a, a.data.status == 'passed')
```

A rejected condition, and its fix:

```yaml
# unguarded-artifact-data: the kind of `a` is not fixed
setQuery: workspace.filter(a, a.data.status == 'approved')

# valid: the guard fixes the kind, and `status` is checked against the epic schema
setQuery: workspace.filter(a, a.kind == 'epic' && a.data.status == 'approved')
```
