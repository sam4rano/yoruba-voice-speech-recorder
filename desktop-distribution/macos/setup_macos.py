#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Enhanced macOS packaging script for Mac App Store distribution
"""

from setuptools import setup
import os
import sys

# Add the src directory to the path so we can import our modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../../src'))

APP = ['../../src/yoruba_voice_speech_recorder/__main__.py']

# Data files to include in the app bundle
DATA_FILES = [
    ('prompts', ['../../src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt']),
    ('', ['../../src/yoruba_voice_speech_recorder/__main__.qml']),
    ('', ['../assets/icon.icns']),  # App icon
]

# Py2app options for Mac App Store
OPTIONS = {
    'py2app': {
        'iconfile': '../assets/icon.icns',
        'plist': {
            'CFBundleName': 'Yorùbá Voice Recorder',
            'CFBundleDisplayName': 'Yorùbá Voice Recorder',
            'CFBundleIdentifier': 'com.yorubavoice.recorder',
            'CFBundleVersion': '1.0.0',
            'CFBundleShortVersionString': '1.0.0',
            'CFBundlePackageType': 'APPL',
            'CFBundleSignature': 'YVRc',
            'CFBundleExecutable': 'Yorùbá Voice Recorder',
            'CFBundleInfoDictionaryVersion': '6.0',
            'CFBundleDevelopmentRegion': 'en',
            'CFBundleLocalizations': ['en'],
            
            # App Store requirements
            'NSMicrophoneUsageDescription': 'This app needs microphone access to record Yoruba voice samples for machine learning purposes.',
            'NSDocumentsFolderUsageDescription': 'This app needs access to save recorded audio files and metadata.',
            'LSUIElement': False,
            'LSMinimumSystemVersion': '10.14.0',  # macOS 10.14+ required for Qt6
            
            # Sandboxing requirements for App Store
            'com.apple.security.app-sandbox': True,
            'com.apple.security.device.microphone': True,
            'com.apple.security.files.user-selected.read-write': True,
            'com.apple.security.files.downloads.read-write': True,
        },
        'includes': [
            'PyQt6.QtCore',
            'PyQt6.QtGui', 
            'PyQt6.QtQml',
            'PyQt6.QtWidgets',
            'PyQt6.QtMultimedia',
            'pyaudio',
            'webrtcvad',
            'shortuuid',
            'sounddevice',
        ],
        'packages': [
            'yoruba_voice_speech_recorder',
        ],
        'excludes': [
            'tkinter',
            'matplotlib',
            'numpy',
            'scipy',
        ],
        'optimize': 2,
        'semi_standalone': False,
        'site_packages': True,
    }
}

setup(
    app=APP,
    name="Yorùbá Voice Speech Recorder",
    data_files=DATA_FILES,
    options=OPTIONS,
    setup_requires=['py2app'],
    install_requires=[
        'PyQt6>=6.0.0',
        'pyaudio>=0.2.11',
        'webrtcvad>=2.0.10',
        'shortuuid>=1.0.1',
        'sounddevice>=0.4.0',
    ],
)
