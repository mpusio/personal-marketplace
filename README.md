# Personal Marketplace

Claude Code plugins and templates for development workflow automation.

## Installation

```bash
# Add marketplace
/plugin marketplace add mpusio/personal-marketplace

# Install plugin
/plugin install dev-workflow@personal-marketplace
```

## Plugins

### dev-workflow

Complete development workflow: PRD management, GitHub Issues sync, and session learning.

**Skills:**

| Skill | Description |
|-------|-------------|
| `/prd-brainstorm` | Interactive idea exploration |
| `/prd-compile` | Generate PRD from brainstorm |
| `/prd-evolve` | Update specs when requirements change |
| `/issues-sync` | Sync GitHub Issues with PRD |
| `/issues-status` | Show project progress |
| `/issue-add` | Quick issue creation |
| `/rules-tech` | Generate coding rules from tech stack (via Context7) |
| `/rules-discover` | Interactive session to discover project-specific rules |
| `/learn` | Capture session insights |
| `/autonomous-execution` | Execute tasks from GitHub Issues autonomously |

**Hooks:**

- `PreCompact` - Reminds to run `/learn` before context compaction

---

### notify

Windows desktop notifications when Claude Code needs attention.

---

### conversation-search

Search past Claude Code conversations for solutions and context.

---

## Templates

Starter files for new projects. Copy to your project and customize.

| File | Purpose |
|------|---------|
| `templates/CLAUDE.md.example` | Project instructions template |
| `templates/config.json.example` | Claude config with hooks and GitHub Issues |
| `templates/rules/behavior.md` | Universal thinking guidelines (copy as-is) |
| `templates/rules/git.md` | Git conventions (copy as-is) |

### Quick Start

```bash
# Copy templates to new project
cp templates/CLAUDE.md.example ./CLAUDE.md
mkdir -p .claude/rules
cp templates/config.json.example .claude/config.json
cp templates/rules/behavior.md .claude/rules/
cp templates/rules/git.md .claude/rules/
```

---

## Resources

Learn more about Claude Code:

- [Official Documentation](https://code.claude.com/docs)
- [r/ClaudeCode](https://www.reddit.com/r/ClaudeCode/) - Reddit community
- [Claude Code Tips Thread](https://x.com/DBVolkov/status/2018692707955466282) - Tips from DBVolkov
- [Awesome Claude](https://awesomeclaude.ai/) - Curated resources
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) - Comprehensive collection
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Another great collection

---

## License

MIT
