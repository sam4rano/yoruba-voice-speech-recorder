#!/bin/bash

# GitHub Pages Deployment Setup Script
# This script prepares the app for GitHub Pages deployment

set -e

echo "🚀 Setting up Yoruba Voice Recorder for GitHub Pages deployment..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

echo "📋 Step 1: Building macOS version..."

# Clean previous builds
rm -rf dist/*
rm -rf build/*

# Build macOS version
echo "Building macOS version..."
./scripts/build_pyinstaller.sh

echo "📋 Step 2: Creating GitHub Pages distribution..."

# Create GitHub Pages distribution directory
mkdir -p github-pages
cd github-pages

# Create directory structure
mkdir -p downloads/{macos,windows,linux}
mkdir -p assets/{icons,screenshots}
mkdir -p docs

echo "📋 Step 3: Copying application files..."

# Copy macOS app
cp -R ../dist/macos/YorubaVoiceRecorder.app downloads/macos/
cp ../dist/macos/YorubaVoiceRecorder downloads/macos/

# Copy source code for Linux/Windows
cp -R ../../src downloads/linux/
cp ../../requirements.txt downloads/linux/
cp ../../README.md downloads/linux/

# Copy icons
cp ../assets/icon.icns assets/icons/
cp ../assets/icon.ico assets/icons/
cp "../assets/African-Inspired App Icon with Microphone Symbol.png" assets/icons/

echo "📋 Step 4: Creating installation packages..."

# Create macOS DMG
echo "Creating macOS DMG..."
hdiutil create -volname "Yoruba Voice Recorder" -srcfolder downloads/macos/ -ov -format UDZO downloads/macos/YorubaVoiceRecorder.dmg

# Create source code ZIP
cd downloads/linux
zip -r yoruba-voice-speech-recorder.zip .
cd ../..

echo "📋 Step 5: Creating main page..."

# Create index.html
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yoruba Voice Speech Recorder - Download</title>
    <meta name="description" content="Record and preserve Yoruba language voice samples for research and education. Cross-platform desktop application for linguists and researchers.">
    <meta name="keywords" content="yoruba, voice, speech, recording, language, preservation, africa, linguistics, research">
    <meta name="author" content="Yoruba Voice Speech Recorder">
    
    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://yourusername.github.io/yoruba-voice-speech-recorder/">
    <meta property="og:title" content="Yoruba Voice Speech Recorder">
    <meta property="og:description" content="Record and preserve Yoruba language voice samples for research and education.">
    <meta property="og:image" content="assets/icons/African-Inspired App Icon with Microphone Symbol.png">

    <!-- Twitter -->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:url" content="https://yourusername.github.io/yoruba-voice-speech-recorder/">
    <meta property="twitter:title" content="Yoruba Voice Speech Recorder">
    <meta property="twitter:description" content="Record and preserve Yoruba language voice samples for research and education.">
    <meta property="twitter:image" content="assets/icons/African-Inspired App Icon with Microphone Symbol.png">
    
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
                    <p>Build from source code</p>
                    <a href="downloads/linux/yoruba-voice-speech-recorder.zip" class="download-btn">
                        Download Source
                    </a>
                    <a href="docs/installation.md" class="download-btn secondary">
                        Installation Guide
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🐧</div>
                    <h3>Linux</h3>
                    <p>Source code available</p>
                    <a href="downloads/linux/yoruba-voice-speech-recorder.zip" class="download-btn">
                        Download Source
                    </a>
                    <a href="docs/installation.md" class="download-btn secondary">
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
                        Python 3.8+<br>
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

echo "📋 Step 6: Creating documentation..."

# Create installation guide
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

### From Source Code
1. Download the source code ZIP file
2. Extract the ZIP file
3. Install Python 3.8 or later
4. Install dependencies:
   ```cmd
   pip install -r requirements.txt
   ```
5. Run the application:
   ```cmd
   python -m src.yoruba_voice_speech_recorder
   ```

## Linux Installation

### From Source Code
1. Download the source code ZIP file
2. Extract the ZIP file
3. Install Python 3.8 or later
4. Install system dependencies:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install python3-pip portaudio19-dev
   
   # CentOS/RHEL
   sudo yum install python3-pip portaudio-devel
   ```

4. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

5. Run the application:
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

echo "📋 Step 7: Creating GitHub Pages configuration..."

# Create .nojekyll file to bypass Jekyll processing
touch .nojekyll

# Create CNAME file for custom domain (optional)
cat > CNAME << 'EOF'
# Replace with your custom domain if you have one
# yourdomain.com
EOF

echo "📋 Step 8: Creating deployment instructions..."

# Create README for GitHub Pages deployment
cat > README.md << 'EOF'
# Yoruba Voice Speech Recorder - GitHub Pages

This directory contains the GitHub Pages website for the Yoruba Voice Speech Recorder application.

## Deploy to GitHub Pages

### Option 1: Automatic Deployment (Recommended)
1. Push this code to a GitHub repository
2. Go to repository Settings > Pages
3. Select "Deploy from a branch"
4. Choose "main" branch and "/ (root)" folder
5. Click "Save"
6. Your site will be live at: `https://yourusername.github.io/repository-name`

### Option 2: Manual Deployment
1. Push this code to a GitHub repository
2. Go to repository Settings > Pages
3. Select "GitHub Actions" as source
4. Create a workflow file in `.github/workflows/deploy.yml`
5. Your site will be automatically deployed

## File Structure
```
github-pages/
├── index.html                      # Main download page
├── downloads/                      # Application downloads
│   ├── macos/                     # macOS versions
│   ├── windows/                   # Windows source
│   └── linux/                     # Linux source
├── assets/                        # Icons and images
├── docs/                          # Documentation
├── .nojekyll                      # Bypass Jekyll processing
└── CNAME                          # Custom domain (optional)
```

## Customization
- Edit `index.html` to customize the website
- Update contact information in all files
- Add screenshots to `assets/screenshots/`
- Update repository URLs in the HTML

## Features
- ✅ Free hosting on GitHub Pages
- ✅ Automatic HTTPS
- ✅ Custom domain support
- ✅ Mobile responsive design
- ✅ Direct file downloads

## Support
For deployment issues, check the [GitHub Pages documentation](https://docs.github.com/en/pages).
EOF

echo "📋 Step 9: Creating deployment script..."

# Create deployment script
cat > deploy.sh << 'EOF'
#!/bin/bash

# GitHub Pages Deployment Script
echo "🚀 Deploying to GitHub Pages..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit"
fi

# Add all files
git add .

# Commit changes
git commit -m "Update Yoruba Voice Recorder website"

# Push to GitHub (replace with your repository URL)
echo "Pushing to GitHub..."
echo "Please update the remote URL in this script with your GitHub repository URL"
echo "Example: git remote add origin https://github.com/yourusername/your-repo.git"
echo "Then run: git push -u origin main"

# Uncomment and update these lines with your repository details:
# git remote add origin https://github.com/yourusername/your-repo.git
# git branch -M main
# git push -u origin main

echo "✅ Deployment script ready!"
echo "Update the repository URL and run the git commands to deploy."
EOF

chmod +x deploy.sh

echo ""
echo "✅ GitHub Pages setup complete!"
echo ""
echo "📁 Files created in: github-pages/"
echo "   ├── index.html              # Main download page"
echo "   ├── downloads/              # Application files"
echo "   ├── assets/                 # Icons and images"
echo "   ├── docs/                   # Documentation"
echo "   ├── .nojekyll              # Bypass Jekyll"
echo "   ├── CNAME                  # Custom domain (optional)"
echo "   ├── deploy.sh              # Deployment script"
echo "   └── README.md              # Instructions"
echo ""
echo "🚀 Next steps:"
echo "1. cd github-pages"
echo "2. Update repository URLs in index.html"
echo "3. Run: ./deploy.sh"
echo "4. Follow the GitHub Pages setup instructions"
echo "5. Your app will be live at: https://yourusername.github.io/repository-name"
echo ""
echo "📖 See README.md for detailed deployment instructions"
