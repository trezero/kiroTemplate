# Authentication Architecture

## Overview

Continuum uses a **dual authentication system** with Firebase Auth for user authentication and direct Google OAuth for calendar integration.

## Authentication Flow Architecture

### 1. User Authentication (Firebase Auth)

#### Frontend Authentication (`client/src/lib/auth-context.tsx`)
- **Provider**: Firebase Authentication
- **Flow**: Email/password and Google Sign-In via Firebase
- **State Management**: React Context with React Query for server sync
- **Token Management**: Firebase ID tokens for API authentication

#### Firebase Configuration (`client/src/lib/firebase.ts`)
```typescript
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  // ... other config
};
```

#### Backend Authentication (`server/auth/firebase.ts`)
- **Token Verification**: Firebase Admin SDK verifies ID tokens
- **User Sync**: Automatically syncs Firebase users to PostgreSQL
- **Middleware**: `requireFirebaseAuth` middleware for protected routes
- **Token Sources**: Authorization header (`Bearer <token>`) or cookies

### 2. Calendar Authentication (Direct Google OAuth)

#### Google OAuth Implementation (`server/google-oauth.ts`)
- **Provider**: Direct Google OAuth 2.0
- **Scopes**: Calendar read/write, user profile, email
- **Flow**: Standard OAuth 2.0 authorization code flow
- **Token Storage**: Encrypted access/refresh tokens in PostgreSQL

#### OAuth Configuration
```typescript
const oauth2Client = new OAuth2Client(
  process.env.GOOGLE_CLIENT_ID,
  process.env.GOOGLE_CLIENT_SECRET,
  `${process.env.BASE_URL}/api/auth/google/callback`
);
```

## Authentication Flows

### User Login Flow
1. **Frontend**: User clicks "Sign In" → Firebase Auth popup
2. **Firebase**: User authenticates with Google or email/password
3. **Frontend**: Receives Firebase ID token
4. **Backend**: `/api/auth/user` endpoint verifies token via Firebase Admin SDK
5. **Database**: User record created/updated in PostgreSQL
6. **Sync**: User profile synced to Neo4j knowledge graph

### Calendar Connection Flow
1. **Frontend**: User clicks "Connect Google Account" in settings or meetings
2. **Backend**: `/api/auth/google` generates OAuth URL with user ID in state
3. **Frontend**: Opens OAuth popup window
4. **Google**: User grants calendar permissions
5. **Backend**: `/api/auth/google/callback` exchanges code for tokens
6. **Database**: Calendar account stored with encrypted tokens
7. **Frontend**: Popup closes, calendar accounts refreshed

## Database Schema

### User Authentication Tables
```sql
-- Firebase users synced to PostgreSQL
users (
  id: varchar (Firebase UID),
  email: text,
  display_name: text,
  photo_url: text,
  email_verified: boolean,
  created_at: timestamp,
  updated_at: timestamp
)

-- App-specific user profiles
user_profiles (
  id: uuid,
  user_id: varchar (references users.id),
  relationship_mode: text,
  is_onboarded: boolean
)
```

### Calendar Authentication Tables
```sql
-- Google Calendar OAuth accounts
calendar_accounts (
  id: uuid,
  user_id: varchar (references users.id),
  provider: text ('google'),
  account_email: text,
  account_label: text,
  access_token: text (encrypted),
  refresh_token: text (encrypted),
  token_expires_at: timestamp,
  is_enabled: boolean,
  enabled_calendars: text (JSON array),
  metadata: text (JSON),
  created_at: timestamp
)
```

## API Endpoints

### User Authentication
- `GET /api/auth/user` - Get current authenticated user (requires Firebase token)
- `PATCH /api/users/:id/relationship-mode` - Update user relationship mode

### Calendar Authentication
- `GET /api/auth/google` - Initiate Google OAuth flow (requires Firebase auth)
- `GET /api/auth/google/callback` - Handle OAuth callback (public endpoint)
- `GET /api/calendar/accounts` - List user's calendar accounts
- `GET /api/calendar/connected` - Check calendar connection status

## Security Implementation

### Token Management
- **Firebase ID Tokens**: Short-lived (1 hour), automatically refreshed by Firebase SDK
- **Google OAuth Tokens**: Access tokens (1 hour), refresh tokens (long-lived)
- **Token Storage**: OAuth tokens encrypted at rest in PostgreSQL
- **Token Refresh**: Automatic refresh before API calls when expired

### Authentication Middleware
```typescript
export const requireFirebaseAuth: RequestHandler = async (req, res, next) => {
  const token = extractToken(req); // From Authorization header or cookies
  const decoded = await admin.auth().verifyIdToken(token, true);
  await syncUser(decoded); // Sync to PostgreSQL
  req.user = { id: decoded.uid, email: decoded.email, ... };
  next();
};
```

### User Data Isolation
- All API endpoints scoped to authenticated user ID
- Calendar accounts linked to specific user IDs
- No cross-user data access possible
- User-specific OAuth tokens

## Environment Variables

### Firebase Authentication
```bash
# Backend (Firebase Admin SDK)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_CLIENT_EMAIL=service-account@project.iam.gserviceaccount.com
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"

# Frontend (Firebase Client SDK)
VITE_FIREBASE_API_KEY=your-api-key
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=1:123456789:web:abcdef123456
```

### Google Calendar OAuth
```bash
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
BASE_URL=http://localhost:5000 # For OAuth redirect URI
```

## Configuration Modes

### Hybrid Mode (Current)
- **User Auth**: Firebase Authentication
- **Calendar Auth**: Direct Google OAuth
- **AI**: Local rule-based or Ollama
- **Storage**: PostgreSQL

### Cloud Mode
- **User Auth**: Firebase Authentication
- **Calendar Auth**: Direct Google OAuth
- **AI**: Gemini via Google AI SDK
- **Storage**: Managed PostgreSQL

### Local Mode
- **User Auth**: Firebase Authentication (still cloud-based)
- **Calendar Auth**: Direct Google OAuth (still requires Google)
- **AI**: Ollama (fully local)
- **Storage**: Local PostgreSQL

## Security Considerations

### Frontend State
```typescript
interface AuthContextType {
  user: ContinuumUser | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  isOnboarded: boolean;
  relationshipMode: RelationshipMode;
  logout: () => Promise<void>;
  completeOnboarding: (mode: RelationshipMode) => void;
}
```

### State Persistence
- **Firebase Auth State**: Managed by Firebase SDK
- **User Profile**: Synced to backend on auth state changes
- **Onboarding State**: Stored in localStorage + backend
- **Settings**: Stored in localStorage (not yet synced to backend)

## Error Handling

### Authentication Errors
- **401 Unauthorized**: Invalid or expired Firebase token
- **403 Forbidden**: Valid token but insufficient permissions
- **OAuth Errors**: Handled with user-friendly messages and retry options

### Token Refresh
- **Firebase**: Automatic refresh by Firebase SDK
- **Google OAuth**: Manual refresh before API calls when expired
- **Failure Handling**: Graceful degradation, user re-authentication prompts

## Security Considerations

### Data Protection
- OAuth tokens encrypted at rest
- User data scoped to authenticated user
- No cross-user data leakage possible
- Secure session management

### OAuth Security
- State parameter prevents CSRF attacks
- Secure redirect URI validation
- Proper scope limitation (calendar read/write only)
- Token expiration and refresh handling

## Future Enhancements

### Planned Improvements
- Settings sync to backend (currently localStorage only)
- Webhook-based real-time calendar sync
- Enhanced token refresh error handling
- Multi-provider calendar support (Microsoft Graph)

### Security Enhancements
- Token rotation policies
- Enhanced audit logging
- Rate limiting on auth endpoints
- Advanced session management

## Troubleshooting

### Common Issues
1. **"access_token column missing"**: Database schema out of sync, run `npm run db:push`
2. **OAuth popup blocked**: Browser popup blocker, user needs to allow popups
3. **Token expired**: Automatic refresh should handle, check refresh token validity

### Debug Commands
```bash
# Check database schema
docker exec continuum-postgres psql -U continuum -d continuum -c "\d calendar_accounts"

# Check environment variables
echo $GOOGLE_CLIENT_ID
echo $FIREBASE_PROJECT_ID

# Check server logs for auth errors
grep -i "auth\|oauth" server.log
```

## Confirmation: Clean Implementation

**Confirmed**: Continuum uses a clean, modern authentication architecture:
1. **Firebase Auth** for user authentication (direct integration)
2. **Google OAuth 2.0** for calendar access (direct integration)
3. **PostgreSQL** for data storage (local or managed)

The application is now free of any external platform dependencies and uses industry-standard authentication patterns.
