# BOOTSTRAP.md

First-run checklist after `gh repo create --template`. Follow in order.

1. Install required tools (see README "Required tooling").
2. `bash scripts/install-hooks.sh` — chmod hooks; install the git pre-commit symlink.
3. `bash scripts/verify-setup.sh` — confirm tools and hooks are wired.
4. `cp .env.example .env` and fill in real values. Never commit `.env`.
5. Fill in `Spec.md` — Decision Matrix tier, product requirements, engineering stack. Do not write code until this is done.
6. Customize `CLAUDE.md` — replace the "Project-Specific" section; review the "Template Defaults" section and strip what doesn't apply to your rigor tier.
7. Verify hooks by deliberately tripping them:
   - Generate a realistic-entropy fake Stripe key (format: `sk_live_` + 24+ mixed-case alphanumerics). One-liner:
     ```
     echo "STRIPE=sk_live_$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 36)" > scratch.txt
     git add scratch.txt && git commit -m 'hook test'
     ```
     Expected: pre-commit blocks; remove with `rm scratch.txt`. (A low-entropy fake like `sk_live_AAA...` will not fire — gitleaks's default rules use entropy filters by design.)
   - Have Claude attempt `rm -rf /tmp/test-doesnt-exist` → `validate-commands.sh` should block.
8. Create the first GitHub issue for the actual feature work.

## Strip-down for Learning-tier projects

For Learning-tier (prototype, exploration) projects, you may safely delete:
- `Architecture.md` if the project is small enough that `Spec.md` alone is honest — but keep it for projects with vulnerable users (children, patients, healthcare, finance), where the data-model and security decisions it documents are operating boundaries, not governance overhead.
- `docs/adr/` if you're not tracking architectural decisions over time.
- `.github/ISSUE_TEMPLATE/` and the PR template — these support the issue-based-development pattern in CLAUDE.md's Template Defaults. Delete only if you also strip issue-based development from CLAUDE.md (typical for Learning-tier where you're optimizing for speed).

Keep regardless of tier: all of `.claude/`, `.github/hooks/`, `.github/workflows/`, `.gitignore`, `.env.example`, `.gitleaks.toml`, `SECURITY.md`, `AI_POLICY.md`, `BOOTSTRAP.md`, `Spec.md`, `CLAUDE.md`, `scripts/install-hooks.sh`, `scripts/verify-setup.sh`.

`AI_POLICY.md` stays put even in lean mode. It is the operating-authority layer (what an AI agent may do autonomously versus what requires human hands), and that boundary matters more, not less, in projects with vulnerable users — e.g., a kids' app — where the never-autonomous tier (no production deletion, no emailing real users, human executes the irreversible) is exactly the line you don't want left implicit. The security layer never gets stripped.
