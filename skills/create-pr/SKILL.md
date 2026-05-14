---
name: create-pr
description: "Create and push PR with auto-generated title and description. Analyzes full commit history to generate comprehensive summary."
---

## Workflow

1. Run `git status`, `git diff`, `git log` to understand all changes
2. Check if branch tracks remote and is up to date
3. Run `git diff [base-branch]...HEAD` for full diff
4. Analyze ALL commits (not just latest)
5. Draft PR title (<70 chars) and summary
6. Create branch if needed, push with `-u`
7. Create PR using `gh pr create`

## PR Format

```
## Summary
- 1-3 bullet points describing changes

## Test plan
- [ ] Testing checklist items
```

## Rules

- PR title: short, under 70 chars
- Use description/body for details
- Analyze ALL commits in the branch
- Include test plan
- Return PR URL when done
