#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Windows packaging script for Microsoft Store distribution
"""

import PyInstaller.__main__
import os
import sys

def build_windows_app():
    """Build Windows executable using PyInstaller"""
    
    # Get the project root directory
    project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    src_dir = os.path.join(project_root, 'src')
    main_script = os.path.join(src_dir, 'yoruba_voice_speech_recorder', '__main__.py')
    
    # PyInstaller arguments
    args = [
        main_script,
        '--name=YorubaVoiceRecorder',
        '--windowed',  # No console window
        '--onefile',   # Single executable file
        '--clean',     # Clean cache before building
        
        # Add data files
        f'--add-data={os.path.join(src_dir, "yoruba_voice_speech_recorder", "prompts")};prompts',
        f'--add-data={os.path.join(src_dir, "yoruba_voice_speech_recorder", "__main__.qml")};.',
        f'--add-data={os.path.join(project_root, "desktop-distribution", "assets", "icon.ico")};.',
        
        # Hidden imports
        '--hidden-import=PySide6.QtCore',
        '--hidden-import=PySide6.QtGui',
        '--hidden-import=PySide6.QtQml',
        '--hidden-import=PySide6.QtWidgets',
        '--hidden-import=PySide6.QtMultimedia',
        '--hidden-import=pyaudio',
        '--hidden-import=webrtcvad',
        '--hidden-import=shortuuid',
        '--hidden-import=sounddevice',
        
        # Exclude unnecessary modules
        '--exclude-module=tkinter',
        '--exclude-module=matplotlib',
        '--exclude-module=numpy',
        '--exclude-module=scipy',
        
        # Icon
        f'--icon={os.path.join(project_root, "desktop-distribution", "assets", "icon.ico")}',
        
        # Output directory
        '--distpath=dist',
        '--workpath=build',
        '--specpath=.',
    ]
    
    print("Building Windows executable...")
    print(f"Project root: {project_root}")
    print(f"Main script: {main_script}")
    
    # Run PyInstaller
    PyInstaller.__main__.run(args)
    
    print("\nBuild complete! Executable should be in the 'dist' directory.")

if __name__ == '__main__':
    build_windows_app()
