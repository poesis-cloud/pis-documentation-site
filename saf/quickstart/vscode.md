---
layout: default
title: VS Code with Copilot Chat
parent: Quickstart
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 2
---

# Quickstart — VS Code with GitHub Copilot Chat

{: .no_toc }

> **Warning — the VS Code adapter is not live-verified for v1.0.0-alpha.1.** It has CI coverage only. VS Code agent hooks are a preview feature, so settings, events and payloads may change between VS Code releases. The [GitHub Copilot app / Copilot CLI]({% link saf/quickstart/github-copilot-cli.md %}) adapter is the one with live trials.

You will clone both repositories, point the organization at your workspace repository, render the organization's VS Code bundle, install the harness hooks with the harness renderer (the command `make install-hooks` wraps), and install the bundle in VS Code. Marketplace distribution is planned; today every step is manual.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Prerequisites

- VS Code with GitHub Copilot Chat, signed in, with agent hooks available (a preview feature).
- `bash`, which runs the shared hook entry `adapters/dispatch.sh`. On Windows, that is Git for Windows' bash, not WSL's.
- Python 3.10–3.12, Git 2.38 or later, and a workspace repository with a Git identity: see [Prerequisites, all hosts]({% link saf/quickstart.md %}#prerequisites-all-hosts).

## 1. Clone both repositories and create the harness virtual environment

```bash
git clone https://github.com/poesis-cloud/saf-agentic-organization
git clone --branch v1.0.0-alpha.1 https://github.com/poesis-cloud/saf-agentic-harness
python3 -m venv saf-agentic-harness/.venv
saf-agentic-harness/.venv/bin/python -m pip install -r saf-agentic-harness/requirements.txt
PY="$PWD/saf-agentic-harness/.venv/bin/python"; ORG="$PWD/saf-agentic-organization"
```

On Windows, run step 1 from PowerShell as in the [Copilot app / CLI guide]({% link saf/quickstart/github-copilot-cli.md %}#1-clone-both-repositories-and-create-the-harness-virtual-environment): it sets `$Py` and `$Org`, which the PowerShell blocks of steps 3 and 4 use. The commands of step 2 are the same in PowerShell.

## 2. Point the organization at your workspace repository

Create or choose the workspace repository, with a Git identity and at least one commit:

```bash
git init my-portfolio
git -C my-portfolio config user.name "Your Name"
git -C my-portfolio config user.email "you@example.com"
git -C my-portfolio commit --allow-empty -m "Start the SAF workspace"
```

The VS Code hooks read the framework layout from the organization's `.env`; a variable set in the process environment wins over the file. Its `FRAMEWORK_WORKSPACE_DIR` defaults to `workspace`, a folder inside the organization checkout. Set it to your workspace repository's absolute path:

```bash
# in saf-agentic-organization/.env (a local change; do not commit it)
FRAMEWORK_WORKSPACE_DIR=/absolute/path/to/my-portfolio
```

## 3. Render the VS Code bundle

```bash
BUNDLE=/tmp/github-copilot-bundle
"$PY" "$ORG/builds/github-copilot/render_bundle.py" "$ORG" "$BUNDLE"
# or: make -C "$ORG" bundle BUNDLE_DIR="$BUNDLE"
```

```powershell
$Bundle = "$env:TEMP\github-copilot-bundle"
& $Py "$Org\builds\github-copilot\render_bundle.py" $Org $Bundle
```

## 4. Install the harness hooks

The harness README's command is `make install-hooks FRAMEWORK_DIR=<framework root> BUNDLE_DIR=<bundle>`. In v1.0.0-alpha.1 that target looks for the workflow catalog in `<framework>/conf/workflows`, and the organization's `main` keeps it in `workflows/`, so the target stops with `render_hooks: no workflow catalog at …`. Run the renderer the target wraps, and name the catalog:

```bash
"$PY" saf-agentic-harness/adapters/render_hooks.py --env vscode-github-copilot-chat \
    --framework-dir "$ORG" --bundle-dir "$BUNDLE" --workflows-dir "$ORG/workflows"
```

```powershell
& $Py saf-agentic-harness\adapters\render_hooks.py --env vscode-github-copilot-chat `
    --framework-dir $Org --bundle-dir $Bundle --workflows-dir "$Org\workflows"
```

Run it with the virtual-environment interpreter: it records that interpreter (`SAF_HARNESS_PYTHON`) and `FRAMEWORK_DIR` in every hook entry's `env`, and refuses to render when the interpreter cannot import the harness requirements. It writes three targets in one all-or-nothing run:

1. `<framework>/.github/hooks/safe-harness.json`, the workspace hook file (git-ignored by the organization);
2. the hook that opens the orchestrator session (H0) in each orchestrator agent under `$BUNDLE/agents`;
3. `chat.useHooks: true` and `chat.hookFilesLocations`, merged into `<framework>/.vscode/settings.json`.

These files hold absolute machine paths. Re-run the renderer whenever you re-render the bundle, or move either checkout or the virtual environment.

## 5. Install the bundle in VS Code

Install `$BUNDLE` in VS Code as a GitHub Copilot agent plugin. Agent plugins are a VS Code preview feature: see VS Code's [Agent plugins](https://code.visualstudio.com/docs/copilot/customization/agent-plugins) documentation for the current way to install one.

## 6. Open the organization checkout and select an orchestrator

1. Open the **organization checkout** folder in VS Code. VS Code collects hook files from the `.github/hooks` folder of the folder it has open, and reads the settings the renderer merged there.
2. In Copilot Chat, select an orchestrator: `value-management-officer` (portfolio, Epics), `release-train-engineer` (program, Features) or `scrum-master` (team, Stories).

Continue with **[Running workflows]({% link saf/usage.md %})**.

## How the harness answers in VS Code

The orchestrator asks the harness with one plain `run_in_terminal` command, alone in its tool call:

```text
python <harness.py> resolve-step --workflow-slug <slug>
python <harness.py> resolve-step-model
```

`resolve-step-model` takes no flag: the harness deduces the step from the orchestrator session's step in flight, and rejects `--workflow-slug` there (the adapter README's example still shows it).

The terminal never runs the line. The `PreToolUse` hook runs the request for the orchestrator session and returns the report as the tool result `Tool execution denied: SAFe agentic harness RESULT (<function>): …`. That denial is the successful answer. You also see a `Tried to use run_in_terminal` block holding the report in the chat.

## Troubleshooting

- **A tool call is blocked by a hook that exits 2.** A hook cannot bootstrap: no `FRAMEWORK_DIR`, a missing interpreter or module, a malformed `.env`, or a model catalogue that names a slug the adapter's `models.yaml` does not bind. The diagnostic is on stderr. Re-run the renderer.
- **The hooks never fire.** Check that `chat.useHooks` is `true` and that `chat.hookFilesLocations` includes `.github/hooks` in the organization checkout's `.vscode/settings.json`, and that VS Code has that checkout open.
- **A `Stop` hook keeps asking the agent to continue.** A bootstrap failure at `Stop` / `SubagentStop` exits 2; VS Code's `stop_hook_active` guard bounds the loop. Repair the install.

The adapter's limits are listed in [Known alpha limitations]({% link saf/agentic-harness/limitations.md %}) and in its [README](https://github.com/poesis-cloud/saf-agentic-harness/blob/v1.0.0-alpha.1/adapters/vscode-github-copilot-chat/README.md).
