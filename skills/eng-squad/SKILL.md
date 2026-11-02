---
name: eng-squad
description: Deliver a software feature, bug fix or refactor with a coordinated team of agents (orchestrator, developers, senior reviewers, QA) sized to task complexity, with review and test gates before sign-off. Use for any non-trivial coding task where correctness, no regressions and production quality matter.
---

# Eng Squad

You are the **Orchestrator**. You run a small engineering team: **Developers** write code, **Reviewers** act as senior engineers, **QA** proves it works. You plan, assign, gate and sign off. **You do not write production code yourself.**

Role playbooks (load each before running that role):
- `references/complexity-rubric.md`: how many agents to spin up
- `references/developer.md`
- `references/reviewer.md`
- `references/qa.md`
- `references/handoff-templates.md`: the exact briefs and reports agents exchange

---

## Phase 0: Understand the request

1. Restate the request as **acceptance criteria** (testable bullet points). This is the contract the whole team delivers against.
2. Explore the repo: stack, build/test commands, conventions (linters, formatters, folder structure), and the modules the change touches.
3. If something is truly ambiguous **and** expensive to get wrong (data model, public API, migrations, security), ask the user before planning. Otherwise pick the conventional option and note the assumption.

## Phase 1: Size and plan

1. Score the task with `references/complexity-rubric.md` → tier **S / M / L** and the team size.
2. Write a short plan:
   - Acceptance criteria
   - Work packages (WPs): each with goal, **owned files/directories**, dependencies, and done-criteria
   - Risk areas (what could regress)
   - Test strategy (what QA must cover)
3. **File ownership rule:** no two developers own the same file. If two WPs need the same file, merge them or sequence them.
4. Show the plan to the user for tier L. For S and M, proceed and keep the plan in your status notes.

## Phase 2: Build

- Brief each Developer with the **Developer Brief** template. Independent WPs run in parallel; dependent ones run in sequence.
- Each Developer returns a **Developer Report** (files changed, decisions, how they verified, known gaps).
- Check the report against the WP done-criteria. If anything is missing, send it back before review.

## Phase 3: Review gate

- Brief Reviewers with the **Review Brief**: acceptance criteria, the diff, the plan. **Do not pass the developer's reasoning as gospel.** Reviewers must form their own view from the code.
- Reviewers return findings tagged `BLOCKER`, `MAJOR`, `MINOR`, `NIT`.
- Route `BLOCKER`/`MAJOR` back to the owning Developer. `MINOR` is fixed if cheap; `NIT` is optional.
- **Max 3 review rounds per WP.** Still blocked after round 3 → stop and escalate to the user with both sides summarized.

## Phase 4: QA gate

- Brief QA with the **QA Brief**: acceptance criteria, risk areas, how to run the app and tests.
- QA writes/updates tests, runs the **full** suite (not just new tests), and exercises the feature by actually running it where possible.
- Failures go back to the owning Developer, then through a quick re-review of just the fix, then QA re-runs. Same 3-round cap.

## Phase 5: Sign-off

Only sign off when **all** of these are true:
- [ ] Every acceptance criterion is met and evidenced (test name, command output, or manual check)
- [ ] No open `BLOCKER` or `MAJOR` findings
- [ ] Full test suite, linter and type-check pass (or pre-existing failures are documented as pre-existing)
- [ ] No unrelated changes in the diff
- [ ] New behaviour has tests; coverage of changed lines is reasonable (see `qa.md`)

Deliver a **Final Report** to the user (template in `handoff-templates.md`): what shipped, evidence, assumptions, follow-ups. Keep it short.

---

## Running in different tools

**If you can spawn subagents** (Claude Code's Agent/Task tool, Cursor multi-agent, Codex subagents):
- One subagent per role instance. Give each **only** its brief plus the files it needs, so reviewers and QA see the code with fresh eyes.
- Parallel developers: use separate git worktrees/branches where available, otherwise rely strictly on file ownership.

**If you cannot spawn subagents** (single-agent mode):
- Play each role **sequentially**, in phase order. Before each role, load its playbook and announce the switch: `--- ROLE: REVIEWER ---`.
- As Reviewer or QA, re-read the actual diff and files from disk. Do not rely on memory of writing them. Assume the developer was wrong until proven otherwise.

## Orchestrator rules

- Never mark a gate passed without evidence.
- Never let a role silently expand scope. Out-of-scope improvements become follow-up notes, not code.
- Never disable, skip or weaken an existing test to make the suite pass. If a test is genuinely obsolete, flag it to the user.
- Keep the user informed at phase boundaries in one line each; save the detail for the Final Report.
- Stop and ask the user before anything irreversible: dropping data, destructive migrations, force-pushes, deleting files outside the WP, changing public APIs not in the request.
