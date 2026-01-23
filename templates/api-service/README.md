# API Service Template

This is a specialized Kiro CLI template for API service projects.

## Installation

From your project root:
```bash
git clone https://github.com/trezero/kiroTemplate.git temp
cd temp
./templates/api-service/install-kiro-template.sh
cd ..
rm -rf temp
```

## Customizations

This template includes:
- **Endpoint management** - REST API CRUD operations and routing
- **Request workflow** - Authentication, validation, middleware
- **Database integration** - ORM setup, migrations, query optimization
- **API documentation** - OpenAPI/Swagger generation and testing
- **MCP Servers** - Context7, Database tools, Vercel Agent-Browser

## Specialized Agents

- `endpoint-management` - Create and manage API endpoints
- `request-workflow` - Handle authentication, validation, error handling
- `database-management` - Database operations, migrations, optimization
- `api-documentation` - Generate and maintain API documentation
- `api-testing` - Automated testing for endpoints and integration

## Technology Support

- **Backend:** Express.js, FastAPI, Django, Flask, Spring Boot, Rails
- **Databases:** PostgreSQL, MySQL, MongoDB, Redis, SQLite
- **Authentication:** JWT, OAuth, Passport.js, Auth0
- **Testing:** Jest, pytest, Postman, Insomnia
- **Documentation:** Swagger/OpenAPI, Redoc, API Blueprint
