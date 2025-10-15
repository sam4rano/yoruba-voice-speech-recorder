#!/bin/bash

# Vercel Deployment Setup Script
# This script prepares the app for Vercel deployment

set -e

echo "🚀 Setting up Yoruba Voice Recorder for Vercel deployment..."

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

echo "📋 Step 2: Creating Vercel-ready web distribution..."

# Create Vercel distribution directory
mkdir -p vercel-distribution
cd vercel-distribution

# Create directory structure
mkdir -p public/downloads/{macos,windows,linux}
mkdir -p public/assets/{icons,screenshots}
mkdir -p docs

echo "📋 Step 3: Copying application files..."

# Copy macOS app
cp -R ../dist/macos/YorubaVoiceRecorder.app public/downloads/macos/
cp ../dist/macos/YorubaVoiceRecorder public/downloads/macos/

# Copy source code for Linux/Windows
cp -R ../../src public/downloads/linux/
cp ../../requirements.txt public/downloads/linux/
cp ../../README.md public/downloads/linux/

# Copy icons
cp ../assets/icon.icns public/assets/icons/
cp ../assets/icon.ico public/assets/icons/
cp "../assets/African-Inspired App Icon with Microphone Symbol.png" public/assets/icons/

echo "📋 Step 4: Creating installation packages..."

# Create macOS DMG
echo "Creating macOS DMG..."
hdiutil create -volname "Yoruba Voice Recorder" -srcfolder public/downloads/macos/ -ov -format UDZO public/downloads/macos/YorubaVoiceRecorder.dmg

# Create source code ZIP
cd public/downloads/linux
zip -r yoruba-voice-speech-recorder.zip .
cd ../../..

echo "📋 Step 5: Creating Vercel configuration..."

# Create vercel.json
cat > vercel.json << 'EOF'
{
  "version": 2,
  "name": "yoruba-voice-recorder",
  "builds": [
    {
      "src": "public/**/*",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/public/$1"
    }
  ],
  "headers": [
    {
      "source": "/downloads/(.*)",
      "headers": [
        {
          "key": "Content-Disposition",
          "value": "attachment"
        },
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/assets/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    }
  ]
}
EOF

# Create package.json
cat > package.json << 'EOF'
{
  "name": "yoruba-voice-recorder-website",
  "version": "1.0.0",
  "description": "Download page for Yoruba Voice Speech Recorder",
  "scripts": {
    "build": "echo 'No build step required'",
    "dev": "python -m http.server 3000 --directory public"
  },
  "keywords": [
    "yoruba",
    "voice",
    "speech",
    "recording",
    "language",
    "preservation",
    "africa"
  ],
  "author": "Your Name",
  "license": "MIT"
}
EOF

echo "📋 Step 6: Creating main page..."

# Create index.html in public directory
cat > public/index.html << 'EOF'
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
    <meta property="og:url" content="https://yoruba-voice-recorder.vercel.app/">
    <meta property="og:title" content="Yoruba Voice Speech Recorder">
    <meta property="og:description" content="Record and preserve Yoruba language voice samples for research and education.">
    <meta property="og:image" content="/assets/icons/African-Inspired App Icon with Microphone Symbol.png">

    <!-- Twitter -->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:url" content="https://yoruba-voice-recorder.vercel.app/">
    <meta property="twitter:title" content="Yoruba Voice Speech Recorder">
    <meta property="twitter:description" content="Record and preserve Yoruba language voice samples for research and education.">
    <meta property="twitter:image" content="/assets/icons/African-Inspired App Icon with Microphone Symbol.png">
    
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
                    <a href="/downloads/macos/YorubaVoiceRecorder.dmg" class="download-btn">
                        Download DMG
                    </a>
                    <a href="/downloads/macos/YorubaVoiceRecorder" class="download-btn secondary">
                        Direct Download
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🪟</div>
                    <h3>Windows</h3>
                    <p>Build from source code</p>
                    <a href="/downloads/linux/yoruba-voice-speech-recorder.zip" class="download-btn">
                        Download Source
                    </a>
                    <a href="/docs/installation.md" class="download-btn secondary">
                        Installation Guide
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🐧</div>
                    <h3>Linux</h3>
                    <p>Source code available</p>
                    <a href="/downloads/linux/yoruba-voice-speech-recorder.zip" class="download-btn">
                        Download Source
                    </a>
                    <a href="/docs/installation.md" class="download-btn secondary">
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

echo "📋 Step 7: Creating documentation..."

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

echo "📋 Step 8: Creating deployment instructions..."

# Create README for Vercel deployment
cat > README.md << 'EOF'
# Yoruba Voice Speech Recorder - Vercel Deployment

This directory contains the Vercel-ready website for the Yoruba Voice Speech Recorder application.

## Quick Deploy to Vercel

### Option 1: Vercel CLI (Recommended)
1. Install Vercel CLI:
   ```bash
   npm i -g vercel
   ```

2. Deploy:
   ```bash
   vercel
   ```

3. Follow the prompts to configure your project

### Option 2: GitHub Integration
1. Push this code to GitHub
2. Connect your GitHub repository to Vercel
3. Vercel will automatically deploy on every push

### Option 3: Drag & Drop
1. Go to [vercel.com](https://vercel.com)
2. Sign up/login
3. Drag the `vercel-distribution` folder to deploy

## File Structure
```
vercel-distribution/
├── public/                          # Static files served by Vercel
│   ├── index.html                   # Main download page
│   ├── downloads/                   # Application downloads
│   │   ├── macos/                   # macOS versions
│   │   ├── windows/                 # Windows source
│   │   └── linux/                   # Linux source
│   ├── assets/                      # Icons and images
│   └── docs/                        # Documentation
├── vercel.json                      # Vercel configuration
└── package.json                     # Project metadata
```

## Customization
- Edit `public/index.html` to customize the website
- Update contact information in all files
- Add screenshots to `public/assets/screenshots/`
- Modify `vercel.json` for advanced configuration

## Features
- ✅ Fast global CDN
- ✅ Automatic HTTPS
- ✅ Custom domain support
- ✅ Analytics integration
- ✅ Download tracking
- ✅ Mobile responsive design

## Support
For deployment issues, check the [Vercel documentation](https://vercel.com/docs).
EOF

echo "📋 Step 9: Creating deployment script..."

# Create deployment script
cat > deploy.sh << 'EOF'
#!/bin/bash

# Vercel Deployment Script
echo "🚀 Deploying to Vercel..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "Installing Vercel CLI..."
    npm install -g vercel
fi

# Deploy to Vercel
echo "Deploying to Vercel..."
vercel --prod

echo "✅ Deployment complete!"
echo "Your app is now live on Vercel!"
EOF

chmod +x deploy.sh

echo ""
echo "✅ Vercel setup complete!"
echo ""
echo "📁 Files created in: vercel-distribution/"
echo "   ├── public/                      # Static files for Vercel"
echo "   │   ├── index.html              # Main download page"
echo "   │   ├── downloads/              # Application files"
echo "   │   ├── assets/                 # Icons and images"
echo "   │   └── docs/                   # Documentation"
echo "   ├── vercel.json                 # Vercel configuration"
echo "   ├── package.json                # Project metadata"
echo "   ├── deploy.sh                   # Deployment script"
echo "   └── README.md                   # Deployment instructions"
echo ""
echo "🚀 Next steps:"
echo "1. cd vercel-distribution"
echo "2. Run: ./deploy.sh"
echo "3. Follow the Vercel prompts"
echo "4. Your app will be live at: https://your-project.vercel.app"
echo ""
echo "📖 See README.md for detailed deployment instructions"
