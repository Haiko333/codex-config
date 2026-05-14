---
name: commit
description: "Quick commit and push with minimal, clean conventional commit messages. Use when ready to commit current changes."
---

## Workflow

1. Run `git status` and `git diff --staged` to understand changes
2. Run `git log --oneline -5` to match commit message style
3. Stage relevant files (prefer specific files over `git add -A`)
4. Create commit with conventional format: `<type>: <description>`
5. Push if requested

## Commit Types

- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code restructuring
- `docs`: Documentation
- `test`: Tests
- `chore`: Maintenance
- `perf`: Performance
- `ci`: CI/CD changes

## Rules

- Keep messages concise (1-2 sentences)
- Focus on the "why" not the "what"
- Never commit secrets (.env, credentials)
- Never use `--no-verify`
- Always create NEW commits (don't amend unless asked)
