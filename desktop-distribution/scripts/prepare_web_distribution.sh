#!/bin/bash

# Web Distribution Preparation Script
# This script prepares the app for direct download from a website

set -e

echo "🌐 Preparing Yoruba Voice Recorder for Web Distribution..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

echo "📋 Step 1: Building all platform versions..."

# Clean previous builds
rm -rf dist/*
rm -rf build/*

# Build macOS version
echo "Building macOS version..."
./scripts/build_pyinstaller.sh

# Build Windows version (if on macOS, we can cross-compile or provide instructions)
echo "Building Windows version..."
python3 windows/setup_windows.py

echo "📋 Step 2: Creating web distribution package..."

# Create web distribution directory
mkdir -p web-distribution
cd web-distribution

# Create directory structure
mkdir -p downloads/{macos,windows,linux}
mkdir -p assets/{icons,screenshots}
mkdir -p docs
mkdir -p src

echo "📋 Step 3: Copying application files..."

# Copy macOS app
cp -R ../dist/macos/YorubaVoiceRecorder.app downloads/macos/
cp ../dist/macos/YorubaVoiceRecorder downloads/macos/

# Copy Windows executable
cp ../dist/windows/YorubaVoiceRecorder.exe downloads/windows/

# Copy icons
cp ../assets/icon.icns assets/icons/
cp ../assets/icon.ico assets/icons/
cp "../assets/African-Inspired App Icon with Microphone Symbol.png" assets/icons/

echo "📋 Step 4: Creating installation packages..."

# Create macOS DMG
echo "Creating macOS DMG..."
hdiutil create -volname "Yoruba Voice Recorder" -srcfolder downloads/macos/ -ov -format UDZO downloads/macos/YorubaVoiceRecorder.dmg

# Create Windows ZIP
echo "Creating Windows ZIP..."
cd downloads/windows
zip -r YorubaVoiceRecorder-Windows.zip YorubaVoiceRecorder.exe
cd ../..

echo "📋 Step 5: Creating website files..."

# Create main HTML page
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yoruba Voice Speech Recorder - Download</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 3rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .main-content {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .download-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .download-card {
            border: 2px solid #e1e5e9;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .download-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-color: #667eea;
        }
        
        .download-card h3 {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 1.5rem;
        }
        
        .download-card .icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .download-btn {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
            margin: 10px 5px;
        }
        
        .download-btn:hover {
            background: #5a6fd8;
            transform: scale(1.05);
        }
        
        .download-btn.secondary {
            background: #6c757d;
        }
        
        .download-btn.secondary:hover {
            background: #5a6268;
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 40px 0;
        }
        
        .feature {
            text-align: center;
            padding: 20px;
        }
        
        .feature .icon {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .feature h4 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .system-requirements {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 15px;
            margin: 40px 0;
        }
        
        .system-requirements h3 {
            color: #667eea;
            margin-bottom: 20px;
        }
        
        .requirements-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .requirement {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        
        .footer {
            text-align: center;
            color: white;
            margin-top: 40px;
            opacity: 0.8;
        }
        
        .screenshot {
            max-width: 100%;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin: 20px 0;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .main-content {
                padding: 20px;
            }
            
            .download-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎤 Yoruba Voice Speech Recorder</h1>
            <p>Record and preserve Yoruba language voice samples for research and education</p>
        </div>
        
        <div class="main-content">
            <div class="download-section">
                <div class="download-card">
                    <div class="icon">🍎</div>
                    <h3>macOS</h3>
                    <p>Compatible with macOS 10.15+</p>
                    <a href="downloads/macos/YorubaVoiceRecorder.dmg" class="download-btn">
                        Download DMG
                    </a>
                    <a href="downloads/macos/YorubaVoiceRecorder" class="download-btn secondary">
                        Direct Download
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🪟</div>
                    <h3>Windows</h3>
                    <p>Compatible with Windows 10+</p>
                    <a href="downloads/windows/YorubaVoiceRecorder-Windows.zip" class="download-btn">
                        Download ZIP
                    </a>
                    <a href="downloads/windows/YorubaVoiceRecorder.exe" class="download-btn secondary">
                        Direct Download
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🐧</div>
                    <h3>Linux</h3>
                    <p>Source code available</p>
                    <a href="https://github.com/yourusername/yoruba-voice-speech-recorder" class="download-btn">
                        View Source
                    </a>
                    <a href="docs/linux-installation.md" class="download-btn secondary">
                        Installation Guide
                    </a>
                </div>
            </div>
            
            <div class="features">
                <div class="feature">
                    <div class="icon">🎯</div>
                    <h4>High-Quality Recording</h4>
                    <p>Professional audio processing for clear voice samples</p>
                </div>
                
                <div class="feature">
                    <div class="icon">📝</div>
                    <h4>Random Prompts</h4>
                    <p>Curated Yoruba text samples for diverse recordings</p>
                </div>
                
                <div class="feature">
                    <div class="icon">📊</div>
                    <h4>Metadata Tracking</h4>
                    <p>Comprehensive data collection for research purposes</p>
                </div>
                
                <div class="feature">
                    <div class="icon">🖥️</div>
                    <h4>Cross-Platform</h4>
                    <p>Works on macOS, Windows, and Linux</p>
                </div>
            </div>
            
            <div class="system-requirements">
                <h3>System Requirements</h3>
                <div class="requirements-grid">
                    <div class="requirement">
                        <h4>macOS</h4>
                        <p>macOS 10.15 or later<br>
                        100 MB free space<br>
                        Microphone access</p>
                    </div>
                    <div class="requirement">
                        <h4>Windows</h4>
                        <p>Windows 10 or later<br>
                        100 MB free space<br>
                        Microphone access</p>
                    </div>
                    <div class="requirement">
                        <h4>Linux</h4>
                        <p>Ubuntu 18.04+ or similar<br>
                        Python 3.8+<br>
                        Microphone access</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 Yoruba Voice Speech Recorder. Helping preserve the Yoruba language.</p>
        </div>
    </div>
</body>
</html>
EOF

# Create installation guides
cat > docs/installation.md << 'EOF'
# Installation Guide

## macOS Installation

### Method 1: DMG File (Recommended)
1. Download `YorubaVoiceRecorder.dmg`
2. Double-click to mount the disk image
3. Drag the app to your Applications folder
4. Launch from Applications or Spotlight

### Method 2: Direct Download
1. Download `YorubaVoiceRecorder`
2. Make it executable: `chmod +x YorubaVoiceRecorder`
3. Run: `./YorubaVoiceRecorder`

## Windows Installation

### Method 1: ZIP File (Recommended)
1. Download `YorubaVoiceRecorder-Windows.zip`
2. Extract the ZIP file
3. Run `YorubaVoiceRecorder.exe`

### Method 2: Direct Download
1. Download `YorubaVoiceRecorder.exe`
2. Run the executable

## Linux Installation

### From Source
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/yoruba-voice-speech-recorder.git
   cd yoruba-voice-speech-recorder
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:
   ```bash
   python -m src.yoruba_voice_speech_recorder
   ```

## Troubleshooting

### Microphone Permission Issues
- **macOS**: Go to System Preferences > Security & Privacy > Microphone
- **Windows**: Go to Settings > Privacy > Microphone
- **Linux**: Ensure your user is in the audio group

### Audio Quality Issues
- Use a good quality microphone
- Record in a quiet environment
- Check your system's audio settings

### Support
For technical support, please contact [your-email@domain.com]
EOF

# Create privacy policy
cat > docs/privacy-policy.md << 'EOF'
# Privacy Policy

## Data Collection
This application records audio from your microphone for the purpose of voice data collection for Yoruba language research and preservation.

## Data Storage
- Audio recordings are stored locally on your device
- No data is transmitted to external servers
- You have full control over your recorded data

## Microphone Access
This application requires microphone access to record voice samples. The microphone is only active when you explicitly start recording.

## Data Usage
Recorded audio is used solely for:
- Yoruba language research
- Voice data preservation
- Educational purposes

## Contact
For questions about this privacy policy, please contact [your-email@domain.com]
EOF

# Create README for the web distribution
cat > README.md << 'EOF'
# Yoruba Voice Speech Recorder - Web Distribution

This directory contains the web distribution files for the Yoruba Voice Speech Recorder application.

## Files Structure
```
web-distribution/
├── index.html                          # Main download page
├── downloads/                          # Application downloads
│   ├── macos/
│   │   ├── YorubaVoiceRecorder.app    # macOS app bundle
│   │   ├── YorubaVoiceRecorder        # macOS executable
│   │   └── YorubaVoiceRecorder.dmg    # macOS installer
│   ├── windows/
│   │   ├── YorubaVoiceRecorder.exe    # Windows executable
│   │   └── YorubaVoiceRecorder-Windows.zip # Windows installer
│   └── linux/                         # Linux source code
├── assets/                            # Icons and images
├── docs/                              # Documentation
└── src/                               # Source code
```

## Deployment
1. Upload all files to your web server
2. Ensure the web server supports the file types (.dmg, .exe, .zip)
3. Update the GitHub repository link in index.html
4. Update contact email addresses in the files

## Customization
- Edit `index.html` to match your branding
- Update contact information in all files
- Add your own screenshots to `assets/screenshots/`
- Modify the color scheme in the CSS

## Security
- Consider adding HTTPS to your website
- Implement download tracking if needed
- Add virus scanning for uploaded files
EOF

echo "📋 Step 6: Creating deployment script..."

# Create deployment script
cat > deploy.sh << 'EOF'
#!/bin/bash

# Web Deployment Script
# Uploads the web distribution to your server

echo "🚀 Deploying Yoruba Voice Recorder to web server..."

# Configuration (update these with your server details)
SERVER="your-server.com"
USER="your-username"
REMOTE_PATH="/var/www/html/yoruba-voice-recorder"

# Upload files
echo "Uploading files to server..."
rsync -avz --delete . $USER@$SERVER:$REMOTE_PATH/

echo "✅ Deployment complete!"
echo "Your app is now available at: https://$SERVER/yoruba-voice-recorder/"
EOF

chmod +x deploy.sh

echo "📋 Step 7: Creating update script..."

# Create update script for future releases
cat > update-release.sh << 'EOF'
#!/bin/bash

# Release Update Script
# Use this when you want to release a new version

set -e

echo "🔄 Updating release for web distribution..."

# Get version number
read -p "Enter version number (e.g., 1.1.0): " VERSION

# Update version in files
sed -i.bak "s/Version [0-9]\+\.[0-9]\+\.[0-9]\+/Version $VERSION/g" index.html
sed -i.bak "s/Version [0-9]\+\.[0-9]\+\.[0-9]\+/Version $VERSION/g" docs/installation.md

# Create release notes
cat > docs/release-notes-$VERSION.md << EOL
# Release Notes - Version $VERSION

## New Features
- [Add new features here]

## Bug Fixes
- [Add bug fixes here]

## Improvements
- [Add improvements here]

## Download
- [macOS DMG](downloads/macos/YorubaVoiceRecorder.dmg)
- [Windows ZIP](downloads/windows/YorubaVoiceRecorder-Windows.zip)
- [Linux Source](https://github.com/yourusername/yoruba-voice-speech-recorder)

## Installation
See [installation guide](docs/installation.md) for detailed instructions.
EOL

echo "✅ Release $VERSION prepared!"
echo "Don't forget to:"
echo "1. Update the app files in downloads/"
echo "2. Test the new version"
echo "3. Deploy with ./deploy.sh"
EOF

chmod +x update-release.sh

echo ""
echo "✅ Web distribution preparation complete!"
echo ""
echo "📁 Files created in: web-distribution/"
echo "   ├── index.html                    # Main download page"
echo "   ├── downloads/                    # Application files"
echo "   │   ├── macos/                   # macOS versions"
echo "   │   ├── windows/                 # Windows versions"
echo "   │   └── linux/                   # Linux source"
echo "   ├── assets/                      # Icons and images"
echo "   ├── docs/                        # Documentation"
echo "   ├── deploy.sh                    # Deployment script"
echo "   └── update-release.sh            # Release update script"
echo ""
echo "🚀 Next steps:"
echo "1. Customize index.html with your branding"
echo "2. Update contact information in all files"
echo "3. Add screenshots to assets/screenshots/"
echo "4. Upload to your web server using deploy.sh"
echo "5. Set up a domain name (optional but recommended)"
echo ""
echo "📖 See README.md for detailed deployment instructions"
