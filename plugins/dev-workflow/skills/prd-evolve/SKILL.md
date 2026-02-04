---
name: prd-evolve
description: Update PRD when requirements change. Only modifies docs/specs/ - no task management.
allowed-tools: Read, Glob, Edit, Write
---

# PRD Evolve

## Overview

Updates the PRD (docs/specs/) when requirements change. Focuses only on specification - task management is handled separately.

## When to Use

- Requirements changed
- Adding/removing/modifying features
- Changing priorities or phases
- Architecture updates
- User says "update PRD", "add feature", "change specs"

## Instructions

### 1. Load Current State

Read existing documents:

```bash
# Required
cat docs/specs/README.md
cat docs/specs/features.md
cat docs/specs/roadmap.md

# If needed
cat docs/specs/architecture.md
cat docs/specs/tech-stack.md
```

If `docs/specs/` doesn't exist:
```
No PRD found. Run /prd-compile first.
```

### 2. Ask What Changed

```
What do you want to change in the PRD?
```

Wait for response.

### 3. Clarify if Needed

**Simple changes** - proceed directly:
- Adding a small feature
- Removing something
- Changing priority/phase

**Complex changes** - ask 1-2 questions:
- New major feature → "What's the priority? How does it interact with X?"
- Architecture change → "Does this replace X or work alongside it?"

### 4. Update docs/specs/

Make targeted updates to relevant files:

**features.md:**
- Add/remove/modify features
- Update requirements table

**roadmap.md:**
- Move features between phases
- Add to MVP/V1/V2/Later/Never

**architecture.md:**
- Component changes
- Data model updates

**tech-stack.md:**
- New dependencies
- Technology changes

**README.md:**
- Update summary if scope changed significantly

### 5. Output Summary

```
Updated PRD:

features.md:
- Added: Dark Mode (P1)
- Changed: Auth priority P1 → P0

roadmap.md:
- Moved Dark Mode to V1

Run /issues-sync or /issues-sync to update issues.
```

---

## Examples

### Simple Addition

```
User: /prd-evolve

Claude: [Reads docs/specs/]
        What do you want to change in the PRD?

User: Add dark mode support

Claude: Updated PRD:

        features.md:
        - Added: Dark Mode (P1) - system preference with manual override

        roadmap.md:
        - Added to V1

        Run /issues-sync to generate issues for this feature.
```

### Removal

```
User: /prd-evolve

Claude: What do you want to change in the PRD?

User: Remove analytics, we don't need it

Claude: Updated PRD:

        features.md:
        - Removed: Analytics Dashboard

        roadmap.md:
        - Removed from V2

        tech-stack.md:
        - Removed: Mixpanel

        Run /issues-sync to clean up related issues.
```

### Priority Change

```
User: /prd-evolve

Claude: What do you want to change in the PRD?

User: Auth should be P0, not P1

Claude: Updated PRD:

        features.md:
        - Changed: Authentication P1 → P0

        roadmap.md:
        - Moved Authentication from V1 to MVP
```

---

## Notes

- Only modifies docs/specs/ - no task/issue management
- Trust the user - if they called /prd-evolve, they want to change the PRD
- Keep changes minimal - update only what's needed
- Point out conflicts with existing specs if found
- Suggest /issues-sync or /issues-sync at the end for task updates
