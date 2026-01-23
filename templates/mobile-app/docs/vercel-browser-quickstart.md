# Vercel Agent-Browser Quick Start

## One-Command Setup for WSL

```bash
# Download and run the automated setup
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/setup-vercel-browser-wsl.sh | bash
```

## Manual Setup Steps

### 1. Windows Prerequisites
```powershell
# Install VcXsrv (X11 server for Windows)
# Download from: https://sourceforge.net/projects/vcxsrv/
# Or use winget:
winget install VcXsrv
```

### 2. WSL Setup
```bash
# Run the setup script
./scripts/setup-vercel-browser-wsl.sh

# Or install manually:
sudo apt update && sudo apt install -y x11-apps google-chrome-stable
npm install -g @vercel/agent-browser
```

### 3. Start X11 Server
```bash
# On Windows, run:
~/start-vcxsrv.bat

# Or manually start VcXsrv with these settings:
# - Display number: 0
# - Multiple windows
# - Start no client
# - Disable access control
```

### 4. Test Setup
```bash
# Test the installation
test-browser-setup

# Should show:
# ✅ X11 forwarding working
# ✅ Chrome installed
# ✅ Agent-browser installed
# 🎉 Setup complete and working!
```

## Authentication Workflow

### For Projects Requiring Login

```bash
# 1. Start your development server
npm run dev

# 2. Start authenticated browser session
auth-session my-project-name

# 3. Complete login in the browser that opens
# 4. Press ENTER when authentication is complete
# 5. Session is saved for agent-browser to reuse

# 6. Use with Kiro CLI
kiro-cli --agent vercel-browser
```

### Example Usage
```bash
# Navigate and interact
agent-browser open "http://localhost:3000"
agent-browser click "Login"
agent-browser fill "email" "user@example.com"
agent-browser screenshot

# Use authenticated session
agent-browser --user-data-dir="$HOME/.agent-browser-auth/my-project"
```

## Troubleshooting

### Common Issues

#### "Cannot open display" Error
```bash
# Check X11 setup
echo $DISPLAY  # Should show :0
xset q         # Should show X server info

# Fix:
export DISPLAY=:0
# Restart VcXsrv on Windows
```

#### Chrome Won't Start
```bash
# Test Chrome directly
google-chrome-stable --no-sandbox --version

# If fails, reinstall:
sudo apt remove google-chrome-stable
sudo apt install google-chrome-stable
```

#### Authentication Not Working
```bash
# Clear old sessions
rm -rf ~/.agent-browser-auth/my-project

# Start fresh auth session
auth-session my-project-name
```

## Integration with Kiro CLI

The vercel-browser agent is pre-configured to work with WSL and handle authentication flows automatically. It includes:

- ✅ WSL-specific browser launching
- ✅ X11 forwarding support
- ✅ Authentication session management
- ✅ Persistent user data directories
- ✅ Error handling and troubleshooting

Just run `kiro-cli --agent vercel-browser` after setup!
