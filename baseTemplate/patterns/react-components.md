# React Component Patterns for Recipe Raiders

## Component Structure
```tsx
interface ComponentProps {
  // Props definition
}

export function ComponentName({ prop1, prop2 }: ComponentProps) {
  // Hooks
  const [state, setState] = useState();
  
  // Event handlers
  const handleAction = () => {
    // Implementation
  };
  
  // Render
  return (
    <div className="component-container">
      {/* JSX content */}
    </div>
  );
}
```

## Firebase Integration Pattern
```tsx
import { useAuthState } from 'react-firebase-hooks/auth';
import { auth, db } from '@/firebase';

export function FirebaseComponent() {
  const [user, loading, error] = useAuthState(auth);
  
  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!user) return <LoginPrompt />;
  
  return <AuthenticatedContent user={user} />;
}
```

## Form Validation Pattern
```tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';

const schema = z.object({
  field: z.string().min(1, 'Required'),
});

export function FormComponent() {
  const form = useForm({
    resolver: zodResolver(schema),
  });
  
  const onSubmit = (data: z.infer<typeof schema>) => {
    // Handle submission
  };
  
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        {/* Form fields */}
      </form>
    </Form>
  );
}
```
