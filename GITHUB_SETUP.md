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
