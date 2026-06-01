# project-starter

A PSB-aligned template for AI-augmented software projects. Plan, Setup, Build — wired in by default, with deterministic security hooks active from the first commit.

## Required tooling

The security layer depends on these. Install before your first commit; the pre-commit hook fails closed without gitleaks.

- `jq` >= 1.7
- `gitleaks` >= 8.20 (tested with 8.30.1; the hook uses the `stdin` subcommand, which replaced the deprecated `protect` in the 8.19/8.20 line)
- `gh` — latest stable

Claude Code's hook config schema in `.claude/settings.json` may change across CC versions. If hooks don't fire after setup, check the current schema; the hook *scripts* in `.claude/hooks/` don't need to change, only the wiring in `settings.json`.

## Use

    gh repo create my-new-thing --template <your-org>/project-starter --clone
    cd my-new-thing
    bash scripts/install-hooks.sh
    bash scripts/verify-setup.sh
    cp .env.example .env   # fill in real values; NEVER commit .env

Then follow `BOOTSTRAP.md`.

## What's in here

- `Spec.md` — Phase I planning template (product + engineering requirements)
- `Architecture.md`, `ProjectStatus.md` — self-healing docs
- `CLAUDE.md` — baseline operating instructions for Claude Code
- `AI_POLICY.md` — repository-level AI policy (allowed / requires review / never autonomous)
- `SECURITY.md` — three-layer guardrail explainer, learner-friendly
- `BOOTSTRAP.md` — first-run checklist
- `.claude/` — Claude Code permissions, hooks, and slash commands
- `.github/` — issue/PR templates, pre-commit hook, CI secret scan
- `.env.example` — three-tier env structure (client-safe, server-only, privileged)
- `docs/adr/` — Architecture Decision Records

## Strip down for small projects

See the "Strip-down for Learning-tier projects" section in `BOOTSTRAP.md`. The security layer never gets stripped.
