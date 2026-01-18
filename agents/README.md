# New Agents Quick Reference

## API Testing Agent (`api-testing`)

### When to Use
- Generating Postman collections for API endpoints
- Creating automated tests for API routes
- Identifying missing test coverage
- Validating request/response schemas

### Key Commands
```bash
# Start the agent
kiro-cli --agent api-testing

# Example tasks
> Generate Postman collection for all calendar endpoints
> Create integration tests for task management API
> Identify endpoints without test coverage
> Generate environment file for Postman testing
```

### What It Can Do
- ✅ Auto-generate Postman collections from `server/routes.ts`
- ✅ Create Jest/Vitest test files with proper structure
- ✅ Add test scripts for response validation
- ✅ Generate environment variables for testing
- ✅ Identify gaps in test coverage

### Resources It Uses
- `server/routes.ts` - API endpoint definitions
- `server/__tests__/**/*.test.ts` - Existing test patterns
- Postman collection examples
- Testing documentation

---

## Calendar Integration Specialist (`calendar-integration`)

### When to Use
- Working with Google Calendar or Microsoft Outlook APIs
- Debugging OAuth flows or token issues
- Fixing timezone conversion problems
- Handling multi-account calendar scenarios
- Troubleshooting missing or incorrect events

### Key Commands
```bash
# Start the agent
kiro-cli --agent calendar-integration

# Example tasks
> Debug why events from certain organizers are missing
> Fix timezone display issues for Microsoft events
> Generate Postman collection for calendar API testing
> Add support for calendar event creation
> Test OAuth token refresh flow
```

### What It Can Do
- ✅ Implement OAuth 2.0 flows for Google and Microsoft
- ✅ Debug event synchronization issues
- ✅ Handle timezone conversions properly
- ✅ Generate calendar API test collections
- ✅ Fix recurring event expansion
- ✅ Validate event metadata and grouping
- ✅ Test multi-account scenarios

### Critical Knowledge
**Always uses:**
- `/me/calendarView` for Microsoft (NOT `/me/events`)
- `singleEvents: true` for Google recurring events
- `Prefer: outlook.timezone` header for Microsoft
- Account metadata on all events

### Resources It Uses
- `server/google-oauth.ts` - Google Calendar implementation
- `server/microsoft-oauth.ts` - Microsoft Graph implementation
- `.kiro/steering/common-pitfalls.md` - Known issues and solutions
- `.kiro/steering/calendarIntegration.md` - Integration guide
- Postman testing collections

---

## Quick Comparison

| Feature | API Testing | Calendar Integration |
|---------|-------------|---------------------|
| **Primary Focus** | Test generation | Calendar APIs |
| **Generates Tests** | ✅ Yes | ✅ Yes (calendar-specific) |
| **Generates Postman** | ✅ Yes (all APIs) | ✅ Yes (calendar APIs) |
| **OAuth Expertise** | ❌ No | ✅ Yes |
| **Timezone Handling** | ❌ No | ✅ Yes |
| **Multi-Provider** | ❌ No | ✅ Yes (Google + Microsoft) |

---

## Usage Examples

### Generate Postman Collection for New Feature
```bash
# Use API testing agent for general endpoints
kiro-cli --agent api-testing
> Generate Postman collection for the new focus session endpoints

# Use calendar integration for calendar endpoints
kiro-cli --agent calendar-integration
> Generate Postman collection for calendar event creation
```

### Debug Calendar Issues
```bash
kiro-cli --agent calendar-integration
> Events from Iva Kalova are not showing up
> Timezone is wrong for Microsoft events
> Recurring events are not expanding properly
```

### Create Test Suite
```bash
# General API tests
kiro-cli --agent api-testing
> Create integration tests for task management endpoints

# Calendar-specific tests
kiro-cli --agent calendar-integration
> Create OAuth flow tests for Google and Microsoft
```

---

## Tips

### API Testing Agent
- Provide endpoint details for better test generation
- Specify authentication requirements
- Mention edge cases to test
- Reference existing test patterns

### Calendar Integration Agent
- Always mention which provider (Google/Microsoft)
- Include timezone information if relevant
- Describe the expected vs actual behavior
- Reference common-pitfalls.md for known issues

---

## Related Documentation

- **Common Pitfalls**: `.kiro/steering/common-pitfalls.md`
- **Calendar Integration**: `.kiro/steering/calendarIntegration.md`
- **All Agents**: `.kiro/steering/agents.md`
- **Testing Guide**: `MICROSOFT_GRAPH_TESTING.md`
