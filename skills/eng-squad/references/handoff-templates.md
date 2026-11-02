# Handoff Templates

Agents start with zero context. Every brief must stand on its own: include everything the agent needs and nothing it doesn't.

---

## Developer Brief (Orchestrator → Developer)
```
ROLE: Developer. Load references/developer.md and follow it.
TASK: <one-line goal of this work package>
ACCEPTANCE CRITERIA (whole feature):
- ...
THIS WP MUST DELIVER:
- ...
YOU OWN (only edit these): <files / dirs>
DO NOT TOUCH: <files owned by others, or sensitive areas>
CONTEXT: <relevant modules, similar feature to copy, constraints, decisions already made>
COMMANDS: build=<...> test=<...> lint=<...> run=<...>
RETURN: Developer Report
```

## Developer Report (Developer → Orchestrator)
```
WP: <name>
FILES CHANGED: <path: one-line summary>
APPROACH: <2–4 lines on key decisions and why>
VERIFIED: <commands run + results; manual checks>
TESTS ADDED: <test names>
KNOWN GAPS / RISKS: <be honest; "none" only if true>
```

---

## Review Brief (Orchestrator → Reviewer)
```
ROLE: Reviewer. Load references/reviewer.md and follow it.
FEATURE: <one line>
ACCEPTANCE CRITERIA:
- ...
CHANGED FILES: <list>, or run: git diff <base>...HEAD
RISK AREAS: <what could regress>
FOCUS (tier L only): Correctness | Architecture
ROUND: <1/2/3>, previous findings: <IDs + status, if round > 1>
RETURN: Review Report
```

## Review Report (Reviewer → Orchestrator)
```
CONTEXT STUDIED: <modules, callers, tests you read>
FINDINGS:
[R1] BLOCKER  path/file.ts:42 | <problem> | Fix: <concrete fix>
[R2] MAJOR    ...
[R3] MINOR    ...
VERDICT: APPROVE | CHANGES REQUESTED
```

---

## QA Brief (Orchestrator → QA)
```
ROLE: QA. Load references/qa.md and follow it.
FEATURE: <one line>
ACCEPTANCE CRITERIA:
- ...
CHANGED FILES: <list>
RISK AREAS: <from plan + reviewer>
HOW TO RUN: build=<...> test=<...> app=<...> coverage=<...>
RETURN: QA Report
```

## QA Report (QA → Orchestrator)
```
CRITERIA:
- [PASS] <criterion> | evidence: <test / command / manual steps>
- [FAIL] <criterion> | evidence: ...
BUGS:
[Q1] <severity> | repro: ... | expected: ... | actual: ...
TESTS ADDED: <names>
COVERAGE (changed files): <numbers or "tool not available">
FULL SUITE: <pass/fail counts; pre-existing failures noted>
NOT TESTED: <what + why>
VERDICT: PASS | FAIL
```

---

## Final Report (Orchestrator → User)
Keep it short and scannable.
```
✅ Shipped: <one line>
Tier: <S/M/L>, team: <n devs / n reviewers / n QA>, review rounds: <n>

Acceptance criteria
- ✅ <criterion>: <evidence>

Changes: <files, grouped by area>
Tests: <added count>, full suite <pass>, coverage on changed lines <x%>
Assumptions: <any calls made without asking>
Follow-ups (out of scope): <list or "none">
Not verified: <anything a human should check>
```
