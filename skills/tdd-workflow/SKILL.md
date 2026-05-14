---
name: tdd-workflow
description: "Use this skill when writing new features, fixing bugs, or refactoring code. Enforces test-driven development with 80%+ coverage including unit, integration, and E2E tests."
---

## TDD Cycle

### 1. RED — Write a failing test
- Write the test BEFORE the implementation
- Test should clearly describe the expected behavior
- Run the test — it MUST fail

### 2. GREEN — Write minimal implementation
- Write the simplest code that makes the test pass
- Don't over-engineer
- Run the test — it MUST pass

### 3. IMPROVE — Refactor
- Clean up the implementation
- Extract utilities, improve naming
- Run all tests — they MUST still pass

## Test Types Required

1. **Unit Tests** — Individual functions, utilities, components
2. **Integration Tests** — API endpoints, database operations
3. **E2E Tests** — Critical user flows (Playwright for web)

## Test Structure (AAA Pattern)

```typescript
test('descriptive name explaining behavior', () => {
  // Arrange — set up test data
  const input = { email: 'test@example.com' }

  // Act — execute the code under test
  const result = validateEmail(input.email)

  // Assert — verify the outcome
  expect(result).toBe(true)
})
```

## Coverage Target: 80%+

After each implementation cycle:
1. Run `npm test -- --coverage`
2. Check coverage report
3. Add tests for uncovered paths
4. Repeat until 80%+ achieved

## Git Checkpoints

Create a commit after each GREEN phase:
- `test: add tests for [feature]`
- `feat: implement [feature]`
- `refactor: clean up [feature]`

## Common Patterns

- Use `beforeEach` for shared setup
- Mock external dependencies (APIs, databases)
- Test edge cases: empty input, null, boundaries
- Test error paths, not just happy paths
