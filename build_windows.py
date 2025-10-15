#!/usr/bin/env python3
"""
Windows Build Script for Yoruba Voice Speech Recorder
This script builds a Windows executable using PyInstaller
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

def main():
    print("🚀 Building Yoruba Voice Speech Recorder for Windows...")
    
    # Get the project root directory
    project_root = Path(__file__).parent.absolute()
    os.chdir(project_root)
    
    # Create output directories
    dist_dir = project_root / "dist" / "windows"
    build_dir = project_root / "build" / "windows"
    
    dist_dir.mkdir(parents=True, exist_ok=True)
    build_dir.mkdir(parents=True, exist_ok=True)
    
    print("📋 Building Windows executable...")
    
    # PyInstaller command for Windows
    cmd = [
        "pyinstaller",
        "--name=YorubaVoiceRecorder",
        "--windowed",
        "--onefile",
        f"--distpath={dist_dir}",
        f"--workpath={build_dir}",
        f"--specpath={build_dir}",
        f"--icon={project_root}/desktop-distribution/assets/icon.ico",
        f"--paths={project_root}/src",
        f"--add-data={project_root}/src/yoruba_voice_speech_recorder/prompts;prompts",
        f"--add-data={project_root}/src/yoruba_voice_speech_recorder/__main__.qml;.",
        "--hidden-import=PyQt6.QtCore",
        "--hidden-import=PyQt6.QtGui", 
        "--hidden-import=PyQt6.QtQml",
        "--hidden-import=PyQt6.QtWidgets",
        "--hidden-import=PyQt6.QtMultimedia",
        "--hidden-import=pyaudio",
        "--hidden-import=webrtcvad",
        "--hidden-import=shortuuid",
        "--hidden-import=sounddevice",
        "--hidden-import=yoruba_voice_speech_recorder",
        "--hidden-import=yoruba_voice_speech_recorder.audio",
        "--clean",
        f"{project_root}/src/yoruba_voice_speech_recorder/__main__.py"
    ]
    
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        print("✅ Windows build successful!")
        
        # Check if executable was created
        exe_path = dist_dir / "YorubaVoiceRecorder.exe"
        if exe_path.exists():
            print(f"✅ Executable created: {exe_path}")
            print(f"📁 Size: {exe_path.stat().st_size / (1024*1024):.1f} MB")
            
            # Create ZIP package
            zip_path = dist_dir / "YorubaVoiceRecorder-Windows.zip"
            print("📦 Creating Windows ZIP package...")
            
            import zipfile
            with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
                zipf.write(exe_path, "YorubaVoiceRecorder.exe")
            
            print(f"✅ ZIP package created: {zip_path}")
            print(f"📁 Size: {zip_path.stat().st_size / (1024*1024):.1f} MB")
            
        else:
            print("❌ Executable not found!")
            return False
            
    except subprocess.CalledProcessError as e:
        print(f"❌ Build failed: {e}")
        print(f"Error output: {e.stderr}")
        return False
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False
    
    print("\n✅ Windows build complete!")
    print(f"📁 Files created in: {dist_dir}")
    print("🚀 Ready for upload to GitHub Releases!")
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
