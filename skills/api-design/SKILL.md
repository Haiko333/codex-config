---
name: api-design
description: "REST API design patterns including resource naming, status codes, pagination, filtering, error responses, versioning, and rate limiting for production APIs. Use when designing or reviewing API endpoints."
---

## Resource Naming

- Use plural nouns: `/users`, `/posts`, `/comments`
- Nest for relationships: `/users/{id}/posts`
- Use kebab-case: `/user-profiles`
- Max 3 levels of nesting

## HTTP Methods

| Method | Usage | Idempotent |
|--------|-------|------------|
| GET | Read resource(s) | Yes |
| POST | Create resource | No |
| PUT | Replace resource | Yes |
| PATCH | Partial update | No |
| DELETE | Remove resource | Yes |

## Status Codes

- `200` OK, `201` Created, `204` No Content
- `400` Bad Request, `401` Unauthorized, `403` Forbidden, `404` Not Found, `409` Conflict, `422` Unprocessable Entity, `429` Too Many Requests
- `500` Internal Server Error

## Pagination

Use cursor-based pagination for large datasets:

```
GET /users?cursor=abc123&limit=20

Response:
{
  "data": [...],
  "meta": { "next_cursor": "def456", "has_more": true }
}
```

## Filtering & Sorting

```
GET /users?status=active&role=admin&sort=-created_at&limit=20
```

## Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable message",
    "details": [
      { "field": "email", "message": "Invalid email format" }
    ]
  }
}
```

## Rate Limiting Headers

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1620000000
```

## Versioning

Use URL path versioning: `/api/v1/users`
