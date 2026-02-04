---
name: issues-sync
description: Sync GitHub Issues with PRD. Creates missing, updates existing. Use --force to recreate all.
argument-hint: [--force | --dry-run]
allowed-tools: Read, Glob, Bash
---

# Issues Sync

## Overview

Synchronizes GitHub Issues with PRD (docs/specs/). Creates missing issues and updates existing ones to match current specs.

## Arguments

- (none) - Sync mode: create missing + update existing
- `--force` - Close all issues and recreate from scratch
- `--dry-run` - Preview changes without applying

## When to Use

- After `/prd-compile` - initial issue generation
- After `/prd-evolve` - sync changes to issues
- Periodic check if issues match specs

## Instructions

### 1. Read PRD

```bash
cat docs/specs/features.md   # Features with priorities
cat docs/specs/roadmap.md    # Phases (MVP/V1/V2)
```

Extract:
- Features with priorities (P0, P1, P2)
- Phases (MVP, V1, V2)
- Dependencies

### 2. Fetch Existing Issues

```bash
gh issue list --state open --json number,title,body,labels,milestone --limit 500
```

### 3. Match Issues to Specs

Match by spec marker in issue body:

```markdown
<!-- spec:feature-id -->
```

Or fallback to title matching: `[Phase] Feature name`

Build comparison:

```
Feature           | Issue | Priority | Phase | Status
------------------|-------|----------|-------|--------
Monorepo Setup    | #1    | P0 = P0  | MVP   | ✓ match
Authentication    | #5    | P1 → P0  | MVP   | ⚠ update
Dark Mode         | -     | P1       | V1    | + create
Analytics         | #12   | -        | -     | orphaned
```

### 4. Execute Sync

**Create missing:**
```bash
gh issue create \
  --title "[Feature] Dark Mode" \
  --body "$(cat <<'EOF'
<!-- spec:dark-mode -->
## Context
...
EOF
)" \
  --label "priority/p1" \
  --label "phase/v1" \
  --milestone "V1"
```

**Update existing:**
```bash
# Update labels
gh issue edit 5 --remove-label "priority/p1" --add-label "priority/p0"

# Update milestone
gh issue edit 5 --milestone "MVP"
```

**Orphaned:** Report only, don't close.

### 5. Output

```
Syncing issues with PRD...

Created (2):
  #18 [Feature] Dark Mode (P1, V1)
  #19 [Feature] Export PDF (P2, V2)

Updated (1):
  #5 Authentication: priority P1 → P0, milestone V1 → MVP

Unchanged (9):
  #1, #2, #3, #4, #6, #7, #8, #9, #10

Orphaned (1):
  #12 Analytics Dashboard - not in specs (close manually?)

Summary: 2 created, 1 updated, 9 unchanged, 1 orphaned
```

---

## Issue Format

**Title:** `[Phase] Feature name`

**Body:**
```markdown
<!-- spec:feature-id -->
## Context
[What and why]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Dependencies
Blocked by: #X (or "None")
```

**Labels:** `priority/p0`, `phase/mvp`
**Milestone:** MVP, V1, V2

---

## Force Mode

```
User: /issues-sync --force

Claude: Force recreating all issues...

        Closed 12 existing issues.
        Created 14 issues from PRD.

        MVP: #21-#28 (8 issues)
        V1: #29-#32 (4 issues)
        V2: #33-#34 (2 issues)
```

## Dry Run

```
User: /issues-sync --dry-run

Claude: Dry run - no changes made.

        Would create (2):
          - Dark Mode (P1, V1)
          - Export PDF (P2, V2)

        Would update (1):
          - #5 Authentication: P1 → P0

        Orphaned (1):
          - #12 Analytics Dashboard

        Run without --dry-run to apply.
```

---

## Examples

### Initial generation

```
User: /issues-sync

Claude: No existing issues found. Creating from PRD...

        Created 12 issues:

        MVP (8):
          #1 [Setup] Initialize monorepo - P0
          #2 [Setup] Configure environment - P0
          ...

        V1 (4):
          #9 [Feature] Solana wallet - P1
          ...

        View: https://github.com/mpusio/trustleverage-app/milestones
```

### After prd-evolve

```
User: /issues-sync

Claude: Syncing issues with PRD...

        Created (1):
          #18 [Feature] Dark Mode (P1, V1)

        Updated (1):
          #5 Authentication: priority P1 → P0

        Orphaned (1):
          #12 Analytics - close with: gh issue close 12

        Summary: 1 created, 1 updated, 10 unchanged, 1 orphaned
```

---

## Notes

- Spec marker `<!-- spec:id -->` enables precise matching
- Without marker, falls back to title matching (less reliable)
- Orphaned = reported, not auto-closed (safety)
- Closed issues are skipped (work already done)
- --force is destructive - use sparingly
