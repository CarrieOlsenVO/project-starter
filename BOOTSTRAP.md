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
- `AI_POLICY.md` — operating-authority distinctions matter when stakes are higher.
- `Architecture.md` if the project is small enough that `Spec.md` alone is honest.
- `.github/ISSUE_TEMPLATE/` and the PR template if you aren't using issue-based development.

Keep regardless of tier: all of `.claude/`, `.github/hooks/`, `.github/workflows/`, `.gitignore`, `.env.example`, `.gitleaks.toml`, `SECURITY.md`, `BOOTSTRAP.md`, `Spec.md`, `CLAUDE.md`, `scripts/install-hooks.sh`, `scripts/verify-setup.sh`. The security layer never gets stripped.
