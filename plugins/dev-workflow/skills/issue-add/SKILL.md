---
name: issue-add
description: Quickly create a GitHub Issue. No PRD changes - just a simple task entry.
argument-hint: [priority] [phase] <task description>
allowed-tools: Read, Bash
---

# Issue Add

## Overview

Quick way to add a single GitHub Issue for bugs, improvements, or ad-hoc work.

## When to Use

- Bug fixes
- Small improvements
- Ad-hoc work
- Quick tasks that don't need PRD tracking

## Arguments

```
/issue-add [priority] [phase] <task description>
```

- **priority** (optional): `P0`, `P1`, `P2`, `urgent`, `important`
- **phase** (optional): `MVP`, `V1`, `V2`
- **task description** (required): What needs to be done

## Examples

```
/issue-add fix dark mode button position
/issue-add P1 refactor auth service
/issue-add P0 MVP fix login crash on Safari
/issue-add urgent: API returns 500 on empty input
```

## Instructions

### 1. Parse Arguments

Extract from `$ARGUMENTS`:
- Priority: P0/P1/P2 or "urgent"→P0, "important"→P1
- Phase: MVP/V1/V2 (for milestone)
- Description: everything else

Default: P1, no milestone

### 2. Create Issue

```bash
gh issue create \
  --title "[Task] <description>" \
  --body "## Context
Quick task added via /issue-add.

## Acceptance Criteria
- [ ] Task completed
" \
  --label "priority/p1"
```

With priority and phase:
```bash
gh issue create \
  --title "[Task] Fix login crash" \
  --body "..." \
  --label "priority/p0" \
  --label "phase/mvp" \
  --milestone "MVP"
```

### 3. Output

```
Created issue #16: Fix login crash on Safari
Labels: priority/p0, phase/mvp
Milestone: MVP
URL: https://github.com/owner/repo/issues/16
```

---

## Examples

```
User: /issue-add fix navbar z-index

Claude: Created issue #17: fix navbar z-index
        Labels: priority/p1
        URL: https://github.com/mpusio/trustleverage-app/issues/17
```

```
User: /issue-add P0 MVP: fix API timeout

Claude: Created issue #18: fix API timeout
        Labels: priority/p0, phase/mvp
        Milestone: MVP
        URL: https://github.com/mpusio/trustleverage-app/issues/18
```

---

## Notes

- For features needing PRD tracking, use `/prd-evolve` instead
- Default priority is P1
- Tasks without phase have no milestone
