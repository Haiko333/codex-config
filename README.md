# codex-config

Production-ready configuration for [OpenAI Codex CLI](https://github.com/openai/codex) — 33 custom skills, security hooks, and opinionated instructions for professional software development.

## What's Included

```
~/.codex/
├── config.toml              # Main configuration (model, hooks, agents, features)
├── instructions.md          # Global coding standards & rules
├── install.sh               # One-command installer
├── scripts/
│   └── command-validator/
│       └── validate.sh      # PreToolUse security hook
└── skills/                  # 33 custom skills
    ├── code-reviewer/       # Expert code review
    ├── security-reviewer/   # OWASP Top 10 detection
    ├── typescript-reviewer/ # TS type safety & patterns
    ├── build-error-resolver/# Fix build errors fast
    ├── database-reviewer/   # PostgreSQL optimization
    ├── apex/                # APEX methodology workflow
    ├── tdd-workflow/        # Test-driven development
    ├── commit/              # Conventional commits
    ├── create-pr/           # Auto-generated PR descriptions
    └── ... (24 more)
```

## Quick Install

```bash
git clone https://github.com/h41k0/codex-config.git ~/.codex-config
cd ~/.codex-config
./install.sh
```

The installer will:
1. Backup your existing `config.toml`
2. Install the configuration with paths adjusted to your `$HOME`
3. Copy all skills to `~/.codex/skills/`
4. Set up the security hook

## Skills Overview

### Agents (auto-triggered)

| Skill | Trigger |
|-------|---------|
| `$code-reviewer` | After writing/modifying code |
| `$security-reviewer` | Auth, user input, API endpoints |
| `$typescript-reviewer` | Any TS/JS code changes |
| `$build-error-resolver` | Build fails or type errors |
| `$database-reviewer` | SQL, migrations, schemas |
| `$explore-codebase` | Need to understand code structure |
| `$explore-docs` | Need library documentation |
| `$websearch` | Quick web search |

### Workflows (invoked explicitly)

| Skill | Purpose |
|-------|---------|
| `$apex` | Analyze-Plan-Execute-Validate methodology |
| `$code` | Explore → Plan → Execute → Validate |
| `$oneshot` | Ultra-fast focused implementation |
| `$ultrathink` | Deep thinking for complex problems |
| `$tdd-workflow` | Test-driven development (80%+ coverage) |
| `$ralph-loop` | Autonomous coding loop |

### Git Operations

| Skill | Purpose |
|-------|---------|
| `$commit` | Conventional commit messages |
| `$create-pr` | Auto-generate PR description |
| `$merge` | Context-aware conflict resolution |
| `$fix-pr-comments` | Implement review feedback |
| `$review` | Comprehensive PR review |

### Fix & Cleanup

| Skill | Purpose |
|-------|---------|
| `$fix-errors` | Batch fix ESLint + TypeScript errors |
| `$fix-grammar` | Fix grammar preserving formatting |
| `$simplify` | Review code for reuse and efficiency |

### Design Patterns & Guides

| Skill | Purpose |
|-------|---------|
| `$api-design` | REST API patterns |
| `$backend-patterns` | Node.js architecture |
| `$frontend-patterns` | React/Next.js patterns |
| `$frontend-design` | Production-grade UI design |
| `$deployment-patterns` | CI/CD and Docker |
| `$prompt-creator` | LLM prompt engineering |
| `$openai-api` | OpenAI SDK patterns |
| `$security-review` | Security checklist |

## Security Hook

The `validate.sh` PreToolUse hook provides:
- **BLOCK** (`rm -rf` patterns) — completely denied
- **WARN** (`sudo`, `kill`, `dd`, `mkfs`, `fdisk`, `chmod`, `chown`, `su`, `killall`) — requires approval

## Configuration Highlights

- **Model**: GPT-5.5 with high reasoning effort
- **Sandbox**: workspace-write (safe default)
- **Multi-agent**: 8 concurrent threads, 3 depth max
- **Theme**: Dark
- **Sound**: Notification on session end

## Instructions (Coding Standards)

The `instructions.md` file enforces:
- Immutability (no mutation)
- KISS / DRY / YAGNI principles
- 80%+ test coverage with TDD
- Security-first (OWASP, no hardcoded secrets)
- Conventional commits
- TypeScript best practices (no `any`, Zod validation)
- Code review after every change

## Customization

### Change model
Edit `config.toml`:
```toml
model = "gpt-5.5"
model_reasoning_effort = "high"  # none, low, medium, high, xhigh
```

### Add a new skill
```bash
mkdir -p ~/.codex/skills/my-skill/agents
# Create SKILL.md with frontmatter (name + description) and body
# Create agents/openai.yaml with interface metadata
```

### Disable a skill's auto-trigger
In `agents/openai.yaml`:
```yaml
policy:
  allow_implicit_invocation: false
```

## Credits

Ported from a battle-tested [Claude Code](https://claude.ai/code) configuration with 9 agents, 23 skills, 15 rules, and security hooks. Adapted for Codex CLI's TOML/SKILL.md format.

## License

MIT
