---
name: fix-errors
description: "Fix all ESLint and TypeScript errors with parallel processing. Use when the project has multiple lint or type errors that need batch fixing."
---

## Workflow

1. Run `npx tsc --noEmit --pretty` to collect all TypeScript errors
2. Run `npx eslint . --ext .ts,.tsx,.js,.jsx` to collect lint errors
3. Group errors by file
4. For each file, fix errors with minimal changes
5. Re-run checks after fixes
6. Iterate until clean

## Strategy

- Fix TypeScript errors first (they often cause ESLint errors)
- Process files in parallel when possible
- Use `--fix` for auto-fixable ESLint errors
- Manual fix for type errors and non-auto-fixable lint errors

## Rules

- Minimal diffs only — fix the error, nothing else
- Don't refactor while fixing errors
- Re-run checks after each batch of fixes
- Report final status
