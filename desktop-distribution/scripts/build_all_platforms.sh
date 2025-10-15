#!/bin/bash

# Build All Platforms Script
# This script builds executables for macOS, Windows, and Linux

set -e

echo "🚀 Building Yoruba Voice Speech Recorder for all platforms..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

# Create output directories
mkdir -p dist/{macos,windows,linux}
mkdir -p build/{macos,windows,linux}

echo "📋 Step 1: Building macOS version..."
./scripts/build_pyinstaller.sh

echo "📋 Step 2: Building Windows version (using Wine)..."
# Check if Wine is available for cross-compilation
if command -v wine &> /dev/null; then
    echo "Wine found - attempting Windows build..."
    
    # Install Windows Python in Wine
    wine python --version || {
        echo "Installing Python in Wine..."
        # This would need to be set up properly
        echo "⚠️ Wine setup needed for Windows build"
    }
    
    # Build Windows executable
    wine pyinstaller \
        --name="YorubaVoiceRecorder" \
        --windowed \
        --onefile \
        --distpath="dist/windows" \
        --workpath="build/windows" \
        --specpath="build/windows" \
        --icon="assets/icon.ico" \
        --paths="../src" \
        --add-data="../src/yoruba_voice_speech_recorder/prompts:prompts" \
        --add-data="../src/yoruba_voice_speech_recorder/__main__.qml:." \
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
        "../src/yoruba_voice_speech_recorder/__main__.py"
    
    if [ $? -eq 0 ]; then
        echo "✅ Windows build successful!"
    else
        echo "❌ Windows build failed - will create placeholder"
    fi
else
    echo "⚠️ Wine not found - creating Windows build instructions"
    cat > dist/windows/BUILD_INSTRUCTIONS.md << 'EOF'
# Windows Build Instructions

To build the Windows executable, you need a Windows machine or Wine setup.

## Option 1: Windows Machine
1. Install Python 3.8+ on Windows
2. Install dependencies: `pip install -r requirements.txt`
3. Install PyInstaller: `pip install pyinstaller`
4. Run the build script: `scripts\build_windows.bat`

## Option 2: Wine (Linux/macOS)
1. Install Wine: `brew install wine` (macOS) or `sudo apt install wine` (Linux)
2. Install Python in Wine
3. Run this script again

## Option 3: GitHub Actions
The Windows build can be automated using GitHub Actions CI/CD.
EOF
fi

echo "📋 Step 3: Building Linux version..."
# Build Linux executable
pyinstaller \
    --name="YorubaVoiceRecorder" \
    --windowed \
    --onefile \
    --distpath="dist/linux" \
    --workpath="build/linux" \
    --specpath="build/linux" \
    --icon="assets/icon.ico" \
    --paths="../src" \
    --add-data="../src/yoruba_voice_speech_recorder/prompts:prompts" \
    --add-data="../src/yoruba_voice_speech_recorder/__main__.qml:." \
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
    "../src/yoruba_voice_speech_recorder/__main__.py"

if [ $? -eq 0 ]; then
    echo "✅ Linux build successful!"
else
    echo "❌ Linux build failed"
    exit 1
fi

echo "📋 Step 4: Creating platform-specific packages..."

# Create macOS DMG
if [ -d "dist/macos/YorubaVoiceRecorder.app" ]; then
    echo "Creating macOS DMG..."
    hdiutil create -volname "Yoruba Voice Recorder" -srcfolder dist/macos/YorubaVoiceRecorder.app -ov -format UDZO dist/macos/YorubaVoiceRecorder.dmg
fi

# Create Windows ZIP (if executable exists)
if [ -f "dist/windows/YorubaVoiceRecorder.exe" ]; then
    echo "Creating Windows ZIP..."
    cd dist/windows
    zip -r YorubaVoiceRecorder-Windows.zip YorubaVoiceRecorder.exe
    cd ../..
fi

# Create Linux AppImage (if executable exists)
if [ -f "dist/linux/YorubaVoiceRecorder" ]; then
    echo "Creating Linux AppImage..."
    # Make executable
    chmod +x dist/linux/YorubaVoiceRecorder
    
    # Create AppImage structure
    mkdir -p dist/linux/AppDir/usr/bin
    cp dist/linux/YorubaVoiceRecorder dist/linux/AppDir/usr/bin/
    
    # Create AppRun script
    cat > dist/linux/AppDir/AppRun << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
exec ./usr/bin/YorubaVoiceRecorder "$@"
EOF
    chmod +x dist/linux/AppDir/AppRun
    
    # Create AppImage metadata
    cat > dist/linux/AppDir/YorubaVoiceRecorder.desktop << 'EOF'
[Desktop Entry]
Name=Yoruba Voice Speech Recorder
Comment=Record and preserve Yoruba language voice samples
Exec=YorubaVoiceRecorder
Icon=YorubaVoiceRecorder
Terminal=false
Type=Application
Categories=AudioVideo;Audio;Recorder;
EOF
    
    # Create AppImage (requires appimagetool)
    if command -v appimagetool &> /dev/null; then
        appimagetool dist/linux/AppDir dist/linux/YorubaVoiceRecorder.AppImage
    else
        echo "⚠️ appimagetool not found - creating ZIP instead"
        cd dist/linux
        zip -r YorubaVoiceRecorder-Linux.zip YorubaVoiceRecorder
        cd ../..
    fi
fi

echo "📋 Step 5: Updating release files..."

# Copy files to release directory
mkdir -p release-files
cp -r dist/macos/* release-files/ 2>/dev/null || true
cp -r dist/windows/* release-files/ 2>/dev/null || true
cp -r dist/linux/* release-files/ 2>/dev/null || true

echo ""
echo "✅ Build complete!"
echo ""
echo "📁 Files created:"
echo "   macOS:"
ls -la dist/macos/ 2>/dev/null || echo "   No macOS files"
echo "   Windows:"
ls -la dist/windows/ 2>/dev/null || echo "   No Windows files"
echo "   Linux:"
ls -la dist/linux/ 2>/dev/null || echo "   No Linux files"
echo ""
echo "📦 Release files:"
ls -la release-files/ 2>/dev/null || echo "   No release files"
echo ""
echo "🚀 Next steps:"
echo "1. Test the executables on their respective platforms"
echo "2. Upload to GitHub Releases"
echo "3. Update website with direct download links"
