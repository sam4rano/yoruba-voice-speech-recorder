#!/usr/bin/env python3
"""
Compatibility patch to convert PySide6 code to PyQt6
This allows the existing code to work with PyQt6 for packaging
"""

import os
import sys

def patch_main_file():
    """Patch the main Python file to use PyQt6 instead of PySide6"""
    
    main_file = os.path.join(os.path.dirname(__file__), '..', 'src', 'yoruba_voice_speech_recorder', '__main__.py')
    
    if not os.path.exists(main_file):
        print(f"❌ Main file not found: {main_file}")
        return False
    
    # Read the original file
    with open(main_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Create backup
    backup_file = main_file + '.backup'
    with open(backup_file, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"✅ Created backup: {backup_file}")
    
    # Replace PySide6 imports with PyQt6
    replacements = [
        ('from PySide6.QtCore import QObject, Slot, QUrl', 'from PyQt6.QtCore import QObject, pyqtSlot as Slot, QUrl'),
        ('from PySide6.QtWidgets import QApplication', 'from PyQt6.QtWidgets import QApplication'),
        ('from PySide6.QtQml import QQmlApplicationEngine', 'from PyQt6.QtQml import QQmlApplicationEngine'),
        ('from PySide6.QtWidgets import QMessageBox', 'from PyQt6.QtWidgets import QMessageBox'),
    ]
    
    for old, new in replacements:
        content = content.replace(old, new)
    
    # Write the patched file
    with open(main_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print("✅ Patched main file to use PyQt6")
    return True

def restore_main_file():
    """Restore the original PySide6 file"""
    
    main_file = os.path.join(os.path.dirname(__file__), '..', 'src', 'yoruba_voice_speech_recorder', '__main__.py')
    backup_file = main_file + '.backup'
    
    if not os.path.exists(backup_file):
        print(f"❌ Backup file not found: {backup_file}")
        return False
    
    # Restore from backup
    with open(backup_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    with open(main_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print("✅ Restored original PySide6 file")
    return True

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == 'restore':
        restore_main_file()
    else:
        patch_main_file()
