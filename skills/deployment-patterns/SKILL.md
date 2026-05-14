---
name: deployment-patterns
description: "Deployment workflows, CI/CD pipeline patterns, Docker containerization, health checks, rollback strategies, and production readiness checklists for web applications."
---

## Deployment Strategies

### Blue-Green
- Two identical environments (blue/green)
- Switch traffic after verification
- Instant rollback by switching back

### Canary
- Route small % of traffic to new version
- Monitor metrics and errors
- Gradually increase if healthy

### Rolling
- Update instances one at a time
- Zero downtime
- Slower rollback

## Docker Best Practices

- Use multi-stage builds for smaller images
- Pin base image versions
- Don't run as root
- Use `.dockerignore`
- Health check in Dockerfile

## GitHub Actions CI/CD

```yaml
name: CI/CD
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    steps:
      - run: deploy-command
```

## Health Checks

- `/health` — Basic liveness (200 OK)
- `/ready` — Readiness (DB connected, dependencies up)
- Include version, uptime, dependency status

## Production Readiness Checklist

- [ ] Health check endpoints
- [ ] Structured logging
- [ ] Error tracking (Sentry)
- [ ] Monitoring and alerting
- [ ] Graceful shutdown handling
- [ ] Environment-based configuration
- [ ] Secrets in environment variables
- [ ] Database migrations automated
- [ ] Rollback plan documented
- [ ] Load testing completed
