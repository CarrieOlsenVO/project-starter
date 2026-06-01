# AI_POLICY.md

Repository-level policy for AI agents (Claude Code, Cursor, ChatGPT, etc.) operating in this project. Distinct from `CLAUDE.md` (operating *instructions*); this is operating *authority*.

## Allowed (autonomously, with normal review)
- Code generation, refactoring, test writing
- Documentation drafting
- Local file edits within the workspace
- Reading the codebase
- Running tests, type checks, linters

## Requires explicit human review before action
- Security changes (hooks, permissions, gitleaks rules)
- Database migrations and schema changes
- Dependency additions or version bumps
- CI/CD pipeline changes
- Authentication and authorization logic
- Anything touching `.env*`, `SECURITY.md`, `.claude/`, or `.github/workflows/`

## Never autonomous (human must execute; AI may draft)
- Production deletion (records, branches, deployed services)
- Secret rotation
- Financial actions (charging, refunding, subscription changes)
- Sending email or notifications to real users
- Force-pushing to shared branches
- Publishing packages or deployments
- Closing or deleting issues/PRs without explicit instruction

## When in doubt
The agent surfaces the action and waits. Cost of asking is small; cost of an action visible to others or affecting paying users can be very high. This rule applies even when an action would otherwise be authorized — when in doubt, surface.
