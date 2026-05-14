---
name: security-review
description: "Complete security review skill with comprehensive checklists and patterns. Use when adding authentication, handling user input, working with secrets, creating API endpoints, or implementing payment/sensitive features."
---

## Security Review Checklist

### Secrets Management
- [ ] No hardcoded API keys, passwords, tokens
- [ ] Secrets loaded from environment variables
- [ ] `.env` files in `.gitignore`
- [ ] Secrets validated at startup

### Input Validation
- [ ] All user input validated with schema (Zod/Joi)
- [ ] File uploads validated (type, size, content)
- [ ] URL parameters sanitized
- [ ] Request body size limited

### SQL Injection Prevention
- [ ] Parameterized queries everywhere
- [ ] No string concatenation in queries
- [ ] ORM used correctly (no raw queries with user input)

### Authentication & Authorization
- [ ] Passwords hashed with bcrypt/argon2
- [ ] JWT tokens validated and expired
- [ ] Session management secure
- [ ] Auth checked on every protected route
- [ ] CORS configured properly

### XSS Prevention
- [ ] User input escaped in HTML output
- [ ] Content Security Policy headers set
- [ ] `dangerouslySetInnerHTML` avoided or sanitized with DOMPurify

### CSRF Protection
- [ ] Anti-CSRF tokens on state-changing endpoints
- [ ] SameSite cookie attribute set

### Rate Limiting
- [ ] Rate limits on authentication endpoints
- [ ] Rate limits on public API endpoints
- [ ] Rate limit headers returned

### Sensitive Data
- [ ] PII encrypted at rest
- [ ] HTTPS enforced
- [ ] Sensitive data not logged
- [ ] Error messages don't leak internals

### Dependencies
- [ ] `npm audit` clean (no high/critical vulnerabilities)
- [ ] Dependencies pinned to specific versions
- [ ] No unnecessary dependencies
