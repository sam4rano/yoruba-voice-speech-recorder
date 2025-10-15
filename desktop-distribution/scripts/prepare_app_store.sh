#!/bin/bash

# App Store Preparation Script
# This script prepares the app for Mac App Store submission

set -e

echo "🍎 Preparing Yoruba Voice Recorder for Mac App Store..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

echo "📋 Step 1: Building production-ready app..."

# Clean previous builds
rm -rf dist/macos/*
rm -rf build/macos/*

# Build with production settings
./scripts/build_pyinstaller.sh

echo "📋 Step 2: Creating App Store package..."

# Create a temporary directory for App Store preparation
mkdir -p app-store-prep

# Copy the app bundle
cp -R dist/macos/YorubaVoiceRecorder.app app-store-prep/

echo "📋 Step 3: Preparing for code signing..."

# Create entitlements file for App Store
cat > app-store-prep/entitlements.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.app-sandbox</key>
    <true/>
    <key>com.apple.security.device.microphone</key>
    <true/>
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>
    <key>com.apple.security.files.downloads.read-write</key>
    <true/>
    <key>com.apple.security.network.client</key>
    <true/>
</dict>
</plist>
EOF

echo "📋 Step 4: Creating App Store metadata..."

# Create app store metadata directory
mkdir -p app-store-prep/metadata

# Copy the app store metadata template
cp app-store-metadata.md app-store-prep/metadata/

echo "📋 Step 5: Creating screenshots directory..."
mkdir -p app-store-prep/screenshots

echo "📋 Step 6: Creating privacy policy template..."
cat > app-store-prep/privacy-policy.md << 'EOF'
# Privacy Policy for Yoruba Voice Speech Recorder

## Data Collection
This application records audio from your microphone for the purpose of voice data collection for Yoruba language research and preservation.

## Data Storage
- Audio recordings are stored locally on your device
- No data is transmitted to external servers
- You have full control over your recorded data

## Microphone Access
This application requires microphone access to record voice samples. The microphone is only active when you explicitly start recording.

## Data Usage
Recorded audio is used solely for:
- Yoruba language research
- Voice data preservation
- Educational purposes

## Contact
For questions about this privacy policy, please contact [your-email@domain.com]
EOF

echo "📋 Step 7: Creating submission checklist..."
cat > app-store-prep/submission-checklist.md << 'EOF'
# Mac App Store Submission Checklist

## Pre-Submission Requirements
- [ ] Apple Developer Account ($99/year)
- [ ] App Store Connect account set up
- [ ] App signed with Apple Developer certificate
- [ ] App notarized by Apple
- [ ] Privacy policy created and hosted
- [ ] App Store metadata completed
- [ ] Screenshots taken (required sizes)
- [ ] App tested on different macOS versions

## Required Screenshots
- [ ] 1280x800 (MacBook Air 13")
- [ ] 1440x900 (MacBook Pro 13")
- [ ] 1680x1050 (MacBook Pro 15")
- [ ] 2560x1600 (MacBook Pro 16")

## App Store Connect Information
- [ ] App name: Yoruba Voice Speech Recorder
- [ ] Bundle ID: com.yorubavoice.recorder
- [ ] Category: Education
- [ ] Age rating: 4+ (suitable for all ages)
- [ ] Keywords: yoruba, voice, speech, recording, language, africa
- [ ] Description: [See app-store-metadata.md]

## Testing
- [ ] Test on macOS 12.0+
- [ ] Test microphone permissions
- [ ] Test file saving functionality
- [ ] Test GUI responsiveness
- [ ] Test command line interface

## Submission
- [ ] Upload app to App Store Connect
- [ ] Complete app information
- [ ] Submit for review
- [ ] Monitor review status
EOF

echo ""
echo "✅ App Store preparation complete!"
echo ""
echo "📁 Files created in: app-store-prep/"
echo "   ├── YorubaVoiceRecorder.app     # Your app bundle"
echo "   ├── entitlements.plist          # App Store entitlements"
echo "   ├── metadata/                   # App Store metadata"
echo "   ├── screenshots/                # Place your screenshots here"
echo "   ├── privacy-policy.md           # Privacy policy template"
echo "   └── submission-checklist.md     # Step-by-step checklist"
echo ""
echo "🚀 Next steps:"
echo "1. Get Apple Developer Account"
echo "2. Code sign the app with your certificate"
echo "3. Notarize the app"
echo "4. Take screenshots of your app"
echo "5. Complete App Store Connect listing"
echo "6. Submit for review"
echo ""
echo "📖 See app-store-metadata.md for detailed information"
