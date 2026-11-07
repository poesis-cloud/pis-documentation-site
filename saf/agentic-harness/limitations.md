---
layout: default
title: Known alpha limitations
parent: Agentic Harness
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 7
---

# Known alpha limitations

{: .no_toc }

v1.0.0-alpha.1 is a pre-release. These are its known limitations, from the [release notes](https://github.com/poesis-cloud/saf-agentic-harness/blob/v1.0.0-alpha.1/CHANGELOG.md#known-alpha-limitations) and the adapter READMEs.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Hosts and verification

- **Supported hosts:** VS Code with GitHub Copilot Chat, and the GitHub Copilot app / Copilot CLI. VS Code hooks are a preview feature, so settings and events may drift; the VS Code adapter specification (I13) lists the open host verifications.
- **VS Code adapter: not live-verified for this release.** It has CI coverage only.
- **Not exercised live, CI only:**
  - `apply_patch` deletes, and the all-or-nothing revert of a multi-file write: no model bound in the Copilot app writes with `apply_patch`;
  - the lock conflict between two step instances, a compare-and-swap failure at promotion, stale artifact locks, and the sweep.
- **Copilot CLI:** the standalone CLI was verified live only on Linux, offline, with a scripted model. A GitHub-authenticated CLI with real models, the CLI on Windows and macOS, the interactive CLI (`ask_user`, the trust prompt) and marketplace installs on the CLI are not yet verified live. In the app, `exec` hook entries and the wrapper around the deny reason are not byte-verified.
- **Installation is manual.** Marketplace distribution is planned.

## Hook behavior

- **A hook timeout fails open** (confirmed live), and so does a hook that fails to spawn. In the Copilot app / CLI adapter, deadlines inside the hook stop harness calls before the host's timeout (the gating hooks have a 120 s budget; harness calls stop 30 s before it), except for a stall before the adapter even runs. The VS Code adapter sets no such deadline, so a stalled harness call there can reach the host's timeout. What a fail-open bypass can still do is described in [When the hooks do not fire]({% link saf/agentic-harness/write-governance.md %}#when-the-hooks-do-not-fire).
- **A bootstrap failure at `preToolUse`** exits 2, and the agent sees only "hook exited with code 2". The diagnostic goes to the hook's stderr.
- **A bootstrap failure at `Stop` / `SubagentStop`** (VS Code) exits 2, which asks the agent to continue, bounded by the host's `stop_hook_active` guard.
- **The harness answer looks like a denial.** No adapter edits an agent's command: the hook runs the orchestrator's harness request itself and returns the report as a hook denial. In VS Code it arrives as `Tool execution denied: …`, and you also see a `Tried to use run_in_terminal` block. Re-issuing `resolve-step-model` returns the same answer. Re-issuing `resolve-step` while its step is in flight is refused with `step-in-flight`: the orchestrator must dispatch the step it was given, not ask again.
- **Latency (Copilot app / CLI).** Plugin hooks start Python for every tool call in every folder; ungoverned conversations return after one state lookup.

## Orchestrator and worker sessions

- **An interrupted orchestrator session keeps its workflow instance busy** until you end it by hand: see [Recovering an interrupted workflow instance]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance).
- **A `start-session` refused with `worker-session-bound` is not journaled**: the refused worker session has no log. The refusal reaches the agent only through the hook.
- **One workflow instance per orchestrator session**, and no concurrent workflow instances: running several at once is a deliberate non-goal of this release.
- **Inside a VS Code subagent, worker session attribution** comes from the adapter's own stack, not from the host payload.
- **Logs are local.** `workflows` and `steps` in conditions see only this machine's logs; continuing a workflow instance on another machine is not supported.

## Writes

- **Deleting governed artifacts is unsupported in v1.** `delete` is always denied, and so is an `apply_patch` move of a governed artifact, because a move implies a delete.
- **Shell writes (Copilot app / CLI) are guarded textually only.** The adapter denies shell commands that name the workspace or `logs/`, but a determined command can evade a textual check. A shell change to a path the step instance holds can be swept into that path's next validated commit, and a write that bypassed authorization can still be validated and committed by the write-ended hook; function 9 never commits invalid bytes. Agents must write with `create`, `edit` or `apply_patch`. See [When the hooks do not fire]({% link saf/agentic-harness/write-governance.md %}#when-the-hooks-do-not-fire).
- **Model binding (Copilot app / CLI).** A model is bindable only if its `task` subagents get a write tool; `gpt-5.3-codex` is not bound. If a bound model is no longer offered, the app silently runs another model with the named model's tool set.

## Copilot app / CLI specifics

- **Repository hooks run only in a trusted folder**; plugin hooks run regardless.
- **A harness command must be the only tool call in its batch** in the app.
- **Plugin agents must use the runtime's `<plugin>:<agent>` names**, for selection and dispatch.
- **The CLI's non-interactive `copilot -p` offers no `ask_user`**, so it has no human gate: run a workflow interactively.
- The adapter specification's *Limited or unsupported boundaries* section details each limit and its fallback.
