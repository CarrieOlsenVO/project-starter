# docs/

Long-form project documentation. Top-level files (`Architecture.md`, `Spec.md`, `ProjectStatus.md`, `CLAUDE.md`, `SECURITY.md`, `AI_POLICY.md`) describe current state. `docs/` holds historical reasoning and supplementary material.

Common subdirectories:

- `docs/adr/` — Architecture Decision Records. Useful once a project accumulates architectural decisions worth recording; safe to omit for small or short-lived projects (see BOOTSTRAP.md's strip-down section).
- `docs/wireframes/` — UI wireframes and microcopy drafts (add when the project has UI).
- `docs/research/` — research notes, user interviews, market scans (add when relevant).
- `docs/reference/` — deep dives into complex features.

## Optional patterns

These are intentionally not included by default:

- **`ChangeLog.md`** — a hand-curated, user-facing record of what changed in each version. Useful for projects that ship versioned releases to external users; redundant when git history, GitHub Releases, and ADRs already cover the audit trail. Add at the project root if your project will have a release cadence external users follow.

Add subdirectories or files when you have material to put in them, not preemptively.
