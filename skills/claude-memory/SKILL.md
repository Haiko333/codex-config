---
name: codex-memory
description: "Create and optimize project instruction files and configuration for Codex CLI. Guidance on config.toml structure, instructions.md content, skill creation, and project-level configuration best practices."
---

## Codex Configuration Files

### config.toml (User Level)
Location: `~/.codex/config.toml`

Key sections:
- Model and provider settings
- Feature flags
- Agent roles
- TUI configuration
- Hooks
- Skills settings
- Trusted projects

### .codex/config.toml (Project Level)
Location: `<project>/.codex/config.toml`

Override user settings per-project:
- Model selection
- Sandbox mode
- Custom instructions file
- Project-specific hooks

### instructions.md
Location: Referenced by `model_instructions_file` in config.toml

Contains:
- Coding standards
- Security guidelines
- Testing requirements
- Git workflow
- Project-specific patterns

## Best Practices

- Keep instructions concise — Codex shares context window
- Use project-level config for project-specific overrides
- Don't duplicate information available in the codebase
- Focus on non-obvious constraints and decisions
