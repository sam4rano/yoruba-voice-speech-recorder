#!/usr/bin/env python3
"""
Test script to verify desktop distribution setup
"""

import os
import sys
import subprocess
import platform

def test_python_environment():
    """Test Python environment and dependencies"""
    print("🐍 Testing Python environment...")
    
    # Check Python version
    python_version = sys.version_info
    print(f"   Python version: {python_version.major}.{python_version.minor}.{python_version.micro}")
    
    if python_version < (3, 9):
        print("   ❌ Python 3.9+ required")
        return False
    else:
        print("   ✅ Python version OK")
    
    # Check required packages
    required_packages = [
        'PyQt6',
        'pyaudio', 
        'webrtcvad',
        'shortuuid',
        'sounddevice'
    ]
    
    missing_packages = []
    for package in required_packages:
        try:
            __import__(package)
            print(f"   ✅ {package} installed")
        except ImportError:
            print(f"   ❌ {package} missing")
            missing_packages.append(package)
    
    if missing_packages:
        print(f"   Missing packages: {', '.join(missing_packages)}")
        return False
    
    return True

def test_build_tools():
    """Test build tools availability"""
    print("\n🔨 Testing build tools...")
    
    current_platform = platform.system()
    
    if current_platform == "Darwin":  # macOS
        # Check for py2app
        try:
            import py2app
            print("   ✅ py2app available")
        except ImportError:
            print("   ❌ py2app missing - install with: pip install py2app")
            return False
        
        # Check for Xcode (for code signing)
        try:
            result = subprocess.run(['xcode-select', '--print-path'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                print("   ✅ Xcode command line tools available")
            else:
                print("   ⚠️  Xcode command line tools not found")
        except FileNotFoundError:
            print("   ⚠️  Xcode command line tools not found")
    
    elif current_platform == "Windows":
        # Check for PyInstaller
        try:
            import PyInstaller
            print("   ✅ PyInstaller available")
        except ImportError:
            print("   ❌ PyInstaller missing - install with: pip install pyinstaller")
            return False
    
    return True

def test_project_structure():
    """Test project structure"""
    print("\n📁 Testing project structure...")
    
    # Get script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(os.path.dirname(script_dir))
    
    # Check for source files
    main_py = os.path.join(project_root, 'src', 'yoruba_voice_speech_recorder', '__main__.py')
    main_qml = os.path.join(project_root, 'src', 'yoruba_voice_speech_recorder', '__main__.qml')
    
    if os.path.exists(main_py):
        print("   ✅ Main Python file found")
    else:
        print("   ❌ Main Python file not found")
        return False
    
    if os.path.exists(main_qml):
        print("   ✅ Main QML file found")
    else:
        print("   ❌ Main QML file not found")
        return False
    
    # Check for desktop distribution files
    macos_setup = os.path.join(project_root, 'desktop-distribution', 'macos', 'setup_macos.py')
    windows_setup = os.path.join(project_root, 'desktop-distribution', 'windows', 'setup_windows.py')
    
    if os.path.exists(macos_setup):
        print("   ✅ macOS setup script found")
    else:
        print("   ❌ macOS setup script not found")
    
    if os.path.exists(windows_setup):
        print("   ✅ Windows setup script found")
    else:
        print("   ❌ Windows setup script not found")
    
    return True

def main():
    """Run all tests"""
    print("🧪 Testing Desktop Distribution Setup")
    print("=" * 40)
    
    tests = [
        test_python_environment,
        test_build_tools,
        test_project_structure
    ]
    
    all_passed = True
    for test in tests:
        if not test():
            all_passed = False
    
    print("\n" + "=" * 40)
    if all_passed:
        print("🎉 All tests passed! Ready for desktop distribution.")
        print("\nNext steps:")
        print("1. Run: ./scripts/build_macos.sh (on macOS)")
        print("2. Run: scripts\\build_windows.bat (on Windows)")
        print("3. Test the built applications")
    else:
        print("❌ Some tests failed. Please fix the issues above.")
        print("\nCommon fixes:")
        print("- Install missing packages: pip install -r requirements.txt")
        print("- Install build tools: pip install py2app pyinstaller")
        print("- Ensure project structure is correct")
    
    return all_passed

if __name__ == '__main__':
    success = main()
    sys.exit(0 if success else 1)
