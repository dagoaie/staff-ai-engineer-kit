---
name: prepare-change
description: Turn a completed review and grill-with-docs session into an implementable OpenSpec change. Use only when explicitly invoked after the problem and decisions have been examined.
---

# Prepare Change

Prepare a change for implementation after its existing behaviour has been reviewed and its assumptions have been challenged with `/grill-with-docs`.

## Required context

Read the available review report, grill conclusions, issue or PRD, and the relevant `AGENTS.md`, `CONTEXT.md`, ADRs and repository documentation. If an input is missing, state the gap instead of inventing it.

## Work

1. Distil confirmed decisions, remaining assumptions, risks and non-goals. Update an existing ADR or `CONTEXT.md` only for decisions already agreed; otherwise list the decision as a blocker.
2. Choose a stable, descriptive OpenSpec change identifier. If the user supplied one, preserve it.
3. Create or complete the OpenSpec bundle: `proposal.md`, `design.md`, delta specs and `tasks.md`. The bundle must define observable behaviour, acceptance criteria, tests or evaluations, security/data concerns, cost or latency constraints, observability and rollback when each applies.
4. Order tasks by dependency and make each one verifiable. Do not turn the work into issues unless the user explicitly asks for `/to-issues`.
5. End with a short readiness report: files changed, decisions recorded, blockers, and the exact next command to inspect the Convoy implementation plan.

## Boundaries

- Do not implement production code, run Convoy, create issues, or open a merge request.
- Do not treat a review finding as accepted until it is reproducible, relevant and in scope.
- Keep the specification proportional to the change; do not add process or artefacts without a concrete need.
