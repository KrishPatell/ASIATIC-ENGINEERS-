#!/bin/bash
# Script to push to GitHub using a Personal Access Token

cd "$(dirname "$0")"

echo "🚀 Pushing to GitHub with token..."
echo ""

# Prompt for username and token if not provided
if [ -z "$GITHUB_USERNAME" ]; then
    read -p "Enter your GitHub username: " GITHUB_USERNAME
fi

if [ -z "$GITHUB_TOKEN" ]; then
    read -sp "Enter your GitHub Personal Access Token: " GITHUB_TOKEN
    echo ""
fi

# Update remote URL to include credentials
git remote set-url origin https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/KrishPatell/ASIATIC-ENGINEERS-.git

echo "📦 Pushing commits..."
git push -u origin main

# Restore original remote URL (without token)
git remote set-url origin https://github.com/KrishPatell/ASIATIC-ENGINEERS-.git

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo "🔄 Vercel will automatically deploy your changes in 1-2 minutes"
    echo ""
    echo "Check deployment at: https://vercel.com/dashboard"
else
    echo ""
    echo "❌ Push failed. Please check your credentials."
fi
