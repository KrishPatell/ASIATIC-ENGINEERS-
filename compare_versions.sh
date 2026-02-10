#!/bin/bash

echo "=========================================="
echo "  Compare Old vs New Website"
echo "=========================================="
echo ""

# Create old_version directory if it doesn't exist
if [ ! -d "old_version" ]; then
    echo "📦 Setting up old version..."
    mkdir -p old_version
    cd old_version
    
    # Copy all files from old commit
    git init > /dev/null 2>&1
    cd ..
    
    # Use git archive to extract old version
    git archive 1b607e9 | tar -x -C old_version/
    echo "✓ Old version extracted"
else
    echo "✓ Old version directory already exists"
fi

echo ""
echo "🚀 Starting servers..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📱 OLD VERSION: http://localhost:8000"
echo "  📱 NEW VERSION: http://localhost:8001"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Open both URLs in your browser to compare!"
echo "Press Ctrl+C to stop servers"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Stopping servers..."
    kill $OLD_PID $NEW_PID 2>/dev/null
    exit
}

trap cleanup INT TERM

# Start old version server
cd old_version
python3 -m http.server 8000 > /tmp/old_server.log 2>&1 &
OLD_PID=$!
cd ..

# Start new version server  
python3 -m http.server 8001 > /tmp/new_server.log 2>&1 &
NEW_PID=$!

# Wait for interrupt
wait
