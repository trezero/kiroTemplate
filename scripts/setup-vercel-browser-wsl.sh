#!/bin/bash

# Automated Vercel Agent-Browser Setup for WSL
# Handles all the complex WSL-specific configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running in WSL
if ! grep -q Microsoft /proc/version 2>/dev/null; then
    print_error "This script is designed for WSL environments"
    exit 1
fi

print_status "🚀 Setting up Vercel agent-browser for WSL..."

# 1. Install system dependencies
print_status "📦 Installing system dependencies..."
sudo apt update
sudo apt install -y x11-apps xvfb curl wget gnupg

# 2. Install Chrome
print_status "🌐 Installing Google Chrome..."
if ! command -v google-chrome-stable &> /dev/null; then
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y google-chrome-stable
    print_success "Chrome installed"
else
    print_success "Chrome already installed"
fi

# 3. Setup X11 forwarding
print_status "🖥️ Configuring X11 forwarding..."
if ! grep -q "export DISPLAY=:0" ~/.bashrc; then
    echo "export DISPLAY=:0" >> ~/.bashrc
    echo "export LIBGL_ALWAYS_INDIRECT=1" >> ~/.bashrc
fi
export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1

# 4. Install agent-browser
print_status "🤖 Installing Vercel agent-browser..."
npm install -g @vercel/agent-browser

# 5. Create helper scripts
print_status "📝 Creating helper scripts..."

# Browser launcher
mkdir -p ~/.local/bin
cat > ~/.local/bin/browser-launcher << 'EOF'
#!/bin/bash
export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1

if ! xset q &>/dev/null; then
    echo "❌ X11 server not running! Please start VcXsrv on Windows first."
    echo "Download: https://sourceforge.net/projects/vcxsrv/"
    exit 1
fi

google-chrome-stable \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --remote-debugging-port=9222 \
    --user-data-dir=/tmp/chrome-agent-browser \
    "$@"
EOF
chmod +x ~/.local/bin/browser-launcher

# Authentication session manager
cat > ~/.local/bin/auth-session << 'EOF'
#!/bin/bash
PROJECT_NAME=${1:-"default"}
AUTH_DIR="$HOME/.agent-browser-auth/$PROJECT_NAME"
mkdir -p "$AUTH_DIR"

echo "🔐 Starting authentication session for: $PROJECT_NAME"
export DISPLAY=:0

google-chrome-stable \
    --no-sandbox \
    --disable-dev-shm-usage \
    --remote-debugging-port=9222 \
    --user-data-dir="$AUTH_DIR" \
    --disable-web-security \
    "http://localhost:3000" &

CHROME_PID=$!
echo "🌐 Browser launched (PID: $CHROME_PID)"
echo "📋 Complete your login, then press ENTER..."
read -p "Authentication complete? "
echo "✅ Session saved! Agent-browser can now use this authenticated session."
EOF
chmod +x ~/.local/bin/auth-session

# VcXsrv startup script for Windows
cat > ~/start-vcxsrv.bat << 'EOF'
@echo off
echo Starting VcXsrv for WSL browser support...
"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl
pause
EOF

# 6. Create test script
cat > ~/.local/bin/test-browser-setup << 'EOF'
#!/bin/bash
echo "🧪 Testing agent-browser setup..."

# Test X11
if xset q &>/dev/null; then
    echo "✅ X11 forwarding working"
else
    echo "❌ X11 forwarding failed - start VcXsrv on Windows"
    exit 1
fi

# Test Chrome
if google-chrome-stable --version &>/dev/null; then
    echo "✅ Chrome installed: $(google-chrome-stable --version)"
else
    echo "❌ Chrome not working"
    exit 1
fi

# Test agent-browser
if npx @vercel/agent-browser --version &>/dev/null; then
    echo "✅ Agent-browser installed"
else
    echo "❌ Agent-browser not found"
    exit 1
fi

echo "🎉 Setup complete and working!"
EOF
chmod +x ~/.local/bin/test-browser-setup

# 7. Update PATH
if ! grep -q "$HOME/.local/bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

print_success "🎉 Vercel agent-browser setup complete!"
print_status "📋 Next steps:"
echo "1. Install VcXsrv on Windows: https://sourceforge.net/projects/vcxsrv/"
echo "2. Run ~/start-vcxsrv.bat on Windows"
echo "3. Restart your WSL terminal: source ~/.bashrc"
echo "4. Test setup: test-browser-setup"
echo "5. Start auth session: auth-session your-project-name"
echo "6. Use with Kiro: kiro-cli --agent vercel-browser"

print_warning "⚠️ Remember to start VcXsrv on Windows before using the browser!"
