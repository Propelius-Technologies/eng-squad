# 🛠️ Eng Squad

A portable [Agent Skill](https://agentskills.io) that turns your coding agent into a small engineering team:

| Role | Job |
|---|---|
| 🧭 **Orchestrator** | Plans, sizes the team, assigns work, enforces gates, signs off. Never writes code. |
| 👩‍💻 **Developers** | Write the code for one work package each, with strict file ownership. |
| 🧐 **Reviewers** | Senior engineers. Study the surrounding code, then hunt for regressions, security issues and sloppy code. |
| 🧪 **QA** | Write unit tests, run the full suite, and actually exercise the feature. |

Works in **Claude Code**, **Cursor** and **OpenAI Codex**. It uses subagents where the tool supports them and falls back to sequential role-switching where it doesn't.

---

## How it works

```
Request → Acceptance criteria → Size (S/M/L) → Plan work packages
   → Build (devs) → Review gate (max 3 rounds) → QA gate (max 3 rounds)
   → Sign-off checklist → Final report
```

**Team size scales with complexity** (`references/complexity-rubric.md`):

| Tier | Team | Typical task |
|---|---|---|
| S | 1 dev + 1 reviewer (does QA too) | Bug fix, small tweak |
| M | 1 dev + 1 reviewer + 1 QA | A feature in one area |
| L | 2–3 devs + 2 reviewers + 1–2 QA | Cross-layer feature, payments, migrations |

**Guardrails built in:**
- Acceptance criteria are the contract; nothing ships without evidence for each one
- File ownership, so parallel devs don't collide
- Review/QA loops capped at 3 rounds, then escalation to you
- Never weakens or skips existing tests to get green
- Stops and asks before irreversible actions (migrations, deletes, force-pushes, public API changes)

---

## Install

### Option A: one-liner script
```bash
git clone git@github.com:Propelius-Technologies/eng-squad.git
cd eng-squad
./install.sh            # installs globally for Claude Code, Cursor and Codex
./install.sh --project /path/to/repo   # or into one repo instead
```

### Option B: manual
Copy the `skills/eng-squad/` folder to the location your tool reads:

| Tool | Global (all projects) | Per project (commit with repo) |
|---|---|---|
| **Claude Code** | `~/.claude/skills/eng-squad/` | `.claude/skills/eng-squad/` |
| **Cursor** | `~/.cursor/skills/eng-squad/` or `~/.agents/skills/eng-squad/` | `.cursor/skills/eng-squad/` or `.agents/skills/eng-squad/` |
| **Codex** | `~/.codex/skills/eng-squad/` | `.codex/skills/eng-squad/` |

> 💡 Cursor also reads `.claude/skills/` and `.codex/skills/`, so if you already install for Claude Code or Codex, Cursor picks it up for free.

Restart the tool after installing.

---

## Use

The agent picks the skill up automatically for meaty coding tasks. To force it:

- **Claude Code / Cursor:** `/eng-squad add rate limiting to the login endpoint`
- **Codex:** `$eng-squad add rate limiting to the login endpoint`

Override the team size if you want: `/eng-squad (tier L) migrate users table to UUIDs`

---

## ⚠️ Honest caveats
- **Token cost:** tier M/L uses several agents, roughly 3–6x a single agent. Don't use it for typos.
- **Manual QA needs a runnable environment.** No dev server or browser tool means QA reports what it couldn't test instead of faking it.
- **Subagent support varies by tool.** In single-agent mode the roles run sequentially; independence is weaker, but the gates still apply.

---

## Repo structure
```
skills/eng-squad/
├── SKILL.md                      # Orchestrator playbook (entry point)
└── references/
    ├── complexity-rubric.md      # S/M/L sizing
    ├── developer.md
    ├── reviewer.md
    ├── qa.md
    └── handoff-templates.md      # briefs + reports between agents
```

## Customise
- Tweak coverage targets in `qa.md`
- Add your team's standards (style guide, banned patterns) to `reviewer.md`
- Adjust tier thresholds in `complexity-rubric.md`

## License
MIT
