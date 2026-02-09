#!/bin/bash
# Script to push changes to GitHub

cd "$(dirname "$0")"

echo "🚀 Pushing changes to GitHub..."
echo ""

# Check if there are changes to push
if git log origin/main..HEAD --oneline > /dev/null 2>&1; then
    echo "📦 Commits to push:"
    git log origin/main..HEAD --oneline
    echo ""
    
    echo "Pushing to GitHub..."
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo "🔄 Vercel will automatically deploy your changes in 1-2 minutes"
        echo ""
        echo "Check your deployment at: https://vercel.com/dashboard"
    else
        echo ""
        echo "❌ Push failed. Please check your GitHub credentials."
        echo "You may need to:"
        echo "1. Enter your GitHub username"
        echo "2. Use a Personal Access Token as password (not your GitHub password)"
        echo ""
        echo "Get a token at: https://github.com/settings/tokens"
    fi
else
    echo "✅ Everything is already up to date!"
fi
