#!/bin/bash

# Local Build Script for All Platforms
# This builds executables locally for immediate testing

set -e

echo "🚀 Building Yoruba Voice Speech Recorder locally..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

# Activate virtual environment
source yorenv/bin/activate

# Create output directories
mkdir -p dist/{macos,windows,linux}

echo "📋 Building macOS executable..."
pyinstaller --name="YorubaVoiceRecorder" --windowed --onefile --distpath="dist/macos" --workpath="build/macos" --specpath="build/macos" --icon="$PWD/desktop-distribution/assets/icon.icns" --paths="src" --add-data="$PWD/src/yoruba_voice_speech_recorder/prompts:prompts" --add-data="$PWD/src/yoruba_voice_speech_recorder/__main__.qml:." --hidden-import=PyQt6.QtCore --hidden-import=PyQt6.QtGui --hidden-import=PyQt6.QtQml --hidden-import=PyQt6.QtWidgets --hidden-import=PyQt6.QtMultimedia --hidden-import=pyaudio --hidden-import=webrtcvad --hidden-import=shortuuid --hidden-import=sounddevice --hidden-import=yoruba_voice_speech_recorder --hidden-import=yoruba_voice_speech_recorder.audio --clean "src/yoruba_voice_speech_recorder/__main__.py"

echo "📋 Building Linux executable..."
pyinstaller --name="YorubaVoiceRecorder" --windowed --onefile --distpath="dist/linux" --workpath="build/linux" --specpath="build/linux" --icon="$PWD/desktop-distribution/assets/icon.ico" --paths="src" --add-data="$PWD/src/yoruba_voice_speech_recorder/prompts:prompts" --add-data="$PWD/src/yoruba_voice_speech_recorder/__main__.qml:." --hidden-import=PyQt6.QtCore --hidden-import=PyQt6.QtGui --hidden-import=PyQt6.QtQml --hidden-import=PyQt6.QtWidgets --hidden-import=PyQt6.QtMultimedia --hidden-import=pyaudio --hidden-import=webrtcvad --hidden-import=shortuuid --hidden-import=sounddevice --hidden-import=yoruba_voice_speech_recorder --hidden-import=yoruba_voice_speech_recorder.audio --clean "src/yoruba_voice_speech_recorder/__main__.py"

echo "📋 Creating packages..."

# Create macOS DMG
if [ -d "dist/macos/YorubaVoiceRecorder.app" ]; then
    echo "Creating macOS DMG..."
    hdiutil create -volname "Yoruba Voice Recorder" -srcfolder dist/macos/YorubaVoiceRecorder.app -ov -format UDZO dist/macos/YorubaVoiceRecorder.dmg
fi

# Create Linux ZIP
if [ -f "dist/linux/YorubaVoiceRecorder" ]; then
    echo "Creating Linux ZIP..."
    chmod +x dist/linux/YorubaVoiceRecorder
    cd dist/linux
    zip -r YorubaVoiceRecorder-Linux.zip YorubaVoiceRecorder
    cd ../..
fi

echo ""
echo "✅ Local build complete!"
echo ""
echo "📁 Files created:"
echo "   macOS:"
ls -la dist/macos/ 2>/dev/null || echo "   No macOS files"
echo "   Linux:"
ls -la dist/linux/ 2>/dev/null || echo "   No Linux files"
echo ""
echo "🚀 Next steps:"
echo "1. Test the executables"
echo "2. Upload to GitHub Releases"
echo "3. Update website with download links"
