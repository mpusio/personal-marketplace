---
name: prd-compile
description: Compile brainstorm findings into modular PRD documents. Reads from docs/brainstorm.md or conversation context and generates structured specs in docs/specs/.
---

# PRD Compile

## Overview

Takes brainstorming output and compiles it into modular, structured Product Requirements Documents. Generates separate focused files instead of one monolithic document.

## Output Structure

```
docs/
  specs/
    README.md          ← index + overview (TL;DR)
    problem.md         ← problem, users, context
    features.md        ← what we're building
    tech-stack.md      ← technology choices
    architecture.md    ← components, flows
    roadmap.md         ← MVP / V1 / V2 / Later / Never
```

## When to Use

- After completing a brainstorm session
- User wants to create/compile a PRD
- User says "compile PRD", "create specs", "generate PRD"

---

## Instructions

### 1. Find Source Material

Check for brainstorm output in this order:

1. **File exists:** Read `docs/brainstorm.md`
2. **Recent conversation:** Use brainstorm summary from current conversation
3. **Neither:** Ask user to provide context or run `/prd-brainstorm` first

### 2. Create Directory

```
docs/specs/
```

### 3. Generate Each File

---

#### README.md (Index + Overview)

```markdown
# [Project Name]

> [One-line description]

## TL;DR

[2-3 sentences: What it is, who it's for, why it matters]

## Quick Links

| Doc | Description |
|-----|-------------|
| [Problem](./problem.md) | Problem statement, target users |
| [Features](./features.md) | What we're building |
| [Tech Stack](./tech-stack.md) | Technology choices |
| [Architecture](./architecture.md) | Components, flows |
| [Roadmap](./roadmap.md) | MVP, V1, V2, Later |

## Status

| Field | Value |
|-------|-------|
| Created | YYYY-MM-DD |
| Status | Draft |
| Phase | Planning / MVP / V1 / ... |

## Open Questions

- [ ] [Unresolved question 1]
- [ ] [Unresolved question 2]
```

---

#### problem.md (What & Why)

```markdown
# Problem & Context

## Problem Statement

[What problem exists today]

### Who experiences it?

[Primary users affected]

### Current solutions

[How people solve it today, why it's inadequate]

### Impact

[Consequences of the problem remaining unsolved]

---

## Target Users

### Primary User

- **Who:** [Description]
- **Needs:** [What they need to accomplish]
- **Context:** [When/where they use this]
- **Technical level:** [Novice / Intermediate / Expert]

### Secondary Users (if any)

- **Who:** [Description]
- **Role:** [How they interact with the system]

---

## Goals

### Primary Goal
[Main objective - what success looks like]

### Secondary Goals
- [Supporting objective 1]
- [Supporting objective 2]

### Non-Goals (Explicit)
- [What this project will NOT do]
- [Scope boundaries]

---

## Success Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| [Metric 1] | [Value] | [Method] |
| [Metric 2] | [Value] | [Method] |
```

---

#### features.md (What We're Building)

```markdown
# Features

## Overview

[Brief description of the product's capabilities]

---

## Feature List

### [Feature 1 Name]

- **Description:** [What it does]
- **User story:** As a [user], I want to [action] so that [benefit]
- **Priority:** P0 / P1 / P2
- **Phase:** MVP / V1 / V2 / Later

**Acceptance criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

---

### [Feature 2 Name]

- **Description:** [What it does]
- **User story:** As a [user], I want to [action] so that [benefit]
- **Priority:** P0 / P1 / P2
- **Phase:** MVP / V1 / V2 / Later

**Acceptance criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

---

[Continue for each feature]

---

## Requirements Summary

### Functional Requirements

| ID | Requirement | Priority | Phase |
|----|-------------|----------|-------|
| FR-1 | [Requirement] | P0 | MVP |
| FR-2 | [Requirement] | P0 | MVP |
| FR-3 | [Requirement] | P1 | V1 |

### Non-Functional Requirements

- **Performance:** [Requirements]
- **Security:** [Requirements]
- **Scalability:** [Requirements]
- **Reliability:** [Requirements]
```

---

#### tech-stack.md (How - Technology)

```markdown
# Tech Stack

## Overview

| Layer | Technology | Reasoning |
|-------|------------|-----------|
| Frontend | [e.g., Next.js] | [Why] |
| Backend | [e.g., Fastify] | [Why] |
| Database | [e.g., PostgreSQL] | [Why] |
| Hosting | [e.g., Vercel] | [Why] |

---

## Frontend

- **Framework:** [e.g., Next.js 14+]
- **Language:** [e.g., TypeScript]
- **Styling:** [e.g., Tailwind CSS]
- **State management:** [e.g., React Context / Zustand]

**Reasoning:** [Why these choices]

---

## Backend

- **Framework:** [e.g., Fastify]
- **Language:** [e.g., TypeScript]
- **API style:** [REST / GraphQL / tRPC]

**Reasoning:** [Why these choices]

---

## Database

- **Primary:** [e.g., PostgreSQL]
- **Extensions:** [e.g., TimescaleDB]
- **ORM:** [e.g., Drizzle / Prisma]

**Reasoning:** [Why these choices]

---

## Infrastructure

- **Frontend hosting:** [e.g., Vercel]
- **Backend hosting:** [e.g., Railway]
- **Other services:** [e.g., Redis, S3, queues]

---

## External Integrations

| Service | Purpose | Required Phase |
|---------|---------|----------------|
| [Service 1] | [What for] | MVP / V1 |
| [Service 2] | [What for] | V1 |

---

## Development Tools

- **Package manager:** [e.g., pnpm]
- **Monorepo:** [e.g., pnpm workspaces]
- **Testing:** [e.g., Vitest]
- **Linting:** [e.g., ESLint + Prettier]
```

---

#### architecture.md (How - Structure)

```markdown
# Architecture

## High-Level Overview

```
[ASCII diagram or description]

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────▶│   API       │────▶│  Database   │
│  (Next.js)  │     │  (Fastify)  │     │ (PostgreSQL)│
└─────────────┘     └─────────────┘     └─────────────┘
```

---

## Components

| Component | Responsibility | Dependencies |
|-----------|----------------|--------------|
| [Component 1] | [What it does] | [What it needs] |
| [Component 2] | [What it does] | [What it needs] |

---

## Data Flow

### Main User Flow

1. [Step 1: User action]
2. [Step 2: System response]
3. [Step 3: Next action]

### Alternative Flows

- **[Scenario A]:** [How it differs]
- **[Scenario B]:** [How it differs]

---

## Data Models (Core)

### [Model 1]

```
[Model Name]
├── id: UUID
├── created_at: Timestamp
├── [field]: [type]
└── [field]: [type]
```

### [Model 2]

```
[Model Name]
├── id: UUID
└── [fields...]
```

---

## API Endpoints (Core)

| Method | Endpoint | Description | Phase |
|--------|----------|-------------|-------|
| GET | /api/[resource] | [What it does] | MVP |
| POST | /api/[resource] | [What it does] | MVP |

---

## Error Handling

- **[Error case]:** [How system responds]
- **[Error case]:** [How system responds]

---

## Security Considerations

- [Security measure 1]
- [Security measure 2]
```

---

#### roadmap.md (When)

```markdown
# Roadmap

## Overview

| Phase | Focus | Status |
|-------|-------|--------|
| MVP | [Core value] | Planning / In Progress / Done |
| V1 | [Enhanced] | Planning |
| V2 | [Expanded] | Future |
| Later | [Nice-to-have] | Backlog |

---

## MVP (Minimum Viable Product)

**Goal:** [What MVP achieves - core value proposition]

**Timeline:** [If known]

### Features
- [ ] [Feature 1] - P0
- [ ] [Feature 2] - P0
- [ ] [Feature 3] - P0

### Success Criteria
- [What makes MVP "done"]

---

## V1 (First Full Release)

**Goal:** [What V1 adds beyond MVP]

### Features
- [ ] [Feature 4] - P1
- [ ] [Feature 5] - P1
- [ ] [Enhancement to MVP feature]

### Depends on
- MVP complete
- [Other dependencies]

---

## V2 (Enhanced)

**Goal:** [What V2 adds]

### Features
- [ ] [Feature 6] - P1/P2
- [ ] [Feature 7] - P2

---

## Later (Backlog)

Ideas for future consideration:

- [Idea 1]
- [Idea 2]
- [Idea 3]

---

## Never (Explicit Non-Goals)

Things we've decided NOT to build:

- [Non-goal 1] — Reason: [why]
- [Non-goal 2] — Reason: [why]

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Strategy] |
| [Risk 2] | High/Med/Low | High/Med/Low | [Strategy] |
```

---

### 4. Prioritization Guide

Use for assigning priorities:

- **P0 (Must Have):** Core functionality, blocks launch without it
- **P1 (Should Have):** Important, valuable, but MVP can work without it
- **P2 (Nice to Have):** Enhancements, polish, can be added later

### 5. Phase Guide

- **MVP:** Minimum to validate core value
- **V1:** First "complete" release
- **V2:** Major enhancements
- **Later:** Good ideas, no commitment
- **Never:** Explicit exclusions (important to document!)

### 6. Adapt to Project Size

**Small project / quick MVP:**
- Simplify architecture.md (or skip)
- Combine problem.md content into README.md
- Focus on features.md + roadmap.md

**Large project:**
- Expand architecture.md with detailed diagrams
- Add separate files for API specs, data models
- Consider adding decisions.md for ADRs

### 7. Confirm with User

After generating:

```
PRD created in docs/specs/

Files generated:
- README.md (overview + index)
- problem.md (problem, users, goals)
- features.md (what we're building)
- tech-stack.md (technology choices)
- architecture.md (components, flows)
- roadmap.md (MVP / V1 / V2 / Later / Never)

Next steps:
- Review and adjust each file
- Run /issues-sync to generate implementation tasks
```

---

## Example

```
User: /prd-compile

Claude: [Reads docs/brainstorm.md]
        [Creates docs/specs/ directory]
        [Generates all 6 files]

        PRD created in docs/specs/

        Files generated:
        - README.md (overview)
        - problem.md (problem, users, goals)
        - features.md (5 features documented)
        - tech-stack.md (Next.js + Fastify + PostgreSQL)
        - architecture.md (3 components)
        - roadmap.md (MVP: 3 features, V1: 2 features)

        Next: Review files, then /issues-sync for implementation tasks.
```

---

## Notes

- Each file is self-contained and focused
- README.md serves as entry point and quick reference
- Roadmap.md includes explicit "Never" section - important for scope
- Files link to each other where relevant
- If information is missing, mark as [TBD] and note in README's Open Questions
