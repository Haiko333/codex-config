---
name: prompt-creator
description: "Expert prompt engineering for creating effective prompts for Claude, GPT, and other LLMs. Use when writing system prompts, user prompts, few-shot examples, or optimizing existing prompts for better performance."
---

## Prompt Engineering Principles

### Clarity
- Be specific about what you want
- Use concrete examples over abstract descriptions
- State constraints explicitly
- Define the output format

### Structure
- Use XML tags for clear sections: `<context>`, `<instructions>`, `<examples>`
- Separate system context from task instructions
- Group related instructions together
- Use numbered steps for sequential tasks

### Few-Shot Patterns
- Provide 2-3 diverse examples
- Show both input and expected output
- Include edge cases in examples
- Use consistent formatting across examples

### System Prompt Patterns
- Define the role clearly
- State what to do AND what not to do
- Include quality criteria
- Specify output format with examples

### Reasoning Techniques
- Chain of thought: "Think step by step"
- Self-consistency: "Consider multiple approaches"
- Reflection: "Verify your answer"

## Anti-Patterns to Avoid

- Vague instructions ("be helpful")
- Contradictory constraints
- Missing output format specification
- Too many instructions (cognitive overload)
- No examples for complex tasks

## Optimization

1. Start with a clear, simple prompt
2. Test with diverse inputs
3. Identify failure modes
4. Add constraints for edge cases
5. Iterate and test again
