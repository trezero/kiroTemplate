# Common Pitfalls and Solutions

## Calendar Integration

### Microsoft Graph API

#### Pitfall 1: Using Wrong Endpoint for Event Queries
**Problem:** Using `/me/events` with date filters returns incomplete results
- Missing self-organized events
- Missing events from certain organizers
- Recurring events not properly expanded

**Solution:** Always use `/me/calendarView` for date-based queries
```typescript
// ✅ Correct
GET /me/calendarView?startDateTime=...&endDateTime=...

// ❌ Wrong
GET /me/events?$filter=start/dateTime ge '...'
```

**Why:** `calendarView` is specifically designed for calendar UI rendering and handles all edge cases properly.

#### Pitfall 2: Timezone Handling
**Problem:** Events appear at wrong times or are missing from queries

**Solution:** Always use `Prefer: outlook.timezone` header
```typescript
.header('Prefer', `outlook.timezone="${systemTimezone}"`)
```

**Why:** Microsoft Graph returns events in UTC by default. The header ensures proper timezone conversion.

#### Pitfall 3: Cancelled Events
**Problem:** Cancelled events still appear in calendar view

**Solution:** Always include `isCancelled` in select and filter it out
```typescript
$select: '...isCancelled...'
// Then filter in frontend:
.filter(event => !event.isCancelled)
```

### Google Calendar API

#### Pitfall 1: All-Day Events
**Problem:** All-day events have `date` instead of `dateTime`

**Solution:** Check both fields
```typescript
const startTime = event.start?.dateTime || event.start?.date;
```

#### Pitfall 2: Recurring Events
**Problem:** Recurring events return as single master event

**Solution:** Use `singleEvents: true` parameter
```typescript
calendar.events.list({
  singleEvents: true,  // Expands recurring events
  orderBy: 'startTime'
})
```

## Frontend

### Pitfall 1: Event Grouping by Organizer
**Problem:** Events grouped by organizer email instead of calendar account

**Solution:** Use account metadata added by backend
```typescript
calendarId: event.accountEmail || 'primary'
```

**Why:** Multiple organizers in same calendar should be grouped together.

### Pitfall 2: Date Parsing Across Timezones
**Problem:** Date strings parsed incorrectly causing wrong day grouping

**Solution:** Extract date part before timezone conversion
```typescript
const eventDateStr = event.start.dateTime.split('T')[0];
```

## Backend

### Pitfall 1: Missing Account Metadata
**Problem:** Frontend can't determine which account an event belongs to

**Solution:** Always add metadata when fetching events
```typescript
const eventsWithMetadata = events.map(event => ({
  ...event,
  accountId: account.id,
  accountEmail: account.accountEmail,
  accountProvider: account.provider
}));
```

### Pitfall 2: Token Expiration
**Problem:** Access tokens expire after 1 hour

**Solution:** Implement automatic token refresh
```typescript
if (account.tokenExpiresAt < new Date()) {
  await refreshAccessToken(account);
}
```

## Database

### Pitfall 1: Empty enabled_calendars Array
**Problem:** `enabled_calendars: []` causes no calendars to be queried

**Solution:** Fallback to primary calendar when empty
```typescript
if (enabledCalendars.length > 0) {
  // Query specific calendars
} else {
  // Fallback to primary
}
```

## Testing

### Pitfall 1: Testing with Production Tokens
**Problem:** Tokens expire quickly, tests fail randomly

**Solution:** Use Microsoft Graph Explorer or refresh tokens before testing

### Pitfall 2: Hardcoded Date Ranges
**Problem:** Tests fail when run on different dates

**Solution:** Use relative dates
```typescript
const today = new Date();
const nextWeek = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
```

## Performance

### Pitfall 1: Fetching All Events on Every Page Load
**Problem:** Slow page loads, excessive API calls

**Solution:** Implement caching with TTL
```typescript
// Cache events for 5 minutes
const cacheKey = `events:${userId}:${startDate}:${endDate}`;
```

### Pitfall 2: No Pagination for Large Event Lists
**Problem:** Fetching 1000+ events causes timeouts

**Solution:** Implement pagination
```typescript
$top: 50,  // Limit results
$skip: offset  // For pagination
```

## Security

### Pitfall 1: Storing Tokens in Plain Text
**Problem:** Security vulnerability

**Solution:** Always encrypt tokens at rest
```typescript
// Already implemented in Continuum
access_token: text (encrypted)
```

### Pitfall 2: Exposing Tokens in Logs
**Problem:** Tokens visible in server logs

**Solution:** Redact sensitive data
```typescript
console.log(`Token: ${token.substring(0, 10)}...`);
```

## Quick Reference

### When to Use Each Microsoft Endpoint
- `/me/calendarView` - Fetching events for display (USE THIS)
- `/me/events` - Creating/updating/deleting events
- `/me/calendars` - Listing available calendars

### Required Fields for Event Display
```typescript
$select: 'subject,start,end,body,bodyPreview,attendees,organizer,onlineMeeting,webLink,isAllDay,isCancelled,showAs'
```

### Debugging Checklist
1. ✅ Using correct endpoint (`/me/calendarView`)
2. ✅ Timezone header included
3. ✅ Date range in ISO format
4. ✅ Account metadata added to events
5. ✅ Cancelled events filtered out
6. ✅ Token not expired
7. ✅ Proper error handling
