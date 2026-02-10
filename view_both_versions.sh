#!/bin/bash

echo "=========================================="
echo "  View Both Website Versions"
echo "=========================================="
echo ""
echo "This script helps you view OLD and NEW versions side by side"
echo ""

# Check if old version directory exists
if [ ! -d "old_version" ]; then
    echo "Creating old version directory..."
    mkdir -p old_version
    cd old_version
    git init
    git remote add origin ../.git 2>/dev/null || true
    git fetch origin
    git checkout 1b607e9 -- .
    cd ..
    echo "✓ Old version prepared"
fi

echo ""
echo "Starting servers..."
echo ""
echo "📱 OLD VERSION: http://localhost:8000"
echo "📱 NEW VERSION: http://localhost:8001"
echo ""
echo "Press Ctrl+C to stop both servers"
echo ""

# Start old version server in background
cd old_version
python3 -m http.server 8000 > /dev/null 2>&1 &
OLD_PID=$!
cd ..

# Start new version server
python3 -m http.server 8001 &
NEW_PID=$!

# Wait for user interrupt
trap "kill $OLD_PID $NEW_PID 2>/dev/null; exit" INT TERM

wait
