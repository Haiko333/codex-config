---
name: ralph-loop
description: "Setup the Ralph autonomous AI coding loop - ships features while you sleep. Use when you want to set up an autonomous development loop that iterates on a feature with minimal supervision."
---

## Overview

Ralph is an autonomous coding loop that:
1. Takes a feature spec / PRD
2. Breaks it into stories
3. Implements each story with TDD
4. Reviews and validates
5. Commits and moves to next story

## Setup Steps

### Step 0: Initialize
- Parse the user's feature request
- Create a PRD (Product Requirements Document)
- Define acceptance criteria

### Step 1: Interactive PRD
- Present the PRD to the user for validation
- Clarify ambiguities
- Finalize scope and priorities

### Step 2: Create Stories
- Break the PRD into implementable stories
- Order by dependency
- Estimate complexity
- Create task list

### Step 3: Execute Loop
For each story:
1. Explore codebase for context
2. Write tests (RED)
3. Implement (GREEN)
4. Refactor (IMPROVE)
5. Code review
6. Commit with conventional message
7. Move to next story

## Loop Controls

- **Continue**: Process next story
- **Pause**: Stop and report progress
- **Abort**: Stop and revert uncommitted changes
