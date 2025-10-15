#!/bin/bash

# GitHub Repository Setup Script
# This script helps you push your local repository to GitHub and set up releases

set -e

echo "🚀 Setting up GitHub repository for Yoruba Voice Speech Recorder..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

echo "📋 Step 1: Checking current Git status..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not a Git repository. Initializing..."
    git init
    git add .
    git commit -m "Initial commit - Yoruba Voice Speech Recorder"
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

echo "📋 Step 2: Creating .gitignore to exclude large files..."

# Create comprehensive .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environment
yorenv/
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Large files (will be hosted on GitHub Releases)
*.dmg
*.app
*.exe
*.msi
*.deb
*.rpm
*.tar.gz
*.zip

# Build artifacts
desktop-distribution/dist/
desktop-distribution/build/
desktop-distribution/app-store-prep/
desktop-distribution/github-pages/releases/
desktop-distribution/github-pages-clean/releases/

# Temporary files
*.tmp
*.temp
*.log

# Playwright
.playwright-mcp/
EOF

echo "📋 Step 3: Adding and committing changes..."

# Add all files except those in .gitignore
git add .

# Commit changes
git commit -m "Add Yoruba Voice Speech Recorder with desktop distribution support

- Cross-platform desktop application (macOS, Windows, Linux)
- PyQt6-based GUI with QML interface
- Audio recording with WebRTC VAD
- Random Yoruba text prompts
- Metadata tracking for research
- Desktop distribution scripts
- GitHub Pages website
- App Store preparation scripts

Features:
- High-quality audio recording
- Yoruba language focus
- Research-oriented data collection
- Cross-platform compatibility
- Professional packaging"

echo "📋 Step 4: Creating GitHub repository setup instructions..."

cat > GITHUB_SETUP.md << 'EOF'
# GitHub Repository Setup Guide

## Step 1: Create GitHub Repository

1. Go to [GitHub.com](https://github.com)
2. Click the **"+"** button → **"New repository"**
3. Repository name: `yoruba-voice-speech-recorder`
4. Description: `Record and preserve Yoruba language voice samples for research and education`
5. Make it **Public** (required for free GitHub Pages)
6. **Don't** initialize with README, .gitignore, or license (we have our own)
7. Click **"Create repository"**

## Step 2: Push Your Code

After creating the repository, GitHub will show you commands. Use these:

```bash
# Add the remote repository
git remote add origin https://github.com/YOURUSERNAME/yoruba-voice-speech-recorder.git

# Rename main branch if needed
git branch -M main

# Push your code
git push -u origin main
```

## Step 3: Create GitHub Release

1. Go to your repository on GitHub
2. Click **"Releases"** → **"Create a new release"**
3. Click **"Choose a tag"** → **"Create new tag"**
4. Tag: `v1.0.0`
5. Release title: `Yoruba Voice Speech Recorder v1.0.0`
6. Description:
```
## Yoruba Voice Speech Recorder v1.0.0

A cross-platform desktop application for recording Yoruba language voice samples for research and education.

### Features
- High-quality audio recording
- Yoruba language focus
- Research-oriented data collection
- Cross-platform compatibility (macOS, Windows, Linux)
- Professional packaging

### Downloads
- **macOS**: Download the DMG file for easy installation
- **Windows/Linux**: Download source code and follow installation guide

### Installation
See the [Installation Guide](https://yourusername.github.io/yoruba-voice-speech-recorder/docs/installation.md) for detailed instructions.
```

7. **Drag and drop** these files from `desktop-distribution/github-pages-clean/releases/`:
   - `YorubaVoiceRecorder.dmg` (macOS installer)
   - `YorubaVoiceRecorder.app.zip` (macOS app bundle)
   - `YorubaVoiceRecorder` (macOS executable)

8. Click **"Publish release"**

## Step 4: Deploy GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Source: **"Deploy from a branch"**
3. Branch: **"main"**
4. Folder: **"/desktop-distribution/github-pages-clean"**
5. Click **"Save"**
6. Your website will be live at: `https://YOURUSERNAME.github.io/yoruba-voice-speech-recorder`

## Step 5: Update Website Links

After creating the release, update the GitHub URLs in:
- `desktop-distribution/github-pages-clean/index.html`
- `desktop-distribution/github-pages-clean/docs/installation.md`

Replace `yourusername` with your actual GitHub username.

## Troubleshooting

### If you get "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/YOURUSERNAME/yoruba-voice-speech-recorder.git
```

### If you get authentication errors
```bash
# Use GitHub CLI (recommended)
gh auth login

# Or use personal access token
git remote set-url origin https://YOURUSERNAME:YOURTOKEN@github.com/YOURUSERNAME/yoruba-voice-speech-recorder.git
```

### If you need to update the repository
```bash
git add .
git commit -m "Update description"
git push origin main
```
EOF

echo "📋 Step 5: Creating quick setup script..."

cat > setup_github.sh << 'EOF'
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
EOF

chmod +x setup_github.sh

echo "📋 Step 6: Creating release preparation script..."

cat > prepare_release.sh << 'EOF'
#!/bin/bash

# Release Preparation Script
echo "📦 Preparing release files..."

# Ensure we're in the right directory
cd "$(dirname "$0")/.."

# Create release directory
mkdir -p release-files

# Copy macOS files
echo "Copying macOS files..."
cp desktop-distribution/github-pages-clean/releases/YorubaVoiceRecorder.dmg release-files/
cp desktop-distribution/github-pages-clean/releases/YorubaVoiceRecorder.app.zip release-files/
cp desktop-distribution/github-pages-clean/releases/YorubaVoiceRecorder release-files/

# Create source code ZIP
echo "Creating source code ZIP..."
zip -r release-files/yoruba-voice-speech-recorder-source.zip src/ requirements.txt README.md -x "*.pyc" "__pycache__/*" "*.DS_Store"

echo "✅ Release files prepared in release-files/:"
ls -la release-files/

echo ""
echo "📋 Files ready for GitHub Release:"
echo "   - YorubaVoiceRecorder.dmg (macOS installer)"
echo "   - YorubaVoiceRecorder.app.zip (macOS app bundle)"
echo "   - YorubaVoiceRecorder (macOS executable)"
echo "   - yoruba-voice-speech-recorder-source.zip (Source code)"
echo ""
echo "🚀 Next steps:"
echo "1. Push your code to GitHub"
echo "2. Create a release on GitHub"
echo "3. Upload these files as release assets"
EOF

chmod +x prepare_release.sh

echo ""
echo "✅ GitHub repository setup complete!"
echo ""
echo "📁 Files created:"
echo "   ├── .gitignore                    # Excludes large files"
echo "   ├── GITHUB_SETUP.md              # Detailed setup instructions"
echo "   ├── setup_github.sh              # Quick setup (if GitHub CLI installed)"
echo "   └── prepare_release.sh            # Prepare release files"
echo ""
echo "🚀 Quick Start Options:"
echo ""
echo "Option 1: Use GitHub CLI (Recommended)"
echo "  ./setup_github.sh"
echo ""
echo "Option 2: Manual Setup"
echo "  1. Follow instructions in GITHUB_SETUP.md"
echo "  2. Create repository on GitHub.com"
echo "  3. Push your code"
echo "  4. Create release with files from release-files/"
echo ""
echo "📖 See GITHUB_SETUP.md for detailed instructions"
