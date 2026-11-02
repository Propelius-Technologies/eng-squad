# Complexity Rubric

Score each factor 0–2, add them up, and pick the tier. When in doubt, go **one tier down**: you can escalate mid-task, but you can't un-spend tokens.

| Factor | 0 | 1 | 2 |
|---|---|---|---|
| Files touched (estimate) | 1–3 | 4–10 | 10+ |
| Modules / layers crossed | 1 | 2 | 3+ (e.g. DB + API + UI) |
| Blast radius | Isolated, internal | Shared utility / used in several places | Auth, payments, data model, public API, migrations |
| Ambiguity | Clear spec | Some open questions | Vague or conflicting requirements |
| Existing test safety net | Good tests around the area | Partial | None / flaky |

## Tiers

| Score | Tier | Team | Example |
|---|---|---|---|
| 0–3 | **S** | 1 Developer, 1 Reviewer (also does QA checks) | Fix a null check, add a field to a form, rename a config |
| 4–6 | **M** | 1 Developer, 1 Reviewer, 1 QA | New endpoint + UI hook-up, refactor one module |
| 7–10 | **L** | 2–3 Developers (one per WP, file ownership), 2 Reviewers (Correctness and Architecture), 1–2 QA | New feature across DB/API/UI, payments change, migration |

## Overrides
- **Any security, auth, payment, data-deletion or migration change** → minimum tier M, and the Reviewer must explicitly check security and data safety.
- **The user asks for a specific team size** → use it, but say once if it looks over- or under-sized.
- **Pure docs / copy / config-only change** → tier S, and QA can be skipped if nothing executable changed.

## Escalation mid-task
If a Developer reports the task is bigger than planned (more files, hidden coupling), the Orchestrator re-scores and may split WPs or add agents. Tell the user in one line.
