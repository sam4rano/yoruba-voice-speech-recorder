#!/bin/bash

# macOS Build Script for Yoruba Voice Recorder
# This script builds the macOS app bundle for distribution

set -e  # Exit on any error

echo "🍎 Building Yoruba Voice Recorder for macOS..."

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
BUILD_DIR="$PROJECT_ROOT/desktop-distribution/macos"
DIST_DIR="$PROJECT_ROOT/desktop-distribution/dist/macos"

# Create distribution directory
mkdir -p "$DIST_DIR"

# Change to build directory
cd "$BUILD_DIR"

echo "📁 Working directory: $BUILD_DIR"
echo "📦 Output directory: $DIST_DIR"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build/ dist/

# Install/upgrade required packages
echo "📦 Installing/upgrading required packages..."
pip3 install --upgrade py2app PySide6 pyaudio webrtcvad shortuuid sounddevice

# Build the app
echo "🔨 Building macOS app bundle..."
python3 setup_macos.py py2app

# Move the app bundle to distribution directory
echo "📦 Moving app bundle to distribution directory..."
if [ -d "dist/Yorùbá Voice Speech Recorder.app" ]; then
    cp -R "dist/Yorùbá Voice Speech Recorder.app" "$DIST_DIR/"
    echo "✅ App bundle created successfully!"
    echo "📍 Location: $DIST_DIR/Yorùbá Voice Speech Recorder.app"
else
    echo "❌ App bundle not found! Build may have failed."
    exit 1
fi

# Create a DMG for distribution (optional)
echo "💿 Creating DMG for distribution..."
if command -v hdiutil &> /dev/null; then
    cd "$DIST_DIR"
    hdiutil create -volname "Yoruba Voice Recorder" -srcfolder "Yorùbá Voice Speech Recorder.app" -ov -format UDZO "YorubaVoiceRecorder.dmg"
    echo "✅ DMG created: $DIST_DIR/YorubaVoiceRecorder.dmg"
else
    echo "⚠️  hdiutil not found, skipping DMG creation"
fi

echo "🎉 macOS build complete!"
echo ""
echo "Next steps:"
echo "1. Test the app bundle: open '$DIST_DIR/Yorùbá Voice Speech Recorder.app'"
echo "2. Code sign the app for distribution"
echo "3. Notarize the app for Mac App Store"
