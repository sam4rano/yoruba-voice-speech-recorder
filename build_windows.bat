@echo off
echo 🚀 Building Yoruba Voice Speech Recorder for Windows...

REM Create output directories
if not exist "dist\windows" mkdir "dist\windows"
if not exist "build\windows" mkdir "build\windows"

echo 📋 Building Windows executable...

REM PyInstaller command for Windows
pyinstaller --name=YorubaVoiceRecorder --windowed --onefile --distpath=dist\windows --workpath=build\windows --specpath=build\windows --icon=desktop-distribution\assets\icon.ico --paths=src --add-data=src\yoruba_voice_speech_recorder\prompts;prompts --add-data=src\yoruba_voice_speech_recorder\__main__.qml;. --hidden-import=PyQt6.QtCore --hidden-import=PyQt6.QtGui --hidden-import=PyQt6.QtQml --hidden-import=PyQt6.QtWidgets --hidden-import=PyQt6.QtMultimedia --hidden-import=pyaudio --hidden-import=webrtcvad --hidden-import=shortuuid --hidden-import=sounddevice --hidden-import=yoruba_voice_speech_recorder --hidden-import=yoruba_voice_speech_recorder.audio --clean src\yoruba_voice_speech_recorder\__main__.py

if %ERRORLEVEL% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo ✅ Windows build successful!

REM Check if executable was created
if exist "dist\windows\YorubaVoiceRecorder.exe" (
    echo ✅ Executable created: dist\windows\YorubaVoiceRecorder.exe
    
    REM Create ZIP package
    echo 📦 Creating Windows ZIP package...
    powershell Compress-Archive -Path "dist\windows\YorubaVoiceRecorder.exe" -DestinationPath "dist\windows\YorubaVoiceRecorder-Windows.zip"
    
    if exist "dist\windows\YorubaVoiceRecorder-Windows.zip" (
        echo ✅ ZIP package created: dist\windows\YorubaVoiceRecorder-Windows.zip
    ) else (
        echo ❌ ZIP creation failed!
    )
) else (
    echo ❌ Executable not found!
    pause
    exit /b 1
)

echo.
echo ✅ Windows build complete!
echo 📁 Files created in: dist\windows
echo 🚀 Ready for upload to GitHub Releases!
pause
