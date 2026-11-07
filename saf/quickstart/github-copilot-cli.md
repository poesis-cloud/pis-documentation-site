---
layout: default
title: GitHub Copilot app / Copilot CLI
parent: Quickstart
grand_parent: SAF — the Systemic Agentic Framework
nav_order: 1
---

# Quickstart — GitHub Copilot app / Copilot CLI

{: .no_toc }

The GitHub Copilot app and the standalone `copilot` CLI share one agent runtime, so the harness's `github-copilot-cli` adapter and this install serve both. You will:

1. clone the harness (v1.0.0-alpha.1) and the SAFe Agentic Organization (`main`), and create the harness virtual environment;
2. prepare your workspace repository;
3. render the organization's plugin bundle;
4. run the harness `install.py`, which adds the hooks to that bundle;
5. add the bundle as a local marketplace and install the plugin;
6. select an orchestrator.

Every command below comes from the two repositories' READMEs. Marketplace distribution is planned; today the plugin is installed by hand, from a bundle you render yourself.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Prerequisites

- The GitHub Copilot app, or the GitHub Copilot CLI (`copilot`), signed in. The plugin commands in step 5 use the `copilot` CLI.
- Python 3.10–3.12, Git 2.38 or later, and a workspace repository with a Git identity: see [Prerequisites, all hosts]({% link saf/quickstart.md %}#prerequisites-all-hosts).

The adapter is Windows-first: every hook runs `adapter.py` through the recorded virtual-environment interpreter (`exec` and `args`), without bash.

## 1. Clone both repositories and create the harness virtual environment

Clone the two repositories side by side. Pin the harness to its release tag; the organization has no release that matches it, so use `main`.

Linux / macOS (bash):

```bash
git clone https://github.com/poesis-cloud/saf-agentic-organization
git clone --branch v1.0.0-alpha.1 https://github.com/poesis-cloud/saf-agentic-harness
python3 -m venv saf-agentic-harness/.venv
saf-agentic-harness/.venv/bin/python -m pip install -r saf-agentic-harness/requirements.txt
PY="$PWD/saf-agentic-harness/.venv/bin/python"; ORG="$PWD/saf-agentic-organization"
```

Windows (PowerShell):

```powershell
git clone https://github.com/poesis-cloud/saf-agentic-organization
git clone --branch v1.0.0-alpha.1 https://github.com/poesis-cloud/saf-agentic-harness
py -3.12 -m venv saf-agentic-harness\.venv
saf-agentic-harness\.venv\Scripts\python -m pip install -r saf-agentic-harness\requirements.txt
$Py = "$PWD\saf-agentic-harness\.venv\Scripts\python.exe"; $Org = "$PWD\saf-agentic-organization"
```

## 2. Prepare the workspace repository

The workspace is where the agents write artifacts and the harness writes its logs. Use an existing portfolio repository, or create one. It needs a Git identity and at least one commit.

```bash
git init my-portfolio
git -C my-portfolio config user.name "Your Name"
git -C my-portfolio config user.email "you@example.com"
git -C my-portfolio commit --allow-empty -m "Start the SAF workspace"
WS="$PWD/my-portfolio"            # PowerShell: $Ws = "$PWD\my-portfolio"
```

The artifacts land under `portfolio/` in this repository, at the paths the organization's `conf/workspace.conf.yaml` declares. The logs land in `logs/`, one JSONL file per orchestrator or worker session; the harness excludes that folder from Git.

## 3. Render the plugin bundle

The organization's root is host-agnostic source. Render it into the Copilot plugin bundle (agents, skills, workflows, configuration, and a one-plugin local marketplace):

```bash
BUNDLE="$HOME/.saf/github-copilot-cli"
"$PY" "$ORG/builds/github-copilot-cli/render_bundle.py" "$ORG" "$BUNDLE"
# or: make -C "$ORG" bundle-cli CLI_BUNDLE_DIR="$BUNDLE"
```

```powershell
$Bundle = "$HOME\.saf\github-copilot-cli"
& $Py "$Org\builds\github-copilot-cli\render_bundle.py" $Org $Bundle
```

The renderer reports `14 agents, 37 skills`. It updates an existing bundle in place, and leaves it intact when the source is refused.

## 4. Add the harness hooks to the bundle

Run the installer **with the virtual-environment interpreter**: it is the one recorded in every hook.

```bash
"$PY" saf-agentic-harness/adapters/github-copilot-cli/install.py \
    --framework-dir "$ORG" --bundle-dir "$BUNDLE" --workspace-dir "$WS"
# or: make -C saf-agentic-harness install-hooks-copilot-cli FRAMEWORK_DIR="$ORG" \
#       BUNDLE_DIR="$BUNDLE" WORKSPACE_DIR="$WS" HARNESS_PYTHON="$PY"
```

```powershell
cd saf-agentic-harness
.venv\Scripts\python adapters\github-copilot-cli\install.py --framework-dir $Org `
    --bundle-dir $Bundle --workspace-dir $Ws
```

`--framework-dir` is the organization **checkout**, not the rendered bundle. The installer writes, all or nothing:

- `<bundle>/hooks.json`, the global hooks. Each entry runs the recorded interpreter and carries `FRAMEWORK_DIR` and every `FRAMEWORK_*_DIR` in its `env`, so you set no user-level variables (`setx`).
- A managed `hooks:` block in the frontmatter of each orchestrator agent in the bundle (`value-management-officer`, `release-train-engineer`, `scrum-master`). These agent-scoped hooks open the orchestrator session.

It refuses, and writes nothing, when the interpreter cannot import the harness requirements or when the organization's `.env` is malformed. Add `--dry-run` to print the plan first.

Other options:

- `--hooks-target repo --target-repo <workspace>` writes the global hooks to `<workspace>/.github/hooks/safe-harness-copilot-cli.json` instead. Repository hooks run only in a **trusted folder**, and the file holds machine paths: git-ignore it.
- `--hooks-target user` writes them under `~/.copilot/hooks/`.
- `--hook-style shell` writes `powershell` / `bash` command strings instead of `exec` entries.

## 5. Add the local marketplace and install the plugin

```bash
copilot plugin marketplace add "$BUNDLE"
copilot plugin install poesis-saf-agentic-organization@poesis-saf-agentic-organization-local
```

A plugin installed from a local marketplace is read **live** from the bundle folder: after a re-render or a re-install of the hooks, the change takes effect in the next conversation, with no reinstall.

Avoid `copilot plugin install <path>`: it **copies** the bundle. With a copy, you must run `copilot plugin update <plugin>` after every run of `install.py`, or the host keeps an old copy without hooks.

On the standalone CLI you can also skip the install and load the bundle live for one run:

```bash
copilot --plugin-dir "$BUNDLE" --agent poesis-saf-agentic-organization:value-management-officer
```

## 6. Select an orchestrator

1. Open the conversation in your **workspace repository**, and trust that folder (in the app, or at the CLI's trust prompt).
2. Select one of the three orchestrators. The runtime namespaces plugin agents as `<plugin>:<agent>`:
   - in the app, pick it in the agent picker;
   - on the CLI, run `copilot --agent poesis-saf-agentic-organization:value-management-officer` (or `…:release-train-engineer`, `…:scrum-master`).

| Orchestrator | Layer | Grain it writes |
|---|---|---|
| `value-management-officer` | Portfolio | Epic |
| `release-train-engineer` | Program (ART) | Feature |
| `scrum-master` | Team | Story |

Every conversation receives a short harness context when it opens: the framework root, the workspace, and the exact command lines the orchestrator uses to ask the harness. If the orchestrator reports that no harness context was injected, the hooks are not running: see [Troubleshooting](#troubleshooting). It then marks its gate packet `harness=unchecked`.

Continue with **[Running workflows]({% link saf/usage.md %})**.

---

## Model binding

The organization's model catalogue (`conf/model-profiles.conf.yaml`) names canonical model slugs. The adapter's `models.yaml` maps each one to a model the host offers. Every hook re-reads both files when it loads and refuses a catalogue that names a slug `models.yaml` does not bind: the hook exits 2 and names the unbound slugs. Keep `models.yaml` in step with the models the host offers today.

On this host, a model is bindable only if a `task` subagent running on it gets a write tool (`create` / `edit`, or `apply_patch`). Without one, the step's actor cannot write its artifact. For this reason `gpt-5.3-codex` is not bound.

## Troubleshooting

- **No harness context when the conversation opens.** Check that the plugin is installed and that you selected the namespaced orchestrator. With `--hooks-target repo`, also check that the folder is trusted: repository hooks silently do not run in an untrusted folder. Plugin hooks run regardless.
- **Every tool call is denied, "hook exited with code 2".** A hook cannot bootstrap: the framework root moved, `.env` is malformed, the virtual environment was recreated, or the model catalogue names an unbound slug. The diagnostic is on the hook's stderr. Re-run `install.py`, or disable the plugin.
- **The orchestrator's harness command "is denied".** That is the normal answer channel: see [How the orchestrator asks the harness]({% link saf/usage.md %}#how-the-orchestrator-asks-the-harness).
- **`state-error` with code `workflow-instance-busy`.** An earlier orchestrator session was interrupted: follow [Recovering an interrupted workflow instance]({% link saf/usage.md %}#recovering-an-interrupted-workflow-instance).

The adapter's full limits are listed in [Known alpha limitations]({% link saf/agentic-harness/limitations.md %}) and in its [README](https://github.com/poesis-cloud/saf-agentic-harness/blob/v1.0.0-alpha.1/adapters/github-copilot-cli/README.md).

The adapter keeps its records of orchestrator and worker sessions outside every repository: in `%LOCALAPPDATA%\saf-agentic-harness\github-copilot-cli` on Windows, else `$XDG_STATE_HOME/saf-agentic-harness/github-copilot-cli`. `SAF_HARNESS_STATE_DIR` overrides both.
