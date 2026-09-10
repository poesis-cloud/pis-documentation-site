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

Refresh the checked-in GSM research and schema content from sibling
`gsm/gsm-research-lab` and `gsm/gsm-specifications` checkouts before building:

```bash
./scripts/sync-gsm-content.sh
```

The GSM source repository remains authoritative. Normative specification
prose and PlantUML live only in
[gsm-specifications](https://github.com/poesis-cloud/gsm-specifications).
Research and schema publication copies are checked in because the Pages
build cannot fetch the private source repository.

```bash
bundle install
bundle exec jekyll serve
```

## License

See [LICENSE](LICENSE) and [TRADEMARK.md](TRADEMARK.md).
