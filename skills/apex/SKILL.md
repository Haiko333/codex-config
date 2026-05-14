---
name: apex
description: "Systematic implementation using APEX methodology (Analyze-Plan-Execute-Validate) with parallel agents and self-validation. Use when implementing features, fixing bugs, or making code changes that benefit from structured workflow."
---

## APEX Methodology

A 5-phase workflow: Initialize → Analyze → Plan → Execute → Validate.

### Phase 0: Initialize
- Parse the user request
- Identify scope, constraints, and deliverables
- Create task list

### Phase 1: Analyze
- Explore codebase structure and existing patterns
- Research library documentation
- Search for similar implementations
- Identify dependencies and risks
- Run agents in parallel for independent research

### Phase 2: Plan
- Design implementation approach
- Break down into discrete tasks
- Identify file changes needed
- Plan test strategy
- Present plan for user approval before proceeding

### Phase 3: Execute
- Implement changes following the plan
- Write tests first (TDD)
- Write minimal implementation to pass tests
- Run code review after each file change
- Security review for sensitive code

### Phase 4: Validate
- Run full test suite
- Verify build passes
- Check test coverage (80%+ target)
- Run linter/formatter
- Final code review
- Report results

## Parallel Execution

Launch independent agents simultaneously:
- Codebase exploration + docs research + web search
- Multiple file analyses
- Code review + security review

## Quality Gates

Each phase has exit criteria:
- **Analyze**: All context gathered, risks identified
- **Plan**: User-approved plan, tasks created
- **Execute**: All tasks complete, tests passing
- **Validate**: Build green, coverage met, review clean
