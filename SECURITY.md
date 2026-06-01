# SECURITY.md

A short, friendly introduction to how this project keeps your work — and any users' data — safe. Read this once; it'll make the guardrails you'll bump into make sense.

## The watchman vs the expert

Traditional security scanners are like a watchman with a binder of badge photocopies: they recognize patterns they've seen before and miss anything new. AI reasoning engines act more like a security expert who understands *why* a person is in a building, not just whether their badge matches a picture. Both have a place. This project uses both: pattern-matchers (like gitleaks) to catch known shapes of secrets, and AI review for the harder logic questions.

## The three layers of guardrails

When Claude Code (or any AI agent) can run commands and edit files, you want **defense in depth** — multiple independent layers that catch mistakes.

### 1. Permissions (advisory)
`.claude/settings.json` declares what's denied and what's pre-allowed. If Claude tries something denied, it pauses and asks you. Useful, but it depends on Claude cooperating and on you reading the prompt carefully.

### 2. Hooks (deterministic — the MVP)
`.claude/hooks/*.sh` are shell scripts that run *before* Claude executes certain tools. They read the proposed action, decide, and exit with a code:

- **Exit 0**: safe, allow.
- **Exit 2**: dangerous, **block**. There is no "Allow" button. The block stands.

This is the strongest layer because it doesn't depend on attention or cooperation. If a hook says no, the system says no.

Two hooks shipped here:
- `validate-commands.sh` — blocks `rm -rf /`, force-push to main, `curl | bash`, `sudo`, `--no-verify`, fork bombs.
- `protect-files.sh` — blocks writes to `.env*`, credentials files, SSH/GPG dirs, and git hook files.

### 3. CLAUDE.md (style guide)
The project's operating instructions. Shapes how Claude writes code in the first place — "use env vars for secrets, never push to main, plan before significant work." Suggestive, not enforcing.

## Hook philosophy

Hooks should be deterministic and narrow. They block known-dangerous operations. They do not enforce coding style. They do not implement business logic. If a hook becomes complicated enough that a human must interpret its output to know what to do, it has stopped being a deterministic guardrail and started being a soft suggestion — which is what `CLAUDE.md` is for, not what hooks are for.

When in doubt: prefer adding a rule to `CLAUDE.md` (advisory) over a hook (deterministic). Hook creep is real, and a hook that blocks too widely teaches the team to bypass it.

## Why environment variables matter

Anything you hard-code into a source file lives in git history forever. If you commit an API key once and then "delete" it, the key is still recoverable from history. Treat any committed secret as compromised: **rotate it immediately, then scrub the history if needed**.

That's why `.env` exists. It holds your real values, and `.gitignore` keeps it out of the repo. `.env.example` is the committed *template* showing structure — never values.

The three-tier `.env.example` in this template makes the trust boundary visible:
- **Tier 1**: public, fine in the browser.
- **Tier 2**: server-only, never client.
- **Tier 3**: highly privileged. Service-role keys, admin tokens. Compromise = rotate now.

If you ever feel the urge to put a tier-3 secret behind a `NEXT_PUBLIC_` (or any client-visible) prefix, **stop**. That single prefix can leak admin access to every visitor.

## Why human-in-the-loop matters

AI agents do 80–90% of the typing in this kind of project, but they don't do 100% of the judgment. Your job is to *validate* — to read what's about to ship and decide whether the logic actually does what you wanted. The AI finds the needle in the haystack and hands you the patch; you sign off.

A useful rule: ask whether an action is *reversible* and whether it's *visible to others*. Reversible-and-private (edit a working file, run a local test) can proceed — let the agent work. Anything irreversible *or* visible to others is where you slow down, and "slowing down" means a specific response, not just closer attention:

- **Needs your review first** (dependency changes, schema migrations, security or CI edits): read the proposed change, then approve it or send it back. The agent acts only after you approve.
- **You execute, the agent only drafts** (production deletion, secret rotation, charging a card, emailing real users, deploying, force-pushing): the agent prepares it; *you* run the command. There is no approval that hands this to the agent.

`AI_POLICY.md` is the authoritative split of which actions fall where. This rule is how to reason about anything it doesn't name: if you can't tell which tier something belongs in, treat it as the stricter one and surface it.

## Why trusting untrusted repositories is dangerous

Cloning a repo and running its install script can run any code its authors wrote — on your machine, with your permissions. Same goes for npm/pip/cargo postinstall scripts. Read what you run, especially from sources you don't know. If a setup says "just paste this into your terminal," that's exactly when to slow down.

## What to do if something feels off

- A hook blocked something and you don't understand why → read the error, ask Claude to explain, don't bypass.
- A secret got committed → assume compromised, rotate the key, scrub the history.
- A dependency is doing something surprising → read its source, or pin to an earlier version while you investigate.
- The AI suggests `--no-verify`, `--force`, or `sudo` → pause.

The guardrails aren't there to slow you down. They're there to catch the one moment in a thousand where moving fast would have cost you a week.

## If this project is retired

Most templates assume success. Many projects fade. Graceful shutdown is part of security hygiene.

When you decide a project is over:

1. **Rotate active secrets.** Any key that ever lived in `.env` should be rotated — even if the project never shipped. Keys leak through old laptops, old chat histories, abandoned hosting accounts.
2. **Remove deployments.** Vercel/Netlify previews, Supabase projects, hosted databases. An abandoned-but-running deployment is a slow leak.
3. **Cancel paid services.** Stripe, email providers, paid APIs.
4. **Archive the GitHub repo.** Read-only; signals it's not maintained.
5. **Remove or update DNS.** Domains pointing at dead deployments are a phishing surface for future owners.
6. **Update `ProjectStatus.md`** so the last state of the project is honest.

Failing to retire gracefully is one of the most common ways a "small side project" becomes a security incident two years later.
