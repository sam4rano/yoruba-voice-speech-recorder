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
