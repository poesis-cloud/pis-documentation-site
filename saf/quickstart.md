---
layout: default
title: Quickstart
parent: SAF — the Systemic Agentic Framework
nav_order: 1
has_children: true
redirect_from:
  - /safe-agentic-framework/quickstart/
---

# Quickstart

{: .no_toc }

SAF runs on your own machine, inside an agent host. This quickstart installs the two products that run there, then gets you to your first governed workflow:

- the **[Agentic Harness]({% link saf/agentic-harness/index.md %})**, release **v1.0.0-alpha.1** (a pre-release). It governs every workflow the agents run, through hooks it registers in the host;
- the **[SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %})**, from its `main` branch. It holds the agents, skills, workflows and artifact schemas, and you render it into a bundle the host loads.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Choose your host

| Host | Harness adapter | Status in v1.0.0-alpha.1 | Guide |
|---|---|---|---|
| **GitHub Copilot app** or **GitHub Copilot CLI** (Windows, macOS, Linux) | `github-copilot-cli` | Live trials in the GitHub Copilot app (Windows) and on the standalone CLI (Linux); some paths are covered by CI only | [GitHub Copilot app / Copilot CLI]({% link saf/quickstart/github-copilot-cli.md %}) |
| **VS Code** with GitHub Copilot Chat | `vscode-github-copilot-chat` | **Not live-verified for this release.** It has CI coverage only. | [VS Code with Copilot Chat]({% link saf/quickstart/vscode.md %}) |

The GitHub Copilot app embeds the Copilot CLI agent runtime, so one adapter and one install serve both.

## Installation is manual today

Both guides install from source: you clone the two repositories, render the organization's bundle for your host, and run the harness installer on that bundle. Marketplace distribution is planned; it does not exist yet.

The installer writes absolute paths of your machine into the bundle (the interpreter, the harness, the framework). These files are generated, never committed. Re-run the installer whenever you re-render the bundle, move either checkout, or recreate the harness virtual environment.

## Prerequisites, all hosts

- **Python 3.10, 3.11 or 3.12**, in a virtual environment holding the harness's `requirements.txt`. The installer records that interpreter in every hook, and refuses one that cannot import the requirements.
- **Git 2.38 or later** on `PATH`. The harness rebases step instances in memory with `git merge-tree --write-tree`.
- **A workspace**: a Git repository where the agents write artifacts and the harness writes its logs. In SAF this is your portfolio repository. It needs at least one commit, because the harness reads workspace state from the checked-out branch (`HEAD`).
- **A Git identity in that workspace** (`git config user.name` and `git config user.email`, in the repository or globally). The harness commits every validated write onto a step ref, and replays those commits when it promotes a step instance.

The harness keeps its own refs under `refs/harness/*` (step refs and artifact locks). They are local-only: Git's default refspecs never push or fetch them. It also excludes the `logs/` folder from Git in the workspace's `.git/info/exclude`.

## After the install

- **[Running workflows]({% link saf/usage.md %})** — run a first workflow, continue it, and recover an interrupted workflow instance.
- **[Known alpha limitations]({% link saf/agentic-harness/limitations.md %})** — what this pre-release does not do yet.
