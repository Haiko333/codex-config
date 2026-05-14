---
name: merge
description: "Intelligently merge branches with context-aware conflict resolution. Use when merging branches or resolving merge conflicts."
---

## Workflow

1. Identify source and target branches
2. Check for conflicts: `git merge --no-commit --no-ff <branch>`
3. If conflicts exist:
   - Read each conflicted file
   - Understand both sides of the conflict
   - Resolve based on intent (not just syntax)
   - Prefer keeping both changes when possible
4. Run tests after resolution
5. Commit the merge

## Conflict Resolution Strategy

- **Both add different code**: Combine both additions
- **One modifies, one deletes**: Check if modification makes sense without deleted code
- **Both modify same lines**: Understand intent of each change, choose the better approach or combine
- **Import conflicts**: Merge all imports

## Rules

- Never discard changes without understanding them
- Run tests after every merge
- If unsure about a conflict, ask before resolving
