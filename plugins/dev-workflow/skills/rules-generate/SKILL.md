---
name: rules-generate
description: Generate minimalist coding rules based on project tech stack. Reads docs/specs/tech-stack.md and fetches best practices from Context7.
argument-hint: [--tech=next,fastify]
allowed-tools: Read, Glob, Write, mcp__plugin_context7_context7__resolve-library-id, mcp__plugin_context7_context7__query-docs
---

# Rules Generate

## Overview

Generates minimalist coding rules for each technology in the project. Uses Context7 to fetch up-to-date best practices and conventions.

## When to Use

- After `/prd-compile` creates tech-stack.md
- When adding new technology to the project
- When rules feel outdated

## Instructions

### 1. Read Tech Stack

Primary source:
```
docs/specs/tech-stack.md
```

Extract technologies from the Overview table and sections (Frontend, Backend, Database, etc.).

If `docs/specs/tech-stack.md` doesn't exist:
```
No tech stack found. Run /prd-compile first or specify --tech=next,fastify
```

### 2. Fetch Best Practices

For each technology:

1. `resolve-library-id` with query "[technology] best practices conventions"
2. `query-docs` for:
   - Recommended patterns
   - Anti-patterns / common mistakes
   - Performance considerations
   - Security considerations (if applicable)

### 3. Generate Rules

Use this style (like behavior.md):
- Short, actionable bullets
- No fluff, no obvious things
- Group by concern (not by feature)
- Include "Common Mistakes" section
- Max 30 lines per file

Template:
```markdown
# [Technology]

## [Concern 1]

- Rule 1
- Rule 2

## [Concern 2]

- Rule 1
- Rule 2

## Common Mistakes

- Don't X
- Don't Y
```

### 4. Write Files

Create `.claude/rules/{technology}.md` for each.

Use kebab-case for filenames:
- Next.js → `next.md`
- Drizzle ORM → `drizzle.md`
- PostgreSQL → `postgresql.md`

### 5. Update CLAUDE.md

Add new rules to the Rules section in CLAUDE.md if not already listed.

### 6. Output

```
Generated rules:

.claude/rules/
  next.md       (X rules)
  fastify.md    (X rules)
  drizzle.md    (X rules)

Added to CLAUDE.md rules list.

Review and adjust as needed.
```

---

## Arguments

- `--tech=next,fastify` — Generate only for specified technologies (skip detection)

---

## Example

```
User: /rules-generate

Claude: Reading docs/specs/tech-stack.md...

        Found technologies:
        - Next.js 14+ (Frontend)
        - Fastify (Backend)
        - PostgreSQL + TimescaleDB (Database)
        - Drizzle (ORM)

        Fetching best practices...
        ✓ Next.js
        ✓ Fastify
        ✓ PostgreSQL
        ✓ Drizzle

        Generated rules:

        .claude/rules/
          next.md       (15 rules)
          fastify.md    (12 rules)
          postgresql.md (8 rules)
          drizzle.md    (10 rules)

        Review and adjust as needed.
```

---

## Notes

- Rules should be minimalist - quality over quantity
- Skip technologies that don't need rules (e.g., utility libs like lodash)
- Focus on project-relevant patterns, not entire framework docs
- If Context7 returns too much, filter for conventions/patterns only
