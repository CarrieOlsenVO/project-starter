# CLAUDE.md

Operating instructions for Claude Code on this project.

---

## TEMPLATE DEFAULTS (came from project-starter — review and keep what applies; strip the rest)

### PSB phases

Work proceeds in three phases. Don't skip ahead.

- **Phase I — Plan.** `Spec.md` is the source of truth. No code is written before the relevant `Spec.md` section is filled in.
- **Phase II — Setup.** Repository, environment, hooks, `.env` configured before feature work begins.
- **Phase III — Build.** MVP first. Issue-based development. Plan before any significant feature.

### Working pattern

- For significant features, plan before implementing.
- Validation loop after every significant change.
- Issue-based development: significant work has a GitHub issue.
- Destructive operations require explicit confirmation. Respect `.claude/hooks/`.
- Update self-healing docs (`Architecture.md`, `ProjectStatus.md`) as a natural consequence of the work.

### Linking off

- Architectural decisions → `Architecture.md` (current truth) and `docs/adr/` (history).
- Product/engineering requirements → `Spec.md`.
- Security posture → `SECURITY.md`, `AI_POLICY.md`, and `.claude/hooks/`.
- Recent state → `ProjectStatus.md`.

### Repository etiquette

- Never push to `main` without explicit confirmation.
- Never `--force` push to a shared branch.
- Branches: `feature/<desc>`, `fix/<desc>`, `chore/<desc>`.
- Descriptive commits; no "wip"/"fix"/"stuff."
- Secrets never enter the repo. Caught secrets are rotated immediately.

---

## PROJECT-SPECIFIC (replace these sections entirely — do not leave template placeholders)

### What we're building

(One paragraph. Replace this.)

### Project rigor

This project is **(Learning | Validation | Production)**.

- Learning: speed over polish, no governance overhead.
- Validation: MVP discipline, planning before significant work, basic stability.
- Production: full security/error/edge handling, UI polish, review discipline.

### Tech stack

(Prescriptive. Replace. Random stack-injection is a known failure mode.)

### Scope protection

V1 scope is whatever `Spec.md` says. New ideas during build → `Spec.md` "Open questions and deferred ideas," not into V1.

---

When in doubt: ask.
