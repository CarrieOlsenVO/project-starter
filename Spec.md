# Spec.md

The Phase I planning artifact. Fill this in before writing code.

## Project rigor (Decision matrix)

| Tier        | When                                | Operational focus                                |
|-------------|-------------------------------------|--------------------------------------------------|
| Learning    | Prototypes, exploration             | Speed, core functionality                        |
| Validation  | MVP, alpha users                    | User workflows, basic stability                  |
| Production  | Public release, paying users        | Security, error handling, edge cases, UI polish  |

**This project is:** ____________

## Locked decisions

Decisions that have been made and should not be reopened without explicit instruction. New ideas about these items go to "Open questions and deferred ideas."

Claude: do not reopen items in Locked Decisions unless explicitly asked.

| Date | Decision | Why |
|------|----------|-----|
| (YYYY-MM-DD) | (e.g., V1 ships as static-first PWA, no accounts) | (e.g., minor users; eliminates auth/PII scope) |

## Product requirements (the What and Why)

### Who this is for
(Specific user. Not "users." Who, what context, what problem they have.)

### V1 user flows
(Walk through the core user actions step by step. Specifics, not generalities.)

### V1 scope (in)
- 

### V1 scope (out — explicitly deferred)
- 

### Success criteria
(How will we know V1 worked? What can a user do that they couldn't before?)

## Engineering requirements (the How)

### Tech stack (prescriptive)
- Frontend:
- Backend:
- Database:
- Hosting:
- Auth:
- Payments:
- Email:
- AI services:
- Other:

### Architecture
(System design, data model, integrations. Link to `Architecture.md` for the living version.)

### Privacy and data handling defaults
- Analytics:
- Logging:
- Retention:
- PII handling:

### Security posture
(Anything beyond what `SECURITY.md` and the hooks already enforce. Most projects: nothing extra.)

## Open questions and deferred ideas
- 

## Clarifying questions (run before locking the spec)

Paste this into Claude Code:

> Read this Spec.md. Ask the three most important clarifying questions needed to build an MVP successfully. Do not propose solutions yet.
