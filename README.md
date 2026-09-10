# Poesis Documentation

Source of [docs.poesis.cloud](https://docs.poesis.cloud) — the user documentation for Poesis
solutions and products (ITIP, SIE, GSM, SAF). The corporate site lives at
[poesis.cloud](https://poesis.cloud) ([poesis-cloud/corporate](https://github.com/poesis-cloud/corporate)).

## Stack

- [Jekyll](https://jekyllrb.com/) 4.3 with the [just-the-docs](https://just-the-docs.com/)
  remote theme (`v0.10.0`), teal color scheme with a dark-mode toggle.
- Plugins: `jekyll-remote-theme`, `jekyll-relative-links`, `jekyll-redirect-from`, `jekyll-sitemap`
  (`jekyll-seo-tag` ships with the theme).
- Deployed to GitHub Pages by [.github/workflows/pages.yaml](.github/workflows/pages.yaml)
  on push to `main`, manual dispatch, and a daily cron.

## Structure

Content mirrors the Poesis portfolio taxonomy — Solutions → Products → Pages:

| Section | Solution |
|---|---|
| `itip/` | ITIP — IT Intelligence Platform (Web Application, Definition Blackboard Code Sourcer) |
| `sie/` | SIE — Systemic Intelligence Engine (Definition Manager, Operator, Definition Blackboard Manager) |
| `gsm/` | GSM — the standard (Specifications, Research Lab, Ontology) |
| `saf/` | SAF — Systemic Agentic Framework (Agentic Harness, SAFe Agentic Organization, Agentic Workspace) |

## Editorial policy

This site is **neutral, task-first user documentation**. Persuasion content — hero messaging,
competitive positioning, ROI, CTAs — belongs on [poesis.cloud](https://poesis.cloud), not here.

## Local build

GSM research programs, base schemas, and the Starlark Rule API are **not**
stored in this repository. Pages CI checks out the private
[gsm-specifications](https://github.com/poesis-cloud/gsm-specifications) and
[gsm-research-lab](https://github.com/poesis-cloud/gsm-research-lab) repos,
runs `scripts/sync-gsm-content.sh`, then builds. Local preview does the same
from sibling checkouts:

```bash
./scripts/sync-gsm-content.sh
```

Override source roots with `GSM_SPECIFICATIONS_ROOT` and `GSM_RESEARCH_LAB_ROOT`
when the layout is not the Poesis multi-root workspace. Do not commit the
generated trees.

The Pages workflow needs a repo (or org) secret `GSM_CONTENT_READ_TOKEN` with
`contents:read` on those two private repositories. `github.token` cannot read
them.

Normative specification prose and PlantUML live only in gsm-specifications;
companion pages link there.

```bash
bundle install
bundle exec jekyll serve
```

## License

See [LICENSE](LICENSE) and [TRADEMARK.md](TRADEMARK.md).
