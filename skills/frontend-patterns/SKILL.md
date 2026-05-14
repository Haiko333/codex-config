---
name: frontend-patterns
description: "Frontend development patterns for React, Next.js, state management, performance optimization, and UI best practices. Use when building frontend features."
---

## Component Composition

- Prefer composition over inheritance
- Use render props or children for flexible components
- Extract custom hooks for reusable logic
- Keep components small and focused

## Custom Hooks

```typescript
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)
  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay)
    return () => clearTimeout(handler)
  }, [value, delay])
  return debouncedValue
}
```

## State Management

- Local state: `useState` for component-scoped data
- Shared state: Context API or Zustand for cross-component
- Server state: React Query / SWR for API data
- URL state: Search params for filterable/shareable views

## Performance Optimization

- `React.memo` for expensive pure components
- `useMemo` for expensive computations
- `useCallback` for stable callback references
- Lazy loading with `React.lazy` and `Suspense`
- Image optimization with `next/image`

## Forms

- Use controlled components with validation libraries (react-hook-form + zod)
- Validate on blur and submit
- Show inline errors
- Disable submit during loading

## Accessibility

- Semantic HTML elements
- ARIA labels on interactive elements
- Keyboard navigation support
- Focus management on route changes
- Color contrast compliance
