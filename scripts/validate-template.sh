#!/bin/bash

# Template Validation Script
# Validates agent architecture and structure

echo "🔍 Validating Kiro Template Architecture..."

# Check if .kiro directory exists
if [ ! -d ".kiro" ]; then
    echo "❌ .kiro directory not found - run from project root with installed template"
    exit 1
fi

# Check agent character limits
echo "📊 Checking agent character limits..."
cd .kiro/agents
for file in *.json; do
    if [ -f "$file" ]; then
        chars=$(wc -c < "$file")
        if [ $chars -gt 3000 ]; then
            echo "❌ $file: $chars characters (OVER LIMIT)"
        else
            echo "✅ $file: $chars characters"
        fi
    fi
done

# Validate JSON syntax
echo "🔧 Validating JSON syntax..."
for file in *.json; do
    if [ -f "$file" ]; then
        if python3 -m json.tool "$file" > /dev/null 2>&1; then
            echo "✅ $file: Valid JSON"
        else
            echo "❌ $file: Invalid JSON"
        fi
    fi
done

# Check directory structure
echo "📁 Checking directory structure..."
cd ..
required_dirs=("agents" "steering" "docs" "prompts" "patterns" "settings")
for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir/ directory exists"
    else
        echo "❌ $dir/ directory missing"
    fi
done

echo "🎉 Validation complete!"
