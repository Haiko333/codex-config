# Global Instructions

These instructions apply to ALL sessions. Follow them exactly.

---

## Coding Style

### Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate existing ones. Use spread operators, map, filter — never modify in-place.

### Core Principles

- **KISS**: Prefer the simplest solution that actually works. Optimize for clarity over cleverness.
- **DRY**: Extract repeated logic into shared functions. Avoid copy-paste drift.
- **YAGNI**: Do not build features or abstractions before they are needed.

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

- Validate all user input before processing
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

---

## Security Guidelines

### Mandatory Security Checks

Before ANY commit:
- No hardcoded secrets (API keys, passwords, tokens)
- All user inputs validated
- SQL injection prevention (parameterized queries)
- XSS prevention (sanitized HTML)
- CSRF protection enabled
- Authentication/authorization verified
- Rate limiting on all endpoints
- Error messages don't leak sensitive data

### Secret Management

- NEVER hardcode secrets in source code
- ALWAYS use environment variables or a secret manager
- Validate that required secrets are present at startup
- Rotate any secrets that may have been exposed

---

## Testing Requirements

### Minimum Test Coverage: 80%

Test Types (ALL required):
1. **Unit Tests** — Individual functions, utilities, components
2. **Integration Tests** — API endpoints, database operations
3. **E2E Tests** — Critical user flows

### Test-Driven Development

MANDATORY workflow:
1. Write test first (RED)
2. Run test — it should FAIL
3. Write minimal implementation (GREEN)
4. Run test — it should PASS
5. Refactor (IMPROVE)
6. Verify coverage (80%+)

### Test Structure (AAA Pattern)

Use Arrange-Act-Assert structure. Use descriptive names that explain the behavior under test.

---

## Git Workflow

### Commit Message Format

```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

### Pull Request Workflow

1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

---

## Development Workflow

### Feature Implementation

0. **Research & Reuse** — Search GitHub, library docs, and package registries before writing new code. Prefer adopting proven approaches.
1. **Plan First** — Create implementation plan before coding. Identify dependencies and risks.
2. **TDD Approach** — Write tests first, implement to pass, refactor. Verify 80%+ coverage.
3. **Code Review** — Review immediately after writing code. Address CRITICAL and HIGH issues.
4. **Commit & Push** — Detailed commit messages, conventional commits format.
5. **Pre-Review Checks** — Verify CI/CD passing, resolve conflicts, ensure branch up to date.

---

## Code Review Standards

### When to Review (MANDATORY)

- After writing or modifying code
- Before any commit to shared branches
- When security-sensitive code changes (auth, payments, user data)
- When architectural changes are made

### Review Checklist

- Code is readable and well-named
- Functions are focused (<50 lines)
- Files are cohesive (<800 lines)
- No deep nesting (>4 levels)
- Errors are handled explicitly
- No hardcoded secrets or credentials
- No console.log or debug statements
- Tests exist for new functionality
- Test coverage meets 80% minimum

### Severity Levels

| Level | Action |
|-------|--------|
| CRITICAL | BLOCK — Must fix before merge |
| HIGH | WARN — Should fix before merge |
| MEDIUM | INFO — Consider fixing |
| LOW | NOTE — Optional |

---

## Common Patterns

### Repository Pattern

Encapsulate data access behind a consistent interface with findAll, findById, create, update, delete.

### API Response Format

Use a consistent envelope: success indicator, data payload, error message, metadata for pagination.

---

## Performance Guidelines

- Always launch independent work in parallel when possible
- Delegate read-only exploration to sub-agents
- Keep main context for writing/editing files and complex reasoning
- When context grows large, summarize and compact before continuing

---

## TypeScript/JavaScript Specific

### Types and Interfaces

- Add parameter and return types to exported functions
- Let TypeScript infer obvious local variable types
- Use `interface` for object shapes, `type` for unions/intersections/tuples
- Prefer string literal unions over `enum`
- Avoid `any` — use `unknown` and narrow safely
- Use generics when a value's type depends on the caller

### React Props

- Define component props with a named `interface` or `type`
- Type callback props explicitly
- Do not use `React.FC` unless there is a specific reason

### Error Handling (TS)

Use async/await with try-catch and narrow unknown errors:

```typescript
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) return error.message
  return 'Unexpected error'
}
```

### Input Validation (TS)

Use Zod for schema-based validation and infer types from schemas:

```typescript
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

type UserInput = z.infer<typeof userSchema>
```

### API Response Pattern

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: { total: number; page: number; limit: number }
}
```

### Security (TS)

- NEVER hardcode secrets: use `process.env`
- Validate required env vars at startup
- No `console.log` in production code — use proper logging libraries
- Use Playwright for E2E testing
