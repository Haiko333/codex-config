---
name: simplify
description: "Review changed code for reuse, quality, and efficiency, then fix any issues found. Use after implementing a feature to clean up and simplify."
---

## Workflow

1. Run `git diff` to see recent changes
2. Review for:
   - **Reuse**: Is there existing code that does the same thing?
   - **Duplication**: Are there repeated patterns that should be extracted?
   - **Complexity**: Can the code be simplified?
   - **Efficiency**: Are there unnecessary computations or allocations?
3. Apply simplifications
4. Run tests to verify nothing broke

## What to Look For

- Duplicated logic that can be extracted
- Over-engineered abstractions
- Unnecessary intermediate variables
- Verbose conditional logic that can be simplified
- Missing use of existing utility functions
- Unnecessary type assertions or casts

## Rules

- Only simplify code that was recently changed
- Don't introduce new abstractions unless clearly justified
- Run tests after every change
- Keep changes minimal and focused
