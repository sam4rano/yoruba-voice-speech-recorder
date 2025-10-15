#!/bin/bash

# GitHub Releases Preparation Script
echo "📦 Preparing files for GitHub Releases..."

# Create releases directory
mkdir -p releases

# Copy macOS files
cp ../dist/macos/YorubaVoiceRecorder.app releases/
cp ../dist/macos/YorubaVoiceRecorder releases/

# Create DMG
hdiutil create -volname "Yoruba Voice Recorder" -srcfolder releases/ -ov -format UDZO releases/YorubaVoiceRecorder.dmg

# Create ZIP of app bundle
cd releases
zip -r YorubaVoiceRecorder.app.zip YorubaVoiceRecorder.app
cd ..

echo "✅ Files prepared for GitHub Releases:"
echo "   - releases/YorubaVoiceRecorder.dmg"
echo "   - releases/YorubaVoiceRecorder.app.zip"
echo "   - releases/YorubaVoiceRecorder (executable)"
echo ""
echo "📋 Next steps:"
echo "1. Go to your GitHub repository"
echo "2. Click 'Releases' > 'Create a new release'"
echo "3. Upload these files as release assets"
echo "4. Tag the release (e.g., v1.0.0)"
echo "5. Publish the release"
