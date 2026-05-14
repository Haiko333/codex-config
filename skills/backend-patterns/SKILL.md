---
name: backend-patterns
description: "Backend architecture patterns, API design, database optimization, and server-side best practices for Node.js, Express, and Next.js API routes. Use when building backend features."
---

## Architecture Layers

1. **Routes/Controllers** — HTTP handling, request validation, response formatting
2. **Services** — Business logic, orchestration
3. **Repositories** — Data access, queries
4. **Models** — Data structures, validation schemas

## Repository Pattern

```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}
```

## Middleware Pattern

```typescript
const authenticate = async (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1]
  if (!token) return res.status(401).json({ error: 'Unauthorized' })
  try {
    req.user = await verifyToken(token)
    next()
  } catch {
    res.status(401).json({ error: 'Invalid token' })
  }
}
```

## Database Optimization

- Use connection pooling
- Add indexes on frequently queried columns
- Use `EXPLAIN ANALYZE` for query optimization
- Implement cursor-based pagination
- Batch operations instead of N+1 queries

## Caching Strategy

- Cache expensive computations
- Use Redis for session/rate-limit data
- Set appropriate TTLs
- Invalidate on write

## Error Handling

- Use custom error classes with status codes
- Centralized error handler middleware
- Never expose internal errors to clients
- Log full error context server-side
