---
name: autonomous-execution
description: Execute tasks autonomously from GitHub Issues. Makes design decisions independently, self-reviews, closes issues on completion.
argument-hint: [milestone=MVP] [issues=1,2,3] [stop-on=error]
allowed-tools: Read, Bash, Write, Edit, Glob, Grep
---

# Autonomous Execution

## Overview

Fire-and-forget mode for executing GitHub Issues. Agent makes all decisions independently, only stopping on errors or phase completion.

## When to Use

- User wants hands-off execution
- Issues are well-defined with clear acceptance criteria
- User trusts agent's design decisions
- Long-running work sessions

## Arguments

- `milestone` (optional): Which milestone (e.g., "MVP")
- `issues` (optional): Specific issue numbers (e.g., "1, 2, 3")
- `stop-on`: "error" (default), "milestone", "all-done"

## Instructions

### 1. Load Context

```bash
# Fetch issues for milestone
gh issue list --milestone MVP --label priority/p0 --state open --json number,title,body

# Or specific issues
gh issue view 1 --json number,title,body
```

Also read:
- `docs/specs/` - requirements for decisions
- `docs/WORKFLOW.md` - process reference

### 2. Build Execution Queue

1. Filter issues by milestone/priority
2. Parse "Blocked by: #X" from body for dependencies
3. Topological sort by dependencies
4. Start with unblocked issues

### 3. Execute Loop

For each issue:

```
┌─────────────────────────────────────────────┐
│ A. Check dependencies (blocking issues closed)
│ B. Log: "Starting: #N [title]"              │
│ C. Design decision (NO user input):         │
│    - Pick simplest approach that works      │
│    - Follow existing patterns in codebase   │
│    - When ambiguous, prefer convention      │
│ D. Implement with TDD (skip if trivial)     │
│ E. Self-verify: tests pass? lint clean?     │
│ F. Self-review: matches spec? no hacks?     │
│ G. Commit (conventional commit message)     │
│ H. Close issue: gh issue close #N           │
│ I. Log: "Completed: #N [title]"             │
│ J. Continue to next issue                   │
└─────────────────────────────────────────────┘
```

### 4. Decision Rules (No User Input)

| Situation | Decision |
|-----------|----------|
| Library choice | Most popular/maintained option |
| Architecture | Match existing patterns |
| Naming | Follow codebase conventions |
| Edge cases | Handle obvious ones, skip exotic |
| Config options | Sensible defaults |
| Tests | Happy path + 1-2 error cases |

### 5. Stop Conditions

**STOP and report if:**
- Test fails and can't fix in 3 attempts
- Dependency not installable
- Spec is genuinely ambiguous
- Would break existing functionality
- Security concern

**DON'T stop for:**
- Design choices
- Library preferences
- Naming decisions
- Test coverage debates

### 6. Progress Reporting

Every 3 issues or 15 minutes:

```
── Autonomous Progress ──────────────────
Completed: 4/12 issues
Current: #5 "Setup database migrations"
Queue: 8 remaining
Errors: 0
─────────────────────────────────────────
```

### 7. Completion

```
── Autonomous Execution Complete ────────
MVP: 12/12 issues ✓
Duration: ~45 min
Commits: 8

Summary:
- Monorepo initialized with pnpm
- Next.js 14 + Fastify setup
- Database schema created

Decisions made:
- Used Drizzle for ORM (simpler than Prisma)
- Chose port 3001 for API (convention)

Review recommended before merge.
─────────────────────────────────────────
```

---

## Example

```
User: /autonomous-execution milestone="MVP"

Claude: Starting autonomous execution of MVP (12 issues)

── Autonomous Progress ──────────────────
Starting: #1 "Initialize monorepo structure"
...
Completed: #1 (3 min)
Starting: #2 "Configure environment" + #3 "Setup database" [parallel]
...
```

---

## Safety Rails

1. **No force push** - ever
2. **No secret commits** - skip .env files
3. **No production deploy** - prep only
4. **Rollback ready** - atomic commits per issue
5. **Audit trail** - log all decisions

---

## Limitations

- Won't resolve genuine spec ambiguity
- Won't make major architecture pivots
- Won't delete user code without backup
- Won't exceed rate limits on external APIs
