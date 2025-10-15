#!/bin/bash

# Quick GitHub Setup Script
echo "🚀 Quick GitHub Setup for Yoruba Voice Speech Recorder"

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI found. Using it for setup..."
    
    # Create repository using GitHub CLI
    echo "Creating GitHub repository..."
    gh repo create yoruba-voice-speech-recorder --public --description "Record and preserve Yoruba language voice samples for research and education"
    
    # Add remote and push
    git remote add origin https://github.com/$(gh api user --jq .login)/yoruba-voice-speech-recorder.git
    git branch -M main
    git push -u origin main
    
    echo "✅ Repository created and pushed!"
    echo "🌐 Repository URL: https://github.com/$(gh api user --jq .login)/yoruba-voice-speech-recorder"
    echo ""
    echo "📋 Next steps:"
    echo "1. Go to your repository on GitHub"
    echo "2. Create a release with the files from desktop-distribution/github-pages-clean/releases/"
    echo "3. Enable GitHub Pages in Settings > Pages"
    echo "4. Update URLs in the website files"
    
else
    echo "❌ GitHub CLI not found. Please follow manual setup in GITHUB_SETUP.md"
    echo ""
    echo "To install GitHub CLI:"
    echo "  brew install gh  # macOS"
    echo "  # or visit: https://cli.github.com/"
fi
