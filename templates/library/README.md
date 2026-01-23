# Library Template

This is a specialized Kiro CLI template for library/package projects.

## Installation

From your project root:
```bash
git clone https://github.com/trezero/kiroTemplate.git temp
cd temp
./templates/library/install-kiro-template.sh
cd ..
rm -rf temp
```

## Customizations

This template includes:
- **Package management** - Build, versioning, and distribution setup
- **API design** - Public interface design and documentation
- **Testing framework** - Unit tests, integration tests, benchmarks
- **Documentation generation** - API docs, examples, tutorials
- **MCP Servers** - Context7, Package registry tools

## Specialized Agents

- `package-management` - Handle build processes, versioning, publishing
- `api-design` - Design and maintain public APIs and interfaces
- `testing-framework` - Create comprehensive test suites and benchmarks
- `documentation` - Generate and maintain library documentation
- `compatibility` - Ensure cross-platform and version compatibility

## Technology Support

- **Languages:** JavaScript/TypeScript, Python, Rust, Go, Java
- **Package Managers:** npm, PyPI, crates.io, Go modules, Maven
- **Build Tools:** Rollup, Webpack, setuptools, Cargo, Gradle
- **Testing:** Jest, pytest, cargo test, Go test, JUnit
- **Documentation:** JSDoc, Sphinx, rustdoc, godoc, Javadoc
