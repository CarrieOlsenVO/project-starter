# Architecture Decision Records

One file per significant architectural decision. Format:

    docs/adr/<NNNN>-<short-title>.md

Each ADR follows:

## Context
What was the situation that required a decision.

## Decision
What we chose.

## Alternatives considered
What else was on the table and why it was ruled out.

## Consequences
What this commits us to. Tradeoffs. What becomes harder.

ADRs are append-only. If a decision is later reversed, write a new ADR that references and supersedes the old one — don't edit the old one. `Architecture.md` describes the *current truth*; ADRs describe *how we got there and what else we considered*.
