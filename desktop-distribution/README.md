# Desktop Distribution Setup

This directory contains all the necessary files and scripts to build and distribute the Yoruba Voice Speech Recorder as desktop applications for both macOS and Windows.

## 📁 Directory Structure

```
desktop-distribution/
├── README.md                    # This file
├── app-store-metadata.md        # App store submission metadata
├── macos/
│   └── setup_macos.py          # macOS packaging script (py2app)
├── windows/
│   └── setup_windows.py        # Windows packaging script (PyInstaller)
├── scripts/
│   ├── build_macos.sh          # macOS build script
│   ├── build_windows.bat       # Windows build script
│   └── build_all.sh            # Universal build script
├── assets/                      # App icons and assets
│   ├── icon.icns               # macOS app icon
│   └── icon.ico                # Windows app icon
└── dist/                       # Build output directory
    ├── macos/                  # macOS app bundles
    └── windows/                # Windows executables
```

## 🚀 Quick Start

### Prerequisites

#### For macOS Development:
- macOS 10.14+ (Mojave or later)
- Xcode (for code signing and notarization)
- Python 3.9+
- Apple Developer Account ($99/year)

#### For Windows Development:
- Windows 10+ 
- Python 3.9+
- Visual Studio Build Tools
- Microsoft Partner Center Account (free)

### Building the Applications

#### 1. Build for macOS
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Build macOS app
./scripts/build_macos.sh
```

#### 2. Build for Windows
```bash
# On Windows
scripts\build_windows.bat

# On macOS with Wine (advanced)
./scripts/build_windows.sh
```

#### 3. Build for Both Platforms
```bash
# Universal build script
./scripts/build_all.sh
```

## 📦 Build Outputs

After building, you'll find:

### macOS
- **App Bundle**: `dist/macos/Yorùbá Voice Speech Recorder.app`
- **DMG**: `dist/macos/YorubaVoiceRecorder.dmg` (for distribution)

### Windows
- **Executable**: `dist/windows/YorubaVoiceRecorder.exe`
- **MSIX Package**: (for Microsoft Store submission)

## 🔧 Configuration

### macOS Configuration (`macos/setup_macos.py`)
- App bundle settings
- Code signing configuration
- Sandboxing requirements
- App Store compliance

### Windows Configuration (`windows/setup_windows.py`)
- Executable settings
- Data file inclusion
- Hidden imports
- Icon and metadata

## 🏪 App Store Submission

### Mac App Store
1. **Code Signing**: Sign the app bundle with your Apple Developer ID
2. **Notarization**: Submit to Apple for notarization
3. **App Store Connect**: Upload to App Store Connect
4. **Review**: Submit for Apple review

### Microsoft Store
1. **Code Signing**: Sign the executable with your certificate
2. **MSIX Packaging**: Create MSIX package
3. **Partner Center**: Upload to Microsoft Partner Center
4. **Certification**: Submit for Microsoft certification

## 🔐 Code Signing

### macOS Code Signing
```bash
# Sign the app bundle
codesign --force --deep --sign "Developer ID Application: Your Name" "Yorùbá Voice Speech Recorder.app"

# Notarize
xcrun notarytool submit "Yorùbá Voice Speech Recorder.app" --keychain-profile "notarytool-profile" --wait
```

### Windows Code Signing
```bash
# Sign the executable
signtool sign /fd SHA256 /a "YorubaVoiceRecorder.exe"
```

## 📋 App Store Requirements

### Required Assets
- App icons (multiple sizes)
- Screenshots (platform-specific sizes)
- App description and metadata
- Privacy policy
- Support information

### Compliance Requirements
- Privacy policy
- Terms of service
- Age rating
- Content guidelines compliance
- Platform-specific requirements

## 🧪 Testing

### Pre-Submission Testing
1. **Functionality Testing**: Test all features on target platforms
2. **Performance Testing**: Ensure smooth operation
3. **Compatibility Testing**: Test on different OS versions
4. **Security Testing**: Verify no security vulnerabilities

### Test Devices
- **macOS**: Intel Mac, Apple Silicon Mac, different macOS versions
- **Windows**: Different Windows 10/11 versions, different hardware

## 📚 Resources

### Documentation
- [Apple App Store Guidelines](https://developer.apple.com/app-store/guidelines/)
- [Microsoft Store Policies](https://docs.microsoft.com/en-us/windows/uwp/publish/store-policies)
- [Py2app Documentation](https://py2app.readthedocs.io/)
- [PyInstaller Documentation](https://pyinstaller.readthedocs.io/)

### Tools
- [Apple Developer Portal](https://developer.apple.com/)
- [Microsoft Partner Center](https://partner.microsoft.com/)
- [Xcode](https://developer.apple.com/xcode/)
- [Visual Studio](https://visualstudio.microsoft.com/)

## 🐛 Troubleshooting

### Common Issues

#### macOS Build Issues
- **PyAudio compilation**: Ensure PortAudio is installed via Homebrew
- **Code signing**: Verify Apple Developer ID is properly configured
- **Notarization**: Check that all dependencies are properly signed

#### Windows Build Issues
- **PyInstaller errors**: Ensure all dependencies are installed
- **Missing DLLs**: Check that all required libraries are included
- **Code signing**: Verify certificate is properly installed

### Getting Help
1. Check the main project README for general troubleshooting
2. Review platform-specific documentation
3. Check build logs for specific error messages
4. Ensure all prerequisites are properly installed

## 📝 Notes

- This setup preserves the original source code in the `src/` directory
- All desktop-specific files are contained in this `desktop-distribution/` directory
- The original development environment remains unchanged
- Build outputs are stored in the `dist/` directory
- All scripts are designed to be run from the project root directory
