#!/bin/bash

# PyInstaller Build Script for macOS
# This is a simpler alternative to py2app

set -e  # Exit on any error

echo "🔨 Building macOS app with PyInstaller..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

# Create output directories
mkdir -p dist/macos
mkdir -p build/macos

# Main application file
MAIN_FILE="$PROJECT_ROOT/src/yoruba_voice_speech_recorder/__main__.py"

# Check if main file exists
if [ ! -f "$MAIN_FILE" ]; then
    echo "❌ Main file not found: $MAIN_FILE"
    exit 1
fi

echo "📦 Building with PyInstaller..."

# Build the app
pyinstaller \
    --name="YorubaVoiceRecorder" \
    --windowed \
    --onefile \
    --distpath="dist/macos" \
    --workpath="build/macos" \
    --specpath="build/macos" \
    --icon="$PROJECT_ROOT/desktop-distribution/assets/icon.icns" \
    --paths="$PROJECT_ROOT/src" \
    --add-data="$PROJECT_ROOT/src/yoruba_voice_speech_recorder/prompts:prompts" \
    --add-data="$PROJECT_ROOT/src/yoruba_voice_speech_recorder/__main__.qml:." \
    --hidden-import=PyQt6.QtCore \
    --hidden-import=PyQt6.QtGui \
    --hidden-import=PyQt6.QtQml \
    --hidden-import=PyQt6.QtWidgets \
    --hidden-import=PyQt6.QtMultimedia \
    --hidden-import=pyaudio \
    --hidden-import=webrtcvad \
    --hidden-import=shortuuid \
    --hidden-import=sounddevice \
    --hidden-import=yoruba_voice_speech_recorder \
    --hidden-import=yoruba_voice_speech_recorder.audio \
    --clean \
    "$MAIN_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📱 App created at: dist/macos/YorubaVoiceRecorder"
    
    # Make the app executable
    chmod +x "dist/macos/YorubaVoiceRecorder"
    
    echo ""
    echo "🎉 macOS app build complete!"
    echo "📍 Location: $(pwd)/dist/macos/YorubaVoiceRecorder"
    echo ""
    echo "To test the app:"
    echo "  ./dist/macos/YorubaVoiceRecorder"
else
    echo "❌ Build failed!"
    exit 1
fi
