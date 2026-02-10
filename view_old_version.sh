#!/bin/bash

echo "=========================================="
echo "  View Old Website Version"
echo "=========================================="
echo ""

# Create old_version directory
if [ ! -d "old_version" ]; then
    echo "📦 Extracting old version (commit 1b607e9)..."
    mkdir -p old_version
    git archive 1b607e9 | tar -x -C old_version/
    echo "✓ Old version ready!"
else
    echo "✓ Old version already exists"
fi

echo ""
echo "🚀 Starting server for OLD VERSION..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📱 OLD VERSION: http://localhost:8000"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To view NEW VERSION, open another terminal and run:"
echo "  python3 -m http.server 8001"
echo ""
echo "Press Ctrl+C to stop server"
echo ""

cd old_version
python3 -m http.server 8000
