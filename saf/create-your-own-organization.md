---
layout: default
title: Create your own organization
parent: SAF — the Systemic Agentic Framework
nav_order: 4
---

# Create your own SAF organization on the harness

{: .no_toc }

The [Agentic Harness]({% link saf/agentic-harness/index.md %}) is methodology-agnostic: it executes whatever **framework** it finds in a registered plugin. The [SAFe Agentic Organization]({% link saf/safe-agentic-organization/index.md %}) is one such framework. This page shows how to build another one, an agentic organization of your own, as a Copilot plugin, using [`saf-agentic-organization`](https://github.com/poesis-cloud/saf-agentic-organization) as the worked example.

The binding specifications live in the repositories' `def/` folders and are linked, not copied, here: the [harness core spec](https://github.com/poesis-cloud/saf-agentic-harness/blob/main/def/core/spec.md) and the [GitHub Copilot adapter spec](https://github.com/poesis-cloud/saf-agentic-harness/blob/main/def/adapter/github-copilot/spec.md). The organization's own build notes are [`docs/hosts/copilot-plugin.md`](https://github.com/poesis-cloud/saf-agentic-organization/blob/main/docs/hosts/copilot-plugin.md).

## 1. Repository layout

The repository root is the **host-agnostic source**. Copilot specifics live only under `builds/plugin/`.

```text
your-organization/
├── .env                 FRAMEWORK_*_DIR: where each folder below lives
├── conf/                harness.conf.yaml, workspace.conf.yaml, access-control-list.conf.yaml, model-profiles.conf.yaml
├── agents/              <slug>.agent.md — one per actor (orchestrators and specialists)
├── skills/              <slug>.skill.md — playbooks loaded on demand
├── instructions/        <actor>/<workflow>-<step>.instructions.md — per-step instructions
├── workflows/           <layer>/<slug>.workflow.conf.yaml — the steps of each workflow
├── templates/           artifact templates
├── artifacts/           <actor>/<artifact>.artifact.schema.json — one JSON Schema per artifact
├── docs/                required reading for the orchestrators
└── builds/plugin/       plugin.json, tools.yaml, host-binding.md, bin/register.{sh,ps1}, render_plugin.py
```

`.env` is the layout contract: the harness reads the `FRAMEWORK_AGENTS_DIR`, `FRAMEWORK_ARTIFACTS_DIR`, `FRAMEWORK_INSTRUCTIONS_DIR`, `FRAMEWORK_SKILLS_DIR`, `FRAMEWORK_TEMPLATES_DIR`, `FRAMEWORK_WORKFLOWS_DIR` and `FRAMEWORK_WORKSPACE_DIR` values from it, so no path is hardcoded in a hook.

## 2. Declare the harness range

`conf/harness.conf.yaml` holds one property, `require`: a PEP 440 range of harness versions your organization supports. The harness checks it on every run and refuses a version outside the range.

```yaml
require: ">=1.0.0a1,<1.1"
```

`conf/workspace.conf.yaml` is the blueprint of the artifacts your organization writes into a workspace, and `conf/model-profiles.conf.yaml` lists canonical model slugs only; the harness adapter maps them to host model ids.

## 3. Write the organization

- **Agents.** Orchestrators are the entry points you talk to; specialists run one step each. List every agent's Copilot tools in `builds/plugin/tools.yaml`; it must name exactly the source agents.
- **Skills, instructions, workflows.** A workflow lists its steps; each step names an actor, an instruction and the artifact it must deliver. The harness resolves each step, authorizes and validates every write, and accepts a step only if it delivered its artifact.
- **Templates and artifacts.** Each artifact has a JSON Schema and a template; `workspace.conf.yaml` binds both to a workspace path.

## 4. Registry and registration

The harness and every framework plugin find each other through a **per-user registry**, outside every repository and plugin: `SAF_AGENTIC_REGISTRY_DIR`, else `%LOCALAPPDATA%\saf-agentic\registry` on Windows, else `$XDG_STATE_HOME/saf-agentic/registry` (default `~/.local/state`).

- The harness plugin's `sessionStart` writes `harness/<version>/…` and the stable launcher.
- Your plugin's `sessionStart` runs `bin/register.sh` (or `register.ps1`), which writes its plugin root to `frameworks/<plugin-name>/root`.

Copy `builds/plugin/bin/register.{sh,ps1}` from the organization: the plugin-name placeholder in them is filled by the renderer. Hosts do not order the `sessionStart` hooks of two plugins, so the first Copilot session after an install can be refused with "the SAF plugins are not registered yet: start a new session". Format and fail-closed rules: [registry, adapter spec](https://github.com/poesis-cloud/saf-agentic-harness/blob/main/def/adapter/github-copilot/spec.md#the-registry).

## 5. Package the Copilot plugin

`builds/plugin/` renders the source into one plugin that serves the Copilot CLI, the GitHub Copilot app and VS Code (Session Target: Copilot).

1. **Manifest.** `plugin.json` is a closed Agent Plugins 1.0 manifest (`name`, `version`, `description`, `author`, `homepage`, `repository`, `license`, `keywords`); no `agents`, `skills` or `hooks` keys, because the host discovers them by convention. Its `version` is the release version.
2. **Render.** `make plugin PLUGIN_DIR=<dir>` runs `render_plugin.py <source-root> <plugin-root>`: agents get their `tools:` and the host binding, each skill becomes `skills/<name>/SKILL.md`, and the `sessionStart` registration is wired into `com.github.copilot/hooks/hooks.json`.
3. **Try it.** `copilot plugin install <dir>`.
4. **Release.** Tag `v<version>`, equal to the `plugin.json` version. CD publishes the release zip, commits the rendered plugin to the orphan branch `copilot-plugin` (tagged `plugin-v<version>`), and opens a pull request on [`poesis-cloud/saf-marketplace`](https://github.com/poesis-cloud/saf-marketplace) pinning the entry to that commit: on `preview` for a `-alpha`, `-beta` or `-rc` tag, on `main` otherwise.

Users then install your plugin from the marketplace next to `poesis-saf-agentic-harness`. Layout and host decisions: [Host build — the Copilot plugin](https://github.com/poesis-cloud/saf-agentic-organization/blob/main/docs/hosts/copilot-plugin.md).

## 6. Initialise a workspace

A folder is a **SAF workspace** of your organization when its Git top-level holds `.saf/workspace.yaml`, committed in `HEAD`:

```yaml
framework: your-plugin-name   # the framework plugin's name
root: portfolio               # a top-level node slug of conf/workspace.conf.yaml
```

Both properties are required and no other is allowed. The harness governs only such a folder, for the one framework the marker names. Ship an `init` skill in `builds/plugin/skills/init/` that checks Git (≥ 2.38, with an identity), writes the marker and `.github/copilot/settings.json`, and commits both; the orchestrators point users to it when the folder is not a workspace.

## 7. Run it

Start the Copilot CLI, the GitHub Copilot app or VS Code in the workspace, with your orchestrator selected as `<plugin-name>:<orchestrator>`. The orchestrator asks the harness to resolve each step, dispatches it to a specialist with `task`, and ends every workflow at a human gate. Each step runs in exactly one Copilot session; the harness refuses a second. See [Running workflows]({% link saf/usage.md %}) and [Contributing]({% link saf/contributing.md %}) for the developer install.
