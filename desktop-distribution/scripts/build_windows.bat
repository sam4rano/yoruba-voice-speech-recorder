@echo off
REM Windows Build Script for Yoruba Voice Recorder
REM This script builds the Windows executable for distribution

echo 🪟 Building Yoruba Voice Recorder for Windows...

REM Get the script directory
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..\..
set BUILD_DIR=%PROJECT_ROOT%\desktop-distribution\windows
set DIST_DIR=%PROJECT_ROOT%\desktop-distribution\dist\windows

REM Create distribution directory
if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"

REM Change to build directory
cd /d "%BUILD_DIR%"

echo 📁 Working directory: %BUILD_DIR%
echo 📦 Output directory: %DIST_DIR%

REM Clean previous builds
echo 🧹 Cleaning previous builds...
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "YorubaVoiceRecorder.spec" del "YorubaVoiceRecorder.spec"

REM Install/upgrade required packages
echo 📦 Installing/upgrading required packages...
pip install --upgrade PyInstaller PySide6 pyaudio webrtcvad shortuuid sounddevice

REM Build the executable
echo 🔨 Building Windows executable...
python setup_windows.py

REM Check if build was successful
if exist "dist\YorubaVoiceRecorder.exe" (
    echo ✅ Executable created successfully!
    echo 📍 Location: %DIST_DIR%\YorubaVoiceRecorder.exe
    
    REM Copy to distribution directory
    copy "dist\YorubaVoiceRecorder.exe" "%DIST_DIR%\"
    
    echo 🎉 Windows build complete!
    echo.
    echo Next steps:
    echo 1. Test the executable: "%DIST_DIR%\YorubaVoiceRecorder.exe"
    echo 2. Code sign the executable for distribution
    echo 3. Package as MSIX for Microsoft Store
) else (
    echo ❌ Executable not found! Build may have failed.
    exit /b 1
)

pause
