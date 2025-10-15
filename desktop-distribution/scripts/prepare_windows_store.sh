#!/bin/bash

# Windows Store Preparation Script
# This script prepares the app for Microsoft Store submission

set -e

echo "🪟 Preparing Yoruba Voice Recorder for Microsoft Store..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

echo "📋 Step 1: Building Windows executable..."

# Clean previous builds
rm -rf dist/windows/*
rm -rf build/windows/*

# Build Windows version
python3 windows/setup_windows.py

echo "📋 Step 2: Creating MSIX package structure..."

# Create a temporary directory for Windows Store preparation
mkdir -p windows-store-prep

# Copy the Windows executable
cp dist/windows/YorubaVoiceRecorder.exe windows-store-prep/

echo "📋 Step 3: Creating MSIX manifest..."

# Create AppxManifest.xml for MSIX package
cat > windows-store-prep/AppxManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<Package xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
         xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
         xmlns:rescap="http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities"
         xmlns:desktop="http://schemas.microsoft.com/appx/manifest/desktop/windows10">
  
  <Identity Name="YorubaVoiceRecorder"
            Version="1.0.0.0"
            Publisher="CN=YourPublisherName"
            ProcessorArchitecture="x64" />
  
  <Properties>
    <DisplayName>Yoruba Voice Speech Recorder</DisplayName>
    <PublisherDisplayName>Your Company Name</PublisherDisplayName>
    <Description>Record and preserve Yoruba language voice samples for research and education.</Description>
    <Logo>Assets\StoreLogo.png</Logo>
  </Properties>
  
  <Resources>
    <Resource Language="en-us" />
  </Resources>
  
  <Dependencies>
    <TargetDeviceFamily Name="Windows.Desktop" MinVersion="10.0.17763.0" MaxVersionTested="10.0.22621.0" />
  </Dependencies>
  
  <Capabilities>
    <rescap:Capability Name="microphone" />
    <Capability Name="internetClient" />
  </Capabilities>
  
  <Applications>
    <Application Id="YorubaVoiceRecorder" Executable="YorubaVoiceRecorder.exe" EntryPoint="YorubaVoiceRecorder.exe">
      <uap:VisualElements DisplayName="Yoruba Voice Speech Recorder"
                         Description="Record and preserve Yoruba language voice samples"
                         BackgroundColor="transparent"
                         Square150x150Logo="Assets\Square150x150Logo.png"
                         Square44x44Logo="Assets\Square44x44Logo.png" />
      
      <Extensions>
        <desktop:Extension Category="windows.fileAssociation">
          <desktop:FileAssociation FileType=".wav">
            <desktop:SupportedFileTypes>
              <desktop:FileType>.wav</desktop:FileType>
            </desktop:SupportedFileTypes>
          </desktop:FileAssociation>
        </desktop:Extension>
      </Extensions>
    </Application>
  </Applications>
</Package>
EOF

echo "📋 Step 4: Creating Windows Store metadata..."

# Create Windows Store metadata directory
mkdir -p windows-store-prep/metadata

# Create Windows Store description
cat > windows-store-prep/metadata/description.txt << 'EOF'
# Yoruba Voice Speech Recorder

## Description
Record and preserve Yoruba language voice samples for research and education. This application helps collect high-quality audio recordings of Yoruba speech for linguistic research, language preservation, and educational purposes.

## Features
- High-quality voice recording
- Random prompt selection
- Metadata tracking
- Easy-to-use interface
- Command-line and GUI modes
- Cross-platform support

## System Requirements
- Windows 10 version 17763.0 or later
- Microphone access
- 100 MB available storage

## Privacy
This app requires microphone access to record voice samples. All recordings are stored locally on your device and are not transmitted to external servers.

## Support
For support or questions, please contact [your-email@domain.com]
EOF

echo "📋 Step 5: Creating submission checklist..."
cat > windows-store-prep/submission-checklist.md << 'EOF'
# Microsoft Store Submission Checklist

## Pre-Submission Requirements
- [ ] Microsoft Partner Center account ($19 one-time fee)
- [ ] App signed with Microsoft certificate
- [ ] MSIX package created
- [ ] App tested on different Windows versions
- [ ] Privacy policy created and hosted

## Required Assets
- [ ] Store logo (50x50 pixels)
- [ ] Square 150x150 logo
- [ ] Square 44x44 logo
- [ ] Screenshots (at least 1, recommended 4-8)
- [ ] App description
- [ ] Keywords
- [ ] Category selection

## App Information
- [ ] App name: Yoruba Voice Speech Recorder
- [ ] Package name: YorubaVoiceRecorder
- [ ] Publisher: [Your Publisher Name]
- [ ] Category: Education
- [ ] Age rating: E (Everyone)
- [ ] Keywords: yoruba, voice, speech, recording, language, africa

## Testing
- [ ] Test on Windows 10 (version 17763+)
- [ ] Test on Windows 11
- [ ] Test microphone permissions
- [ ] Test file saving functionality
- [ ] Test GUI responsiveness
- [ ] Test command line interface

## MSIX Package Creation
- [ ] Install Windows SDK
- [ ] Use MakeAppx.exe to create MSIX
- [ ] Sign MSIX with certificate
- [ ] Test MSIX installation

## Submission
- [ ] Upload MSIX to Partner Center
- [ ] Complete store listing
- [ ] Submit for certification
- [ ] Monitor certification status
EOF

echo "📋 Step 6: Creating MSIX build script..."
cat > windows-store-prep/build_msix.bat << 'EOF'
@echo off
REM MSIX Package Creation Script for Windows Store

echo Creating MSIX package for Microsoft Store...

REM Set paths
set APPX_DIR=%~dp0
set MAKAPPX_PATH="C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\makeappx.exe"
set SIGTOOL_PATH="C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe"

REM Create MSIX package
%MAKAPPX_PATH% pack /d %APPX_DIR% /p %APPX_DIR%YorubaVoiceRecorder.msix

REM Sign the package (requires certificate)
REM %SIGTOOL_PATH% sign /fd SHA256 /f "your-certificate.pfx" /p "your-password" %APPX_DIR%YorubaVoiceRecorder.msix

echo MSIX package created: YorubaVoiceRecorder.msix
echo Note: You need to sign the package with your certificate before submission
EOF

echo ""
echo "✅ Windows Store preparation complete!"
echo ""
echo "📁 Files created in: windows-store-prep/"
echo "   ├── YorubaVoiceRecorder.exe     # Your Windows executable"
echo "   ├── AppxManifest.xml            # MSIX manifest"
echo "   ├── metadata/                   # Store metadata"
echo "   ├── submission-checklist.md     # Step-by-step checklist"
echo "   └── build_msix.bat              # MSIX creation script"
echo ""
echo "🚀 Next steps:"
echo "1. Get Microsoft Partner Center account"
echo "2. Create MSIX package using build_msix.bat"
echo "3. Sign MSIX with your certificate"
echo "4. Take screenshots of your app"
echo "5. Complete Partner Center listing"
echo "6. Submit for certification"
echo ""
echo "📖 See windows-store-prep/submission-checklist.md for detailed steps"
