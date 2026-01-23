# Desktop App Template

This is a specialized Kiro CLI template for desktop app projects.

## Installation

From your project root:
```bash
git clone https://github.com/trezero/kiroTemplate.git temp
cd temp
./templates/desktop-app/install-kiro-template.sh
cd ..
rm -rf temp
```

## Customizations

This template includes:
- **Window management** - Multi-window applications, dialogs, menus
- **Desktop integration** - System tray, notifications, file associations
- **Native features** - File system access, system APIs, auto-updates
- **Cross-platform support** - Windows, macOS, Linux compatibility
- **MCP Servers** - Context7, Vercel Agent-Browser, Desktop tools

## Specialized Agents

- `window-management` - Handle application windows, dialogs, and layouts
- `desktop-integration` - System integration and native desktop features
- `native-features` - File system, notifications, and system APIs
- `cross-platform` - Platform-specific optimizations and compatibility
- `desktop-testing` - Automated testing for desktop applications

## Technology Support

- **Frameworks:** Electron, Tauri, Flutter Desktop, .NET MAUI
- **UI Libraries:** React, Vue, Svelte, WPF, Qt
- **Build Tools:** Electron Builder, Tauri CLI, Flutter Desktop
- **Distribution:** App stores, direct download, auto-updaters
- **Testing:** Spectron, WebDriver, Flutter Desktop testing
