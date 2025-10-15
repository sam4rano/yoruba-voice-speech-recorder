#!/bin/bash

# Universal Build Script for Yoruba Voice Recorder
# This script builds the app for both macOS and Windows (if on macOS with Wine)

set -e  # Exit on any error

echo "🚀 Building Yoruba Voice Recorder for Desktop Distribution..."

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
DIST_DIR="$PROJECT_ROOT/desktop-distribution/dist"

# Create distribution directory
mkdir -p "$DIST_DIR"

echo "📁 Project root: $PROJECT_ROOT"
echo "📦 Distribution directory: $DIST_DIR"

# Detect platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="Linux"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    PLATFORM="Windows"
else
    echo "❌ Unsupported platform: $OSTYPE"
    exit 1
fi

echo "🖥️  Detected platform: $PLATFORM"

# Build for macOS
if [[ "$PLATFORM" == "macOS" ]]; then
    echo ""
    echo "🍎 Building for macOS..."
    "$SCRIPT_DIR/build_macos.sh"
fi

# Build for Windows (if on macOS with Wine or on Windows)
if [[ "$PLATFORM" == "macOS" ]] && command -v wine &> /dev/null; then
    echo ""
    echo "🪟 Building for Windows (using Wine)..."
    # Note: This would require Wine setup for PyInstaller
    echo "⚠️  Windows build with Wine not implemented yet"
elif [[ "$PLATFORM" == "Windows" ]]; then
    echo ""
    echo "🪟 Building for Windows..."
    "$SCRIPT_DIR/build_windows.bat"
fi

echo ""
echo "📋 Build Summary:"
echo "=================="
echo "Platform: $PLATFORM"
echo "Distribution directory: $DIST_DIR"

if [[ "$PLATFORM" == "macOS" ]]; then
    if [ -d "$DIST_DIR/macos/Yorùbá Voice Speech Recorder.app" ]; then
        echo "✅ macOS app bundle: $DIST_DIR/macos/Yorùbá Voice Speech Recorder.app"
    else
        echo "❌ macOS app bundle not found"
    fi
    
    if [ -f "$DIST_DIR/macos/YorubaVoiceRecorder.dmg" ]; then
        echo "✅ macOS DMG: $DIST_DIR/macos/YorubaVoiceRecorder.dmg"
    fi
fi

if [[ "$PLATFORM" == "Windows" ]]; then
    if [ -f "$DIST_DIR/windows/YorubaVoiceRecorder.exe" ]; then
        echo "✅ Windows executable: $DIST_DIR/windows/YorubaVoiceRecorder.exe"
    else
        echo "❌ Windows executable not found"
    fi
fi

echo ""
echo "🎉 Build process complete!"
echo ""
echo "Next steps:"
echo "1. Test the built applications"
echo "2. Code sign the applications"
echo "3. Prepare for store submission"
