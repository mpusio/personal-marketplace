---
name: issues-status
description: Show project progress from GitHub Issues. Shows completion by milestone, priority, and next tasks.
allowed-tools: Read, Bash
---

# Issues Status

## Overview

Quick summary of project progress from GitHub Issues using `gh` CLI.

## When to Use

- Starting a work session - "where was I?"
- Checking overall progress
- Finding what's next
- User asks "project status", "how far along", "what's left"

## Arguments

None. Just run `/issues-status`.

## Instructions

### 1. Fetch Data

```bash
# List all issues with details
gh issue list --state all --json number,title,state,labels,milestone --limit 500

# Get milestone progress
gh api repos/{owner}/{repo}/milestones --jq '.[] | "\(.title): \(.closed_issues)/\(.open_issues + .closed_issues)"'
```

### 2. Parse and Display

```
## Project: TrustLeverage

### Milestones
| Milestone | Done | Open | Progress |
|-----------|------|------|----------|
| MVP       | 3    | 7    | 30%      |
| V1        | 0    | 4    | 0%       |
| V2        | 0    | 1    | 0%       |

### By Priority
| Priority | Done | Open |
|----------|------|------|
| P0       | 3    | 5    |
| P1       | 0    | 5    |
| P2       | 0    | 2    |

### Open (MVP, P0)
- #1 Initialize monorepo
- #3 Setup database
- #5 Exchange verification

### Recently Closed
- #2 Configure environment (2h ago)

---
View: https://github.com/mpusio/trustleverage-app/milestones
```

---

## Example

```
User: /issues-status

Claude: [Fetches via gh cli]

        ## Project: TrustLeverage

        ### Milestones
        | Milestone | Done | Open | Progress |
        |-----------|------|------|----------|
        | MVP       | 0    | 12   | 0%       |
        | V1        | 0    | 4    | 0%       |
        | V2        | 0    | 1    | 0%       |

        ### Open (MVP, P0)
        - #1 Initialize monorepo
        - #3 Setup database

        Start with #1.

        View: https://github.com/mpusio/trustleverage-app/milestones
```

---

## Notes

- Always shows real-time data from GitHub
- Show max 5 items in lists
- Include GitHub links for quick navigation
