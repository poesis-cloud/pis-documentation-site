---
layout: default
title: Quickstart
parent: SAF — the Systemic Agentic Framework
nav_order: 1
redirect_from:
  - /safe-agentic-framework/quickstart/
  - /saf/quickstart/github-copilot-cli/
  - /saf/quickstart/vscode/
---

# Quickstart

{: .no_toc }

SAF runs on your own machine, inside GitHub Copilot. It ships as two Copilot plugins (Agent Plugins 1.0), which you install together:

- **`poesis-saf-agentic-harness`**: the [Agentic Harness]({% link saf/agentic-harness/index.md %}), which governs every workflow the agents run;
- **`poesis-saf-agentic-organization`**: the [SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %}), which holds the agents, skills, workflows and artifact schemas.

One pair of plugins serves every Copilot host: the Copilot CLI, the GitHub Copilot app, and VS Code with the Copilot session target.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Prerequisites

- The [Copilot CLI](https://docs.github.com/copilot/how-tos/set-up/install-copilot-cli) (`copilot`), signed in. The GitHub Copilot app embeds it.
- Python 3.10 or later and Git 2.38 or later, with a Git identity (`user.name` and `user.email`).

## 1. Install the plugins

Both modes install both plugins from the marketplace [`poesis-cloud/saf-marketplace`](https://github.com/poesis-cloud/saf-marketplace).

| Channel | Marketplace id | Receives |
|---|---|---|
| Stable | `poesis-saf` | final releases |
| Preview | `poesis-saf-preview` | pre-releases (`-alpha`, `-beta`, `-rc`) |

### Mode A: the marketplace

Stable:

```bash
copilot plugin marketplace add poesis-cloud/saf-marketplace
copilot plugin install poesis-saf-agentic-harness@poesis-saf
copilot plugin install poesis-saf-agentic-organization@poesis-saf
```

Preview:

```bash
copilot plugin marketplace add poesis-cloud/saf-marketplace#preview
copilot plugin install poesis-saf-agentic-harness@poesis-saf-preview
copilot plugin install poesis-saf-agentic-organization@poesis-saf-preview
```

In the **GitHub Copilot app**, open Customize, add the marketplace `poesis-cloud/saf-marketplace`, then install both plugins. In **VS Code**, enable `chat.plugins.enabled`, add the marketplace to `chat.plugins.marketplaces`, and install both plugins.

### Mode B: the one-liner

The installer adds the marketplace if it is missing and installs both plugins. It is idempotent.

Linux / macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/poesis-cloud/saf-agentic-organization/main/install.sh | sh
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/poesis-cloud/saf-agentic-organization/main/install.ps1 | iex
```

Add `--preview` (`-Preview` on PowerShell) for the preview channel, and `--dry-run` to print the `copilot` commands without running them.

## 2. Use the Copilot session target

In VS Code, select **Session Target: Copilot**. **VS Code Local is not supported**: the plugins' hooks do not run there. The Copilot CLI and the GitHub Copilot app need no selection.

## 3. Initialise a workspace

The harness governs a **workspace**: a Git repository whose checked-out branch holds a committed `.saf/workspace.yaml`, at the Git top-level. The marker names the framework.

1. Open the repository in a **trusted folder**. In an untrusted folder the harness hooks do not run.
2. Start a Copilot session and ask to initialise it as a SAF workspace. The organization's `init` skill (`poesis-saf-agentic-organization:init`) checks Git, then writes and commits `.saf/workspace.yaml` and `.github/copilot/settings.json`. The second file recommends the marketplace and enables both plugins for everyone who opens the repository.

## 4. Select an orchestrator

Start a **new** Copilot session in the workspace and select one of the three orchestrators: `value-management-officer`, `release-train-engineer` or `scrum-master`. On the CLI:

```bash
copilot --agent poesis-saf-agentic-organization:value-management-officer
```

Continue with **[Running workflows]({% link saf/usage.md %})**. To work on SAF itself, see **[Contributing]({% link saf/contributing.md %})**. What the harness does not do yet is in [Known limitations]({% link saf/agentic-harness/limitations.md %}).
