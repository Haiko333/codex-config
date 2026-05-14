---
name: openai-api
description: "Build, debug, and optimize OpenAI API / SDK apps. Use when code imports openai SDK, user asks about the OpenAI API, or when building AI-powered applications. Covers chat completions, assistants, function calling, embeddings, and batch processing."
---

## OpenAI API Patterns

### Chat Completions

```typescript
import OpenAI from 'openai'

const openai = new OpenAI()

const response = await openai.chat.completions.create({
  model: 'gpt-5.5',
  messages: [
    { role: 'system', content: 'You are a helpful assistant.' },
    { role: 'user', content: userMessage }
  ],
  temperature: 0.7,
  max_tokens: 1000
})
```

### Function Calling (Tool Use)

```typescript
const tools = [{
  type: 'function',
  function: {
    name: 'get_weather',
    description: 'Get current weather for a location',
    parameters: {
      type: 'object',
      properties: {
        location: { type: 'string', description: 'City name' }
      },
      required: ['location']
    }
  }
}]
```

### Streaming

```typescript
const stream = await openai.chat.completions.create({
  model: 'gpt-5.5',
  messages,
  stream: true
})

for await (const chunk of stream) {
  const content = chunk.choices[0]?.delta?.content ?? ''
  process.stdout.write(content)
}
```

### Error Handling

```typescript
try {
  const response = await openai.chat.completions.create(params)
} catch (error) {
  if (error instanceof OpenAI.APIError) {
    if (error.status === 429) { /* rate limited, retry with backoff */ }
    if (error.status === 500) { /* server error, retry */ }
  }
}
```

## Best Practices

- Always set `max_tokens` to avoid runaway costs
- Use streaming for long responses
- Implement retry with exponential backoff
- Cache responses when appropriate
- Monitor token usage and costs
- Use structured outputs for reliable parsing
