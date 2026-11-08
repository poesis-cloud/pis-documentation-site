---
layout: default
title: Contributing
parent: SAF — the Systemic Agentic Framework
nav_order: 3
---

# Contributing: developer install

{: .no_toc }

Users install SAF from the marketplace: see the [Quickstart]({% link saf/quickstart.md %}). This page is for contributors who render the plugins from a checkout. Contributions are accepted under Apache-2.0 with the [Developer Certificate of Origin](https://developercertificate.org/): sign your commits with `git commit -s`.

## Table of contents

{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Repositories

| Plugin | Repository |
|---|---|
| `poesis-saf-agentic-harness` | [`poesis-cloud/saf-agentic-harness`](https://github.com/poesis-cloud/saf-agentic-harness) |
| `poesis-saf-agentic-organization` | [`poesis-cloud/saf-agentic-organization`](https://github.com/poesis-cloud/saf-agentic-organization) |

Each repository's `CONTRIBUTING.md` holds its pull request process. The harness's `def/` specifications are binding on both.

## Render and install a plugin from a checkout

Python 3.10 or later and Git 2.38 or later are required. Render each plugin into a folder, then install that folder with the Copilot CLI:

```bash
cd saf-agentic-harness
python3 -m pip install -r requirements-dev.txt
make plugin PLUGIN_DIR=/tmp/saf-harness-plugin
copilot plugin install /tmp/saf-harness-plugin

cd ../saf-agentic-organization
python3 -m pip install -r requirements-dev.txt
make plugin PLUGIN_DIR=/tmp/saf-organization-plugin
copilot plugin install /tmp/saf-organization-plugin
```

Installing a folder copies it: render again and reinstall after each change.

## Verify

```bash
make verify
```

In each repository, `make verify` runs the test suite. The organization's run uses the harness checkout at `../saf-agentic-harness` (override with `SAF_HARNESS_SRC`).

## Release

A release is a `v<version>` tag equal to the `version` in the plugin's `plugin.json`. The release workflow publishes the plugin and opens a pull request on [`poesis-cloud/saf-marketplace`](https://github.com/poesis-cloud/saf-marketplace): on `preview` for a pre-release tag (`-alpha`, `-beta`, `-rc`), on `main` otherwise.
