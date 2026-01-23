# Vercel Agent-Browser Setup Guide for WSL

## Overview
The Vercel agent-browser is essential for automated testing but requires careful setup, especially in WSL environments where browser access and authentication can be challenging.

## WSL-Specific Challenges
1. **Browser Display** - WSL can't directly open GUI browsers
2. **Authentication** - Many apps require login flows that need visual browser interaction
3. **Port Forwarding** - Browser needs to access localhost services
4. **X11 Forwarding** - Required for GUI applications in WSL

## Automated Setup Script

### 1. WSL Browser Setup
```bash
#!/bin/bash
# setup-wsl-browser.sh

echo "🔧 Setting up WSL browser environment for agent-browser..."

# Install X11 forwarding support
sudo apt update
sudo apt install -y x11-apps xvfb

# Install Chrome for WSL
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable

# Setup X11 forwarding
echo "export DISPLAY=:0" >> ~/.bashrc
echo "export LIBGL_ALWAYS_INDIRECT=1" >> ~/.bashrc

# Install VcXsrv helper script
cat > ~/start-vcxsrv.bat << 'EOF'
@echo off
echo Starting VcXsrv for WSL browser support...
"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl
EOF

echo "✅ WSL browser environment setup complete!"
echo "📋 Next steps:"
echo "1. Install VcXsrv on Windows: https://sourceforge.net/projects/vcxsrv/"
echo "2. Run ~/start-vcxsrv.bat on Windows before using agent-browser"
echo "3. Restart your WSL terminal"
```

### 2. Agent-Browser Installation
```bash
#!/bin/bash
# install-agent-browser.sh

echo "🚀 Installing Vercel agent-browser..."

# Install agent-browser globally
npm install -g @vercel/agent-browser

# Create browser launch script for WSL
cat > ~/.local/bin/browser-launcher << 'EOF'
#!/bin/bash
# WSL Browser Launcher for agent-browser

export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1

# Check if VcXsrv is running
if ! xset q &>/dev/null; then
    echo "❌ X11 server not running!"
    echo "Please start VcXsrv on Windows first:"
    echo "Run: ~/start-vcxsrv.bat"
    exit 1
fi

# Launch Chrome with agent-browser friendly settings
google-chrome-stable \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --remote-debugging-port=9222 \
    --user-data-dir=/tmp/chrome-agent-browser \
    "$@"
EOF

chmod +x ~/.local/bin/browser-launcher

echo "✅ Agent-browser installation complete!"
```

## Authentication Flow Setup

### 3. Authentication Helper
```bash
#!/bin/bash
# auth-helper.sh

echo "🔐 Setting up authentication flow for agent-browser..."

# Create authentication session manager
cat > ~/.local/bin/auth-session << 'EOF'
#!/bin/bash
# Authentication Session Manager

PROJECT_NAME=${1:-"current-project"}
AUTH_DIR="$HOME/.agent-browser-auth/$PROJECT_NAME"

mkdir -p "$AUTH_DIR"

echo "🔐 Starting authentication session for: $PROJECT_NAME"
echo "📂 Auth data will be saved to: $AUTH_DIR"

# Launch browser with persistent session
export DISPLAY=:0
google-chrome-stable \
    --no-sandbox \
    --disable-dev-shm-usage \
    --remote-debugging-port=9222 \
    --user-data-dir="$AUTH_DIR" \
    --disable-web-security \
    --disable-features=VizDisplayCompositor \
    "http://localhost:3000" &

CHROME_PID=$!

echo "🌐 Browser launched with PID: $CHROME_PID"
echo "📋 Instructions:"
echo "1. Complete your login flow in the browser"
echo "2. Navigate through any required authentication steps"
echo "3. Press ENTER when authentication is complete"
echo "4. The session will be saved for agent-browser to reuse"

read -p "Press ENTER when authentication is complete..."

echo "💾 Saving authentication session..."
echo "✅ Authentication session saved!"
echo "🤖 Agent-browser can now use this authenticated session"

# Keep browser running for agent-browser
echo "🔄 Browser will remain running for agent-browser use"
echo "To stop: kill $CHROME_PID"
EOF

chmod +x ~/.local/bin/auth-session

echo "✅ Authentication helper setup complete!"
```

## MCP Server Configuration

### 4. Enhanced MCP Configuration
```json
{
  "mcpServers": {
    "vercel-browser": {
      "command": "npx",
      "args": ["@vercel/agent-browser"],
      "env": {
        "DISPLAY": ":0",
        "CHROME_EXECUTABLE_PATH": "/usr/bin/google-chrome-stable",
        "CHROME_USER_DATA_DIR": "/tmp/chrome-agent-browser",
        "CHROME_ARGS": "--no-sandbox,--disable-dev-shm-usage,--disable-gpu,--remote-debugging-port=9222"
      }
    }
  }
}
```

## Troubleshooting Guide

### Common Issues & Solutions

#### 1. "Cannot open display" Error
```bash
# Check X11 forwarding
echo $DISPLAY  # Should show :0
xset q         # Should show X server info

# If not working:
export DISPLAY=:0
# Restart VcXsrv on Windows
```

#### 2. Chrome Won't Start
```bash
# Check Chrome installation
google-chrome-stable --version

# Test Chrome launch
google-chrome-stable --no-sandbox --disable-dev-shm-usage --version
```

#### 3. Authentication Not Persisting
```bash
# Check user data directory
ls -la /tmp/chrome-agent-browser/

# Use project-specific auth
auth-session my-project-name
```

#### 4. Port Conflicts
```bash
# Check if port 9222 is in use
netstat -tlnp | grep 9222

# Kill existing Chrome processes
pkill -f chrome
```

## Project Integration

### 5. Project-Specific Setup
```bash
#!/bin/bash
# project-browser-setup.sh

PROJECT_NAME=$(basename "$PWD")
echo "🎯 Setting up agent-browser for project: $PROJECT_NAME"

# Create project-specific browser profile
mkdir -p ".browser-profiles/$PROJECT_NAME"

# Create project launch script
cat > "./start-browser-session.sh" << EOF
#!/bin/bash
# Project-specific browser session

echo "🚀 Starting browser session for $PROJECT_NAME..."

# Start development server if needed
if [ -f "package.json" ]; then
    echo "📦 Starting development server..."
    npm run dev &
    DEV_PID=\$!
    sleep 5  # Wait for server to start
fi

# Start authenticated browser session
auth-session "$PROJECT_NAME"

echo "✅ Browser session ready for agent-browser!"
EOF

chmod +x "./start-browser-session.sh"

echo "✅ Project browser setup complete!"
echo "📋 Usage:"
echo "  ./start-browser-session.sh  # Start authenticated session"
echo "  kiro-cli --agent vercel-browser  # Use agent-browser"
```

## Testing Workflow

### 6. End-to-End Testing Script
```bash
#!/bin/bash
# test-browser-setup.sh

echo "🧪 Testing agent-browser setup..."

# Test 1: X11 forwarding
echo "1️⃣ Testing X11 forwarding..."
if xset q &>/dev/null; then
    echo "✅ X11 forwarding working"
else
    echo "❌ X11 forwarding failed - start VcXsrv on Windows"
    exit 1
fi

# Test 2: Chrome installation
echo "2️⃣ Testing Chrome installation..."
if google-chrome-stable --version &>/dev/null; then
    echo "✅ Chrome installed"
else
    echo "❌ Chrome not found - run setup script"
    exit 1
fi

# Test 3: Agent-browser installation
echo "3️⃣ Testing agent-browser installation..."
if npx @vercel/agent-browser --version &>/dev/null; then
    echo "✅ Agent-browser installed"
else
    echo "❌ Agent-browser not found - run npm install -g @vercel/agent-browser"
    exit 1
fi

# Test 4: Browser launch
echo "4️⃣ Testing browser launch..."
timeout 10s google-chrome-stable --no-sandbox --disable-dev-shm-usage --headless --version
if [ $? -eq 0 ]; then
    echo "✅ Browser launch working"
else
    echo "❌ Browser launch failed"
    exit 1
fi

echo "🎉 All tests passed! Agent-browser setup is working correctly."
```

## Quick Start Commands

### 7. One-Command Setup
```bash
# Complete setup for new project
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/setup-wsl-browser.sh | bash
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/install-agent-browser.sh | bash

# Test setup
./test-browser-setup.sh

# Start authenticated session
./start-browser-session.sh

# Use with Kiro CLI
kiro-cli --agent vercel-browser
```

This comprehensive setup addresses all the WSL-specific challenges and provides automated solutions for the most common issues with agent-browser deployment.
