# Global Instructions

These instructions apply to ALL sessions. Follow them exactly.

---

## Coding Style

### Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate existing ones. Use spread operators, map, filter — never modify in-place.

### Core Principles

- **KISS**: Prefer the simplest solution that actually works. Optimize for clarity over cleverness.
- **DRY**: Extract repeated logic into shared functions when repetition is real. Avoid copy-paste drift.
- **YAGNI**: Do not build features, options, or abstractions before they are needed.

### File Organization

MANY SMALL FILES > FEW LARGE FILES:
- High cohesion, low coupling
- 200-400 lines typical, 800 max
- Extract utilities from large modules
- Organize by feature/domain, not by type

### Error Handling

- Handle errors explicitly at every level
- Provide user-friendly error messages in UI-facing code
- Log detailed error context on the server side
- Never silently swallow errors

### Input Validation

- Validate all user input at system boundaries
- Use schema-based validation where available (Zod preferred for TS)
- Fail fast with clear error messages
- Never trust external data (API responses, user input, file content)

### Naming Conventions

- Variables and functions: `camelCase` with descriptive names
- Booleans: prefer `is`, `has`, `should`, or `can` prefixes
- Interfaces, types, and components: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Custom hooks: `camelCase` with a `use` prefix

### Code Smells to Avoid

- Deep nesting (>4 levels): use early returns
- Magic numbers: use named constants
- Long functions (>50 lines): split into focused pieces
- Large files (>800 lines): extract modules
- Dead code, unused options, speculative config, and abstractions with one implementation

---

## Security Guidelines

### Mandatory Security Checks

Before ANY commit:
- No hardcoded secrets (API keys, passwords, tokens)
- All user inputs validated
- SQL injection prevention (parameterized queries)
- XSS prevention (sanitized HTML)
- CSRF protection enabled where applicable
- Authentication/authorization verified
- Rate limiting on public or sensitive endpoints
- Error messages do not leak sensitive data

### Secret Management

- NEVER hardcode secrets in source code
- ALWAYS use environment variables or a secret manager
- Validate that required secrets are present at startup
- Rotate any secrets that may have been exposed

### Security Response Protocol

If a security issue is found:
1. Stop and assess the impact.
2. Use `security-reviewer` for comprehensive review when available.
3. Fix CRITICAL issues before continuing.
4. Rotate any exposed secrets.
5. Review the codebase for similar issues.

---

## Testing Requirements

### When to Test

- Logic with a branch, loop, parser, money, security, or data writes: leave a test behind.
- Bug fix: add a test that fails without the fix.
- Config, glue code, docs, and one-off scripts: no test required; run once to verify.
- In projects with an existing test suite, follow its conventions and coverage target (80% if none is stated).

### TDD Workflow

Use test-first when behavior is clear up front:
1. Write a failing test (RED)
2. Write minimal implementation (GREEN)
3. Refactor without changing behavior (IMPROVE)
4. Verify coverage where the project tracks it

### Test Structure

Use Arrange-Act-Assert. Test names should explain behavior, e.g. `returns empty array when no markets match query`.

---

## Agent Orchestration

Agents start cold and cost tokens. Default: work directly in the main context.

### When to Delegate

| Situation | Agent/Skill |
|-----------|-------------|
| Broad search across many files or an unfamiliar large codebase | `explore-codebase` |
| Need library documentation or examples | `explore-docs` |
| Auth, user input, secrets, payments, DB queries changed | `security-reviewer` |
| Build or type errors not fixed after one direct attempt | `build-error-resolver` |
| Non-trivial code change before a PR | `code-reviewer` (`typescript-reviewer` for TS/JS) |

Do not delegate reading a few known files, small edits, config, or scripts.
Independent agents go in a single parallel batch when possible.

---

## Code Review Standards

### When to Review

- Before a PR or a commit to a shared branch
- Always for security-sensitive code: auth, user input, DB queries, file paths, external APIs, crypto, payments
- Skip for docs, config-only changes, and trivial edits unless risk is present

### Review Checklist

- Code is readable and well-named
- Functions are focused (<50 lines)
- Files are cohesive (<800 lines)
- No deep nesting (>4 levels)
- Errors are handled explicitly
- No hardcoded secrets or credentials
- No debug statements in production code
- Risky logic has a test
- No SQL built by string concatenation
- No unescaped user input or unsanitized paths
- No N+1 or unbounded queries

### Severity Levels

| Level | Action |
|-------|--------|
| CRITICAL | BLOCK — Security vulnerability or data loss; must fix before merge |
| HIGH | WARN — Bug or significant quality issue; should fix before merge |
| MEDIUM | INFO — Maintainability issue; consider fixing |
| LOW | NOTE — Style or optional improvement |

---

## Git Workflow

### Commit Message Format

```text
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

### Pull Request Workflow

1. Analyze full commit history, not just latest commit
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

---

## Development Workflow

Scale the process to the task.

### Small Change

Read the relevant code, make the change, verify it runs, and stop.

### Feature or Several Files

1. **Reuse first** — check the codebase, standard library, installed dependencies, and docs before adding new code or packages.
2. **Plan** — share a short implementation plan.
3. **Implement with tests** — follow the testing rules above.
4. **Review** — use the review standards above.
5. **Commit** — use the git workflow above.

Before PR review: CI passing, no merge conflicts, branch up to date with target.

---

## Common Patterns

### Repository Pattern

Encapsulate data access behind a consistent interface: `findAll`, `findById`, `create`, `update`, `delete`.

### API Response Format

Use a consistent envelope: success indicator, data payload, error message, metadata for pagination.

### Skeleton Projects

When implementing a new project or large feature, prefer a proven skeleton over inventing structure from scratch.

---

## Performance Guidelines

- Keep answers concise; do not recap obvious work.
- Read only the part of a file that is needed.
- Choose the smallest complete change; avoid speculative abstractions.
- Always launch independent work in parallel when possible.
- Delegate broad read-only exploration to sub-agents.
- Keep main context for writing/editing files and complex reasoning.
- Above 80% context: stop large explorations, delegate remaining reads, or compact before continuing.

---

## TypeScript/JavaScript Specific

### Types and Interfaces

- Add parameter and return types to exported functions, shared utilities, and public class methods
- Let TypeScript infer obvious local variable types
- Extract repeated inline object shapes into named types or interfaces
- Use `interface` for object shapes
- Use `type` for unions/intersections/tuples/mapped types
- Prefer string literal unions over `enum`
- Avoid `any` — use `unknown` and narrow safely
- Use generics when a value's type depends on the caller

### React Props

- Define component props with a named `interface` or `type`
- Type callback props explicitly
- Do not use `React.FC` unless there is a specific reason

### Error Handling

Use async/await with try-catch and narrow unknown errors:

```typescript
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) return error.message
  return 'Unexpected error'
}
```

### Input Validation

Use Zod for schema-based validation when available:

```typescript
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150),
})

type UserInput = z.infer<typeof userSchema>
```

### API Response Pattern

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}
```

### Security

- NEVER hardcode secrets; use `process.env`
- Validate required environment variables at startup
- No `console.log` in production code — use a logger
- Use Playwright for E2E testing of critical user flows
