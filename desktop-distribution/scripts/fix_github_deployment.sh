#!/bin/bash

# Fix GitHub Deployment Issues Script
# This script creates a clean GitHub Pages deployment without large files

set -e

echo "🔧 Fixing GitHub deployment issues..."

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT/desktop-distribution"

# Activate virtual environment
source ../yorenv/bin/activate

echo "📋 Step 1: Creating clean GitHub Pages deployment (without large files)..."

# Create clean GitHub Pages directory
mkdir -p github-pages-clean
cd github-pages-clean

# Create directory structure
mkdir -p downloads/{macos,windows,linux}
mkdir -p assets/{icons,screenshots}
mkdir -p docs

echo "📋 Step 2: Creating optimized main page..."

# Create index.html with GitHub Releases links
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
        
        .download-btn.github {
            background: #24292e;
        }
        
        .download-btn.github:hover {
            background: #1a1e22;
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
        
        .github-releases {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 15px;
            margin: 40px 0;
            text-align: center;
        }
        
        .github-releases h3 {
            color: #667eea;
            margin-bottom: 20px;
        }
        
        .github-releases p {
            margin-bottom: 20px;
            color: #666;
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
            <div class="github-releases">
                <h3>📦 Download from GitHub Releases</h3>
                <p>Due to file size limitations, the macOS application files are hosted on GitHub Releases for faster and more reliable downloads.</p>
                <a href="https://github.com/yourusername/yoruba-voice-speech-recorder/releases" class="download-btn github" target="_blank">
                    🚀 View All Downloads on GitHub
                </a>
            </div>
            
            <div class="download-section">
                <div class="download-card">
                    <div class="icon">🍎</div>
                    <h3>macOS</h3>
                    <p>Compatible with macOS 10.15+</p>
                    <a href="https://github.com/yourusername/yoruba-voice-speech-recorder/releases/latest/download/YorubaVoiceRecorder.dmg" class="download-btn">
                        Download DMG
                    </a>
                    <a href="https://github.com/yourusername/yoruba-voice-speech-recorder/releases/latest/download/YorubaVoiceRecorder.app.zip" class="download-btn secondary">
                        Download App Bundle
                    </a>
                </div>
                
                <div class="download-card">
                    <div class="icon">🪟</div>
                    <h3>Windows</h3>
                    <p>Build from source code</p>
                    <a href="https://github.com/yourusername/yoruba-voice-speech-recorder/archive/refs/heads/main.zip" class="download-btn">
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
                    <a href="https://github.com/yourusername/yoruba-voice-speech-recorder/archive/refs/heads/main.zip" class="download-btn">
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

echo "📋 Step 3: Copying assets (without large files)..."

# Copy only the icon files (small)
cp ../assets/icon.icns assets/icons/
cp ../assets/icon.ico assets/icons/
cp "../assets/African-Inspired App Icon with Microphone Symbol.png" assets/icons/

echo "📋 Step 4: Creating documentation..."

# Create installation guide
cat > docs/installation.md << 'EOF'
# Installation Guide

## macOS Installation

### Method 1: DMG File (Recommended)
1. Go to [GitHub Releases](https://github.com/yourusername/yoruba-voice-speech-recorder/releases)
2. Download the latest `YorubaVoiceRecorder.dmg` file
3. Double-click to mount the disk image
4. Drag the app to your Applications folder
5. Launch from Applications or Spotlight

### Method 2: App Bundle
1. Go to [GitHub Releases](https://github.com/yourusername/yoruba-voice-speech-recorder/releases)
2. Download the latest `YorubaVoiceRecorder.app.zip` file
3. Extract the ZIP file
4. Move the app to your Applications folder
5. Right-click and select "Open" (first time only)

## Windows Installation

### From Source Code
1. Download the source code from [GitHub](https://github.com/yourusername/yoruba-voice-speech-recorder/archive/refs/heads/main.zip)
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
1. Download the source code from [GitHub](https://github.com/yourusername/yoruba-voice-speech-recorder/archive/refs/heads/main.zip)
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
For technical support, please open an issue on [GitHub](https://github.com/yourusername/yoruba-voice-speech-recorder/issues) or contact [your-email@domain.com]
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
For questions about this privacy policy, please open an issue on [GitHub](https://github.com/yourusername/yoruba-voice-speech-recorder/issues) or contact [your-email@domain.com]
EOF

echo "📋 Step 5: Creating GitHub Pages configuration..."

# Create .nojekyll file to bypass Jekyll processing
touch .nojekyll

# Create CNAME file for custom domain (optional)
cat > CNAME << 'EOF'
# Replace with your custom domain if you have one
# yourdomain.com
EOF

echo "📋 Step 6: Creating deployment instructions..."

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
github-pages-clean/
├── index.html                      # Main download page
├── downloads/                      # (Empty - files hosted on GitHub Releases)
├── assets/                         # Icons and images (small files only)
├── docs/                           # Documentation
├── .nojekyll                      # Bypass Jekyll processing
└── CNAME                          # Custom domain (optional)
```

## Large Files Strategy
- **macOS DMG/App**: Hosted on GitHub Releases
- **Source Code**: Available as ZIP download from GitHub
- **Website**: Only contains small files (HTML, CSS, icons)

## Customization
- Edit `index.html` to customize the website
- Update GitHub repository URLs in the HTML
- Add screenshots to `assets/screenshots/`
- Update contact information

## Features
- ✅ Free hosting on GitHub Pages
- ✅ Automatic HTTPS
- ✅ Custom domain support
- ✅ Mobile responsive design
- ✅ Fast loading (no large files)
- ✅ GitHub Releases integration

## Support
For deployment issues, check the [GitHub Pages documentation](https://docs.github.com/en/pages).
EOF

echo "📋 Step 7: Creating deployment script..."

# Create deployment script
cat > deploy.sh << 'EOF'
#!/bin/bash

# GitHub Pages Deployment Script (Clean Version)
echo "🚀 Deploying clean GitHub Pages website..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit - Yoruba Voice Speech Recorder website"
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
echo ""
echo "📋 Next steps:"
echo "1. Update GitHub repository URLs in index.html"
echo "2. Create GitHub Releases with your large files"
echo "3. Run: ./deploy.sh"
echo "4. Enable GitHub Pages in repository settings"
EOF

chmod +x deploy.sh

echo "📋 Step 8: Creating GitHub Releases preparation script..."

# Create script to prepare files for GitHub Releases
cat > prepare_releases.sh << 'EOF'
#!/bin/bash

# GitHub Releases Preparation Script
echo "📦 Preparing files for GitHub Releases..."

# Create releases directory
mkdir -p releases

# Copy macOS files
cp ../dist/macos/YorubaVoiceRecorder.app releases/
cp ../dist/macos/YorubaVoiceRecorder releases/

# Create DMG
hdiutil create -volname "Yoruba Voice Recorder" -srcfolder releases/ -ov -format UDZO releases/YorubaVoiceRecorder.dmg

# Create ZIP of app bundle
cd releases
zip -r YorubaVoiceRecorder.app.zip YorubaVoiceRecorder.app
cd ..

echo "✅ Files prepared for GitHub Releases:"
echo "   - releases/YorubaVoiceRecorder.dmg"
echo "   - releases/YorubaVoiceRecorder.app.zip"
echo "   - releases/YorubaVoiceRecorder (executable)"
echo ""
echo "📋 Next steps:"
echo "1. Go to your GitHub repository"
echo "2. Click 'Releases' > 'Create a new release'"
echo "3. Upload these files as release assets"
echo "4. Tag the release (e.g., v1.0.0)"
echo "5. Publish the release"
EOF

chmod +x prepare_releases.sh

echo ""
echo "✅ Clean GitHub Pages setup complete!"
echo ""
echo "📁 Files created in: github-pages-clean/"
echo "   ├── index.html              # Main download page (links to GitHub Releases)"
echo "   ├── assets/                 # Icons and images (small files only)"
echo "   ├── docs/                   # Documentation"
echo "   ├── .nojekyll              # Bypass Jekyll"
echo "   ├── CNAME                  # Custom domain (optional)"
echo "   ├── deploy.sh              # Deployment script"
echo "   ├── prepare_releases.sh    # GitHub Releases preparation"
echo "   └── README.md              # Instructions"
echo ""
echo "🚀 Next steps:"
echo "1. cd github-pages-clean"
echo "2. Update GitHub repository URLs in index.html"
echo "3. Run: ./prepare_releases.sh"
echo "4. Upload release files to GitHub Releases"
echo "5. Run: ./deploy.sh"
echo "6. Enable GitHub Pages in repository settings"
echo ""
echo "📖 This approach avoids GitHub's file size limits by:"
echo "   - Hosting large files on GitHub Releases"
echo "   - Keeping the website lightweight"
echo "   - Using direct download links"
