#!/bin/bash

echo "=========================================="
echo "  View Old Website - Options"
echo "=========================================="
echo ""
echo "Choose an option:"
echo ""
echo "1. View cached/saved HTML files (from *_files folders)"
echo "   - These are saved versions of your live website"
echo "   - Open: home page_files/home page.html in your browser"
echo ""
echo "2. Checkout an older git commit"
echo "   - This will temporarily revert your files to an older version"
echo "   - Recommended commit: 1b607e9 (before recent fixes)"
echo ""
echo "3. Create a comparison branch"
echo "   - Creates a separate branch with old code for comparison"
echo ""
echo "4. Start local server to view current version"
echo ""
read -p "Enter option (1-4): " choice

case $choice in
    1)
        echo ""
        echo "Opening cached HTML files..."
        echo "You can open these files directly in your browser:"
        echo "  - home page_files/home page.html"
        echo "  - about page_files/about page.html"
        echo "  - SERVICE PAGE_files/SERVICE PAGE.html"
        echo ""
        echo "Note: Some assets may not load correctly as paths are relative."
        echo "To fix this, you can:"
        echo "  cd 'home page_files' && python3 -m http.server 8001"
        echo "  Then open: http://localhost:8001/home%20page.html"
        ;;
    2)
        echo ""
        echo "Available commits (most recent first):"
        git log --oneline -15
        echo ""
        read -p "Enter commit hash to checkout (or press Enter for 1b607e9): " commit_hash
        commit_hash=${commit_hash:-1b607e9}
        echo ""
        echo "Checking out commit: $commit_hash"
        echo "WARNING: This will modify your files. Make sure you've committed or stashed changes."
        read -p "Continue? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            git checkout $commit_hash
            echo ""
            echo "Done! Your files are now at commit $commit_hash"
            echo "To return to latest: git checkout main"
        else
            echo "Cancelled."
        fi
        ;;
    3)
        echo ""
        echo "Creating comparison branch from commit 1b607e9..."
        git checkout -b old-website-comparison 1b607e9
        echo ""
        echo "Created branch 'old-website-comparison' with old code."
        echo "Switch between branches:"
        echo "  git checkout main          (current/new version)"
        echo "  git checkout old-website-comparison  (old version)"
        ;;
    4)
        echo ""
        echo "Starting local server on http://localhost:8000"
        echo "Press Ctrl+C to stop"
        python3 -m http.server 8000
        ;;
    *)
        echo "Invalid option"
        ;;
esac
