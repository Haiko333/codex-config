---
name: fix-pr-comments
description: "Fetch PR review comments and implement all requested changes. Use after receiving PR review feedback."
---

## Workflow

1. Fetch PR comments: `gh api repos/{owner}/{repo}/pulls/{number}/comments`
2. Also fetch review comments: `gh pr view {number} --comments`
3. Parse each review comment:
   - Identify the file and line referenced
   - Understand the requested change
   - Categorize: must-fix vs suggestion
4. Implement all must-fix changes
5. Implement reasonable suggestions
6. Run tests after changes
7. Commit with message: `fix: address PR review comments`

## Rules

- Address ALL review comments
- Don't ignore any feedback without explanation
- Run tests after implementing fixes
- If a comment is unclear, note it in the response
