---
name: init
description: "Initialize a new project-level .codex/config.toml with documentation about the codebase. Scans the project structure, identifies frameworks, and creates appropriate configuration."
---

## Workflow

1. Scan project structure (package.json, tsconfig, frameworks)
2. Identify:
   - Language and runtime (Node.js, Python, Go, etc.)
   - Framework (Next.js, Express, FastAPI, etc.)
   - Package manager (npm, pnpm, yarn, bun)
   - Test framework (Jest, Vitest, Playwright)
   - Linter/formatter (ESLint, Prettier, Biome)
   - Database (PostgreSQL, MongoDB, etc.)
3. Create `.codex/config.toml` with:
   - Appropriate sandbox mode
   - Relevant model instructions
4. Create `.codex/instructions.md` with:
   - Project overview
   - Architecture summary
   - Development commands
   - Key patterns and conventions
   - Testing strategy

## Output

- `.codex/config.toml` — Project-level config
- `.codex/instructions.md` — Project-specific instructions
