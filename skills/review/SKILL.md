---
name: review
description: "Review a pull request comprehensively. Analyzes all changes, checks for security issues, code quality, test coverage, and provides structured feedback. Use when asked to review a PR."
---

## Workflow

1. Fetch PR details: `gh pr view {number} --json title,body,files,commits`
2. Get the full diff: `gh pr diff {number}`
3. Analyze ALL changes (not just latest commit)
4. Check each file against review criteria
5. Run security review on sensitive code
6. Report findings

## Review Criteria

### Security (CRITICAL)
- Hardcoded secrets
- SQL injection
- XSS vulnerabilities
- Auth bypasses
- Path traversal

### Code Quality (HIGH)
- Functions >50 lines
- Files >800 lines
- Deep nesting >4 levels
- Missing error handling
- Mutation patterns
- Dead code

### Tests (HIGH)
- New code has tests
- Coverage adequate
- Edge cases covered

### Performance (MEDIUM)
- N+1 queries
- Missing pagination
- Unnecessary re-renders

## Output Format

```
## PR Review: #{number} — {title}

### Summary
Brief description of what the PR does.

### Findings
[SEVERITY] Issue description
File: path:line
Fix: Suggested fix

### Verdict
APPROVE / WARNING / BLOCK
```
