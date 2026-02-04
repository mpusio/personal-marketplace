---
name: prd-brainstorm
description: Interactive brainstorming session to explore and define a project idea before creating a PRD. Asks one question at a time, goes deeper on important details. Use when user wants to brainstorm, explore an idea, or prepare for PRD creation.
---

# PRD Brainstorm

## Overview

Conducts an interactive Q&A session to help the user fully explore and define their project idea. Asks focused questions one at a time, building on previous answers to uncover requirements, constraints, and details needed for a comprehensive PRD.

## When to Use

- User wants to brainstorm a project idea
- User has a vague concept that needs refinement
- Preparing before creating a PRD
- User mentions "brainstorm", "explore idea", "let's think through"

## Instructions

### 1. Start the Session

Ask the user to describe their idea:

```
What's your project idea? Describe it in a few sentences - what problem does it solve, who is it for?
```

If the user already provided the idea in their message, skip this and proceed to questioning.

### 2. Conduct the Interview

**CRITICAL RULES:**
- Ask ONE question at a time - never multiple questions in one message
- Wait for the user's response before asking the next question
- Each question must build on previous answers
- Go deeper on vague or important areas
- Keep questions concise and focused

**Question Flow:**

Start broad, then narrow down:

1. **Problem & Value** (2-3 questions)
   - What specific problem does this solve?
   - Who experiences this problem most?
   - How do they solve it today?

2. **Users & Audience** (2-3 questions)
   - Who is the primary user?
   - Are there secondary users or stakeholders?
   - What's their technical level?

3. **Core Functionality** (3-5 questions)
   - What's the ONE main thing it must do?
   - What happens in the typical user flow?
   - What are must-have vs nice-to-have features?

4. **Technical Context** (4-6 questions)
   - Where will it run? (web, mobile, desktop, CLI, backend service, etc.)
   - Any preferred programming language? Why?
   - Any preferred frameworks or libraries? (React, Next.js, FastAPI, etc.)
   - What about database? (PostgreSQL, MongoDB, SQLite, none, etc.)
   - Does it need to integrate with external services/APIs?
   - Any infrastructure preferences? (cloud provider, self-hosted, serverless, etc.)
   - Are there any technologies you want to AVOID?

5. **Scope & Constraints** (2-3 questions)
   - What's the timeline or urgency?
   - Any budget or resource constraints?
   - What's explicitly OUT of scope?

**Adaptive Questioning:**

- If answer is vague: "Can you give me a specific example?"
- If answer reveals complexity: "Let's break that down - what's the first part?"
- If answer mentions something new: "You mentioned X - tell me more about that"
- If answer is very detailed: Move to next topic area

### 3. Recognize When to End

End the session when:
- All major areas have been covered
- User signals they want to wrap up ("that's it", "I think that covers it")
- Answers are becoming repetitive
- You have enough detail to create a meaningful PRD

To check if ready to end:
```
I think I have a good picture now. Is there anything else important about [project] that we haven't covered?
```

### 4. Compile Summary

When the session ends, provide a structured summary:

```markdown
## Brainstorm Summary: [Project Name]

### Problem
[What problem it solves, who has it, current solutions]

### Target Users
[Primary and secondary users, their context]

### Core Concept
[The main idea in 2-3 sentences]

### Key Features
- [Feature 1]
- [Feature 2]
- [Feature 3]

### Tech Stack
- **Platform:** [web/mobile/desktop/CLI/etc.]
- **Language:** [preferred language]
- **Framework:** [if any]
- **Database:** [if any]
- **Infrastructure:** [cloud/self-hosted/serverless]
- **Integrations:** [external APIs/services]

### Scope
- **In scope:** [what's included]
- **Out of scope:** [what's explicitly excluded]

### Open Questions
- [Any unresolved decisions]

---

Ready to create the PRD? Run `/prd-compile` with this context.
```

### 5. Save Option

Ask if user wants to save the summary:

```
Want me to save this summary to `docs/brainstorm.md`?
```

If yes, create the file.

---

## Example Session

```
User: /prd-brainstorm

Claude: What's your project idea? Describe it in a few sentences.

User: I want to build a CLI tool that helps developers manage their dotfiles

Claude: What specific pain point does this solve? What's frustrating about managing dotfiles today?

User: It's hard to keep them in sync across multiple machines, and setting up a new machine takes forever

Claude: When you set up a new machine, what takes the most time - installing the dotfiles themselves, or the tools/software they depend on?

User: Both really, but mostly remembering which dotfiles I need and where they go

Claude: Got it. Would this tool mainly help with the initial setup of a new machine, or also with keeping machines in sync over time?

[...continues until sufficient detail is gathered...]

Claude: ## Brainstorm Summary: Dotfiles Manager CLI
...
```

## Tips

- Don't interrogate - keep it conversational
- Acknowledge good answers briefly before asking next question
- If user seems uncertain, offer examples or options
- It's okay to suggest ideas, but don't assume - ask
- 10-15 questions is usually enough for a solid foundation
