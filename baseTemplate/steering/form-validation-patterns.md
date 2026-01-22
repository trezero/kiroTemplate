# Form Validation Patterns

## Null/None Value Handling

Based on successful Contexts implementation:

```typescript
// API validation
const validateContext = (data: any) => {
  return {
    name: data.name?.trim() || null,
    color: data.color || '#6366f1',
    // Handle "none" string as null
    contextId: data.contextId === 'none' ? null : data.contextId
  }
}

// Frontend form handling
const handleSubmit = (formData) => {
  const cleanData = {
    ...formData,
    contextId: formData.contextId === '' ? null : formData.contextId
  }
}
```

## Color-Coded UI Components

```typescript
// Reusable color selector
const ColorSelector = ({ value, onChange, options }) => (
  <select value={value || 'none'} onChange={onChange}>
    <option value="none">No Context</option>
    {options.map(opt => (
      <option key={opt.id} value={opt.id} style={{color: opt.color}}>
        {opt.name}
      </option>
    ))}
  </select>
)
```

## Authentication Integration

```typescript
// Middleware pattern
const requireAuth = (req, res, next) => {
  if (!req.user?.id) {
    return res.status(401).json({ error: 'Unauthorized' })
  }
  next()
}
```