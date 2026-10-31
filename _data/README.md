# `_data/roadmap.json`

Generated file — do not hand-edit.

Source of truth: `corporate/src/data/poesis-platform.ts` (each feature carries its own
version milestone and an independent scoped claim state). No synthetic shipped
entry is created. Products retain `current` separately and export all feature IDs, revised
names, `state`, evidence `kind`, scope `notes` and unchanged `milestone` metadata.
The internal `state` remains `planned`, `partial` or `delivered` for audit precision.
Public `status` is binary (`planned` or `delivered`), with `statusLabel` **Planned** or
**Implemented**. Internal `partial` maps to Planned. Products aggregate their features;
milestones aggregate only the features assigned to that version, independently of release flags.
Timeline labels say **Recorded release** when `milestone.shipped` is true and
**Planned milestone** otherwise, independently of the feature's current claim state.

The export also synchronizes only the bounded feature-scope table in `strategy/roadmap.md`;
surrounding normative prose is preserved. Tests compare all 73 features, not just milestones.

Regenerate after any change to `poesis-platform.ts`:

```bash
cd corporate && npm run sync-roadmap
```

Rendered by `_includes/roadmap_timeline.html` on `milestones.md`.
