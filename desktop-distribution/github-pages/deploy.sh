#!/bin/bash

# GitHub Pages Deployment Script
echo "🚀 Deploying to GitHub Pages..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit"
fi

# Add all files
git add .

# Commit changes
git commit -m "Update Yoruba Voice Recorder website"

# Push to GitHub (replace with your repository URL)
echo "Pushing to GitHub..."
echo "Please update the remote URL in this script with your GitHub repository URL"
echo "Example: git remote add origin https://github.com/yourusername/your-repo.git"
echo "Then run: git push -u origin main"

# Uncomment and update these lines with your repository details:
# git remote add origin https://github.com/yourusername/your-repo.git
# git branch -M main
# git push -u origin main

echo "✅ Deployment script ready!"
echo "Update the repository URL and run the git commands to deploy."
