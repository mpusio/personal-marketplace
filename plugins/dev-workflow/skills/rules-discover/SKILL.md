---
name: rules-discover
description: Interactive session to discover project-specific rules. Asks about non-standard decisions and gotchas that Claude wouldn't guess from code alone.
disable-model-invocation: true
allowed-tools: Read, Glob, Write
---

# Rules Discover

## Overview

You are a senior developer helping to document project-specific rules. Your goal is to uncover decisions and constraints that differ from standard practice - things you'd get wrong without being explicitly told.

## Core Principle

For each rule, ask: **"Would removing this cause Claude to make mistakes?"**

If Claude would do it correctly anyway → don't include it.

## Instructions

### 1. Load Context

Before starting the interview:

1. **Check specs** (if `docs/specs/` exists) - read for project context and decisions
2. **Check existing rules** (`.claude/rules/`) - to avoid duplicating
3. **Check structure** (`ls` root) - to understand what type of project this is

Don't read the actual code - it's too large and shows implementation, not decisions.

### 2. Start the Session

```
I'll help you create project-specific rules - only things I'd get wrong without being told.

What's something in this project that works differently than you'd expect? A decision that isn't obvious, a gotcha, or a constraint I wouldn't guess from reading the code?
```

### 3. Conduct the Interview

**CRITICAL RULES:**
- Ask ONE question at a time
- Don't assume project structure - let user reveal what's relevant
- Focus on: "What would Claude do wrong without knowing this?"
- Skip standard practices

**After each answer:**
- If reveals something non-standard → capture it, ask "Anything else like this?"
- If "nothing special" → ask about different area: "Any gotchas or things that behave unexpectedly?"
- If detailed → "Got it. What else would cause mistakes?"

**Good follow-up questions:**
- "What else would trip me up?"
- "Any decisions that differ from standard practice?"
- "What's a mistake someone new to this codebase would make?"
- "Anything that looks normal but has hidden rules?"

**Stop asking about a topic when:**
- User says "standard" / "nothing special" / "that's it"
- User moves to different topic

### 4. Recognize When to End

End when:
- User signals completion
- Answers become "nothing else"
- You have 3-10 solid rules

Final check:
```
Anything else that would cause me to make mistakes if I didn't know it?
```

### 5. Compile Rules

Generate rules file:

```markdown
# [Project Name] Rules

## [Category derived from answers]

- Specific rule
- Another rule
```

**Constraints:**
- Max 30 lines total
- Only include what passed "would cause mistakes" test
- Group by theme that emerged from conversation
- No explanations unless critical

### 6. Present and Save

```
Here are the rules based on our conversation:

[show rules]

Want me to save this to `.claude/rules/project.md`?
```

### 7. Consolidate Existing Rules

If existing rules files (from step 1) overlap with new `project.md`:

1. List which files have redundant/overlapping content
2. Suggest what can be removed or merged
3. Ask user if they want to consolidate

```
I noticed some overlap with existing rules:
- `api-patterns.md` covers response format (now in project.md)
- `security.md` has validation rules (duplicated)

Want me to consolidate these into project.md and remove the redundant files?
```

---

## Example Session

```
User: /rules-discover

Claude: [reads specs, checks existing rules, checks structure]

I'll help you create project-specific rules - only things I'd get wrong without being told.

What's something in this project that works differently than you'd expect?

User: We wrap all API responses in { success, data } format

Claude: Got it - I'd need to know that. What else would trip me up?

User: The trades table is actually a TimescaleDB hypertable, queries need time column

Claude: Database gotcha, noted. Any other hidden rules like this?

User: API keys must be validated as read-only before storing, not after

Claude: Order of operations constraint. What else would cause mistakes?

User: Open positions have 30min delay, they're not real-time

Claude: Business rule I wouldn't guess. Anything else?

User: That's the main stuff

Claude: Here are your rules:

# TrustLeverage Rules

## API
- All responses: `{ success, data }` or `{ success, error }`

## Database
- `trades` is hypertable - include `time` in queries

## Security
- Validate API keys read-only BEFORE storing

## Privacy
- Open positions: 30min delay, not real-time

Save to `.claude/rules/project.md`?
```

---

## What to Skip

Don't capture if user says:
- "Standard practice"
- "Just like normal"
- "Nothing special"
- Things enforced by linting/tooling
- Framework conventions from docs
