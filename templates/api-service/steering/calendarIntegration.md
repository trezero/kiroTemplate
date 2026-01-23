# Calendar Integration Documentation

## Overview

Continuum integrates with both Google Calendar and Microsoft Outlook to provide unified calendar event management. The system supports multi-account configurations, proper timezone handling, and automatic meeting link extraction for seamless meeting access.

## Architecture

### Two-Provider System
- **Google Calendar**: Uses Google Calendar API v3 with OAuth 2.0
- **Microsoft Outlook**: Uses Microsoft Graph API v1.0 with OAuth 2.0
- **Unified Interface**: Both providers normalized to consistent data structure

### Key Components
- `server/google-oauth.ts` - Google Calendar OAuth and API client
- `server/microsoft-oauth.ts` - Microsoft Graph OAuth and API client
- `server/routes.ts` - Unified calendar endpoints with provider normalization
- `client/src/pages/meetings.tsx` - Frontend calendar event display

## Google Calendar Integration

### Authentication Flow
1. User initiates OAuth via `/api/auth/google`
2. Redirect to Google OAuth consent screen
3. Callback to `/api/auth/google/callback`
4. Exchange authorization code for access/refresh tokens
5. Store encrypted tokens in PostgreSQL

### API Implementation
```typescript
// Key endpoints used
GET /me/calendars - List user calendars
GET /calendars/{id}/events - List calendar events

// OAuth scopes required
- https://www.googleapis.com/auth/calendar.readonly
- https://www.googleapis.com/auth/userinfo.email
```

### Data Structure
```typescript
// Google Calendar Event Format
{
  id: string,
  summary: string,
  start: { dateTime: string, timeZone?: string },
  end: { dateTime: string, timeZone?: string },
  description?: string,
  attendees?: Array<{ email: string, displayName?: string }>,
  hangoutLink?: string // Google Meet link
}
```

## Microsoft Outlook Integration

### Authentication Flow
1. User initiates OAuth via `/api/auth/microsoft`
2. Redirect to Microsoft OAuth consent screen
3. Callback to `/api/auth/microsoft/callback`
4. Exchange authorization code for access/refresh tokens
5. Store encrypted tokens in PostgreSQL

### API Implementation

**CRITICAL: Endpoint Selection**

Use `/me/calendarView` for fetching events, NOT `/me/events`:

```typescript
// ✅ CORRECT - Use calendarView for date ranges
GET /me/calendarView?startDateTime=...&endDateTime=...

// ❌ WRONG - /me/events with filter doesn't work properly
GET /me/events?$filter=start/dateTime ge '...'
```

**Why calendarView?**
- Designed specifically for calendar UI rendering
- Properly handles recurring events (expands instances)
- Returns events from ALL organizers (including self-organized)
- Respects timezone preferences via `Prefer: outlook.timezone` header
- No filtering issues with different event types

**Why NOT /me/events?**
- Filters out events from certain organizers (Iva Kalova, self-organized)
- Doesn't properly expand recurring events
- Inconsistent results with date filters
- Missing events appear randomly

```typescript
// Key endpoints used
GET /me/calendarView - Fetch events in date range (USE THIS)
GET /me/calendars - List user calendars

// OAuth scopes required
- https://graph.microsoft.com/Calendars.Read
- https://graph.microsoft.com/User.Read
- offline_access
```

### Timezone Handling
Microsoft Graph API returns events in UTC by default. We use the `Prefer: outlook.timezone` header to request events in the system's local timezone:

```typescript
.header('Prefer', `outlook.timezone="${systemTimezone}"`)
```

### Data Structure
```typescript
// Microsoft Graph Event Format
{
  id: string,
  subject: string, // Maps to 'summary'
  start: { dateTime: string, timeZone: string },
  end: { dateTime: string, timeZone: string },
  body: { content: string, contentType: 'html' | 'text' },
  attendees?: Array<{ emailAddress: { address: string, name: string } }>,
  onlineMeeting?: { joinUrl: string, conferenceId: string }
}
```

## Event Normalization

### Server-Side Normalization
Events from both providers are normalized to a consistent format in `server/routes.ts`:

```typescript
// Microsoft events normalized to Google format
{
  ...event,
  summary: event.subject, // Microsoft uses 'subject'
  start: { dateTime: event.start?.dateTime, timeZone: event.start?.timeZone },
  end: { dateTime: event.end?.dateTime, timeZone: event.end?.timeZone },
  description: event.body?.content || event.bodyPreview,
  attendees: event.attendees?.map(a => ({
    email: a.emailAddress?.address,
    displayName: a.emailAddress?.name
  })),
  meetingUrl: event.onlineMeeting?.joinUrl || event.webLink || null
}
```

### Client-Side Processing
The frontend further processes events for display:

```typescript
// Unified meeting object
{
  id: string,
  title: string, // From summary/subject
  startTime: string, // Formatted time
  endTime: string,
  attendees: string, // Comma-separated emails
  notes: string, // HTML content from body
  meetingUrl: string | null, // Teams/Meet/Zoom link
  calendarName: string,
  calendarColor: string
}
```

## Meeting Link Extraction

### Google Calendar
- Meeting links stored in `hangoutLink` field
- Automatically populated for Google Meet meetings
- Third-party meeting links may appear in description

### Microsoft Outlook
- Teams meeting links in `onlineMeeting.joinUrl`
- Fallback to `webLink` for Outlook calendar link
- Meeting details also embedded in HTML body content

### Client-Side Handling
```typescript
// Priority order for meeting URLs
meetingUrl: event.meetingUrl || 
           event.onlineMeeting?.joinUrl || 
           event.hangoutLink || 
           null
```

## Timezone Management

### Challenge
- Google Calendar: Events in user's timezone or UTC
- Microsoft Graph: Events in UTC by default
- Client: Needs consistent local time display

### Solution
1. **Server-side**: Request Microsoft events with `Prefer: outlook.timezone` header
2. **Client-side**: Parse datetime strings with proper timezone awareness
3. **Display**: Use browser's `toLocaleTimeString()` for consistent formatting

### Implementation
```typescript
// Microsoft OAuth timezone request
const systemTimezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
.header('Prefer', `outlook.timezone="${systemTimezone}"`)

// Client-side datetime parsing
const startDate = new Date(event.start.dateTime);
const displayTime = startDate.toLocaleTimeString('en-US', { 
  hour: '2-digit', 
  minute: '2-digit' 
});
```

## HTML Content Rendering

### Microsoft Outlook Challenge
Microsoft Graph API returns meeting body content as HTML, including Teams meeting details, which was displaying as raw HTML.

### Solution
```typescript
// Render HTML content safely
<div 
  className="text-muted-foreground prose prose-sm max-w-none" 
  dangerouslySetInnerHTML={{ __html: selectedMeeting.notes }}
/>
```

## Multi-Account Support

### Database Schema
```sql
calendar_accounts (
  id: uuid PRIMARY KEY,
  user_id: uuid REFERENCES users(id),
  provider: 'google' | 'microsoft',
  account_email: text,
  access_token: text, -- encrypted
  refresh_token: text, -- encrypted
  token_expires_at: timestamp,
  enabled_calendars: text[] -- calendar IDs
)
```

### Account Management
- Users can connect multiple Google and Microsoft accounts
- Each account can have specific calendars enabled/disabled
- Token refresh handled automatically before expiration
- Graceful degradation when accounts become unavailable

## API Endpoints

### Calendar Management
- `GET /api/calendar/connected` - List connected accounts
- `GET /api/calendar/events` - Unified events from all accounts
- `GET /api/calendar/google/list` - Google calendars for account
- `GET /api/calendar/microsoft/list` - Microsoft calendars for account

### Authentication
- `GET /api/auth/google` - Initiate Google OAuth
- `GET /api/auth/google/callback` - Google OAuth callback
- `GET /api/auth/microsoft` - Initiate Microsoft OAuth
- `GET /api/auth/microsoft/callback` - Microsoft OAuth callback

## Error Handling

### Token Expiration
- Automatic refresh using stored refresh tokens
- Graceful fallback when refresh fails
- User notification for re-authentication needed

### API Rate Limits
- Respect provider rate limits
- Exponential backoff for failed requests
- Cache responses where appropriate

### Network Failures
- Continue with available accounts when others fail
- Log errors without breaking user experience
- Retry failed requests with exponential backoff

## Security Considerations

### Token Storage
- Access tokens encrypted at rest in PostgreSQL
- Refresh tokens encrypted separately
- Tokens scoped to minimum required permissions

### Data Access
- User-scoped data access across all layers
- No cross-user data access possible
- OAuth tokens isolated per user account

### Privacy Mode
When `CONTINUUM_MODE=local`:
- All calendar data stays local
- No external API calls for AI processing
- Local-only meeting link extraction

## Future Enhancements

### Planned Features
- Real-time calendar sync via webhooks
- Meeting transcription integration
- Automatic action item extraction from meeting content
- Calendar event creation from tasks
- Smart meeting scheduling suggestions

### Technical Improvements
- WebSocket-based real-time updates
- Improved caching strategy
- Background sync optimization
- Enhanced timezone detection
- Meeting link validation

## Troubleshooting

### Common Issues
1. **Timezone mismatch**: Ensure server timezone matches user expectation
2. **Missing meeting links**: Verify `onlineMeeting` field in Microsoft Graph response
3. **HTML not rendering**: Check `dangerouslySetInnerHTML` implementation
4. **Token expiration**: Monitor refresh token validity

### Debug Logging
- Server logs show provider-specific API responses
- Client logs show timezone conversion and meeting URL extraction
- Network tab shows OAuth flow and API requests

### Testing
- Test with both Google and Microsoft accounts
- Verify timezone handling across different regions
- Test meeting link extraction for various meeting types
- Validate HTML content rendering for complex meeting bodies
