---
name: harden-change
description: Verify an implemented OpenSpec change in the current repository before fixes or shipping. Use only when explicitly invoked with a change identifier.
---

# Harden Change

Run the read-only hardening gate for an implemented OpenSpec change in the current repository.

## Required context

Require an OpenSpec change identifier. Read the repository's `AGENTS.md`, the change bundle under `openspec/changes/<change>/`, especially `tasks.md`, and any ADRs or evaluation assets referenced there.

## Work

1. Inspect the working tree. If it contains unrelated changes that would contaminate the review, stop and describe the scope conflict.
2. Identify and run only the tests and evaluations required by `tasks.md`. Do not invent substitute checks.
3. Validate the OpenSpec change strictly and check the diff for whitespace errors or conflict markers.
4. If the preceding gates pass, run `convoy --change <change> --pipeline review`. Attach an ADR with `--file` only when it is relevant context outside the OpenSpec bundle.
5. Return a compact per-repository report: executed tests/evaluations, OpenSpec validation, review result, unresolved findings and one recommendation: `listo para ship`, `requiere fixes` or `requiere decisión humana`.

## Boundaries

- Do not modify code or specifications, run `fixer` or `ship`, or create commits, pushes, merge requests or issues.
- Do not accept or dismiss review findings automatically. Findings need reproducible evidence and human triage before they become a fix brief.
- If a test, evaluation or validation fails, report it and do not run the Convoy review.
