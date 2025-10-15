# 🎤 Yoruba Voice Speech Recorder

> **A professional cross-platform desktop application for recording and preserving Yoruba language voice samples for research and education.**

[![GitHub release](https://img.shields.io/github/release/sam4rano/yoruba-voice-speech-recorder.svg)](https://github.com/sam4rano/yoruba-voice-speech-recorder/releases)
[![GitHub Pages](https://img.shields.io/badge/website-live-brightgreen)](https://sam4rano.github.io/yoruba-voice-speech-recorder/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://python.org)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey)](https://sam4rano.github.io/yoruba-voice-speech-recorder/)

## 🌟 Overview

The Yoruba Voice Speech Recorder is a specialized desktop application designed to collect high-quality voice samples of the Yoruba language for linguistic research, language preservation, and educational purposes. Originally developed as a simple Python script, it has been transformed into a professional cross-platform application with a modern GUI, comprehensive packaging, and web distribution.

### 🚀 **Live Website & Downloads**
**Visit our professional download page:** [https://sam4rano.github.io/yoruba-voice-speech-recorder/](https://sam4rano.github.io/yoruba-voice-speech-recorder/)

## ✨ Key Features

### 🎯 **Core Functionality**
- **High-Quality Audio Recording** - Professional audio processing with WebRTC VAD
- **Yoruba Language Focus** - Curated prompts specifically for Yoruba language research
- **Random Text Prompts** - 3,501 unique Yoruba text samples for diverse recordings
- **Metadata Tracking** - Comprehensive data collection for research purposes
- **Cross-Platform Support** - Works on macOS, Windows, and Linux

### 🖥️ **Modern Interface**
- **PyQt6-based GUI** - Professional, responsive user interface
- **QML Design** - Modern, customizable user experience
- **Real-time Feedback** - Live audio level monitoring and recording status
- **Intuitive Controls** - Easy-to-use recording interface

### 📦 **Professional Distribution**
- **macOS App Bundle** - Native `.app` with DMG installer
- **Windows Executable** - Standalone `.exe` file
- **Linux Source** - Complete source code with installation scripts
- **GitHub Releases** - Automated distribution with version management
- **Web Distribution** - Professional download website

## 🚀 Quick Start

### **Option 1: Download Pre-built Applications (Recommended)**

1. **Visit the website:** [https://sam4rano.github.io/yoruba-voice-speech-recorder/](https://sam4rano.github.io/yoruba-voice-speech-recorder/)
2. **Choose your platform:**
   - **macOS**: Download the DMG file for easy installation
   - **Windows**: Download the executable file
   - **Linux**: Download the source code

### **Option 2: Build from Source**

#### Prerequisites
- Python 3.8 or later
- pip (Python package manager)

#### Installation
```bash
# Clone the repository
git clone https://github.com/sam4rano/yoruba-voice-speech-recorder.git
cd yoruba-voice-speech-recorder

# Install dependencies
pip install -r requirements.txt

# Run the application
python -m src.yoruba_voice_speech_recorder
```

## 📋 System Requirements

| Platform | Requirements |
|----------|-------------|
| **macOS** | macOS 10.15+ (Catalina or later), 100 MB free space, Microphone access |
| **Windows** | Windows 10+, Python 3.8+, Microphone access |
| **Linux** | Ubuntu 18.04+ or similar, Python 3.8+, Microphone access |

## 🛠️ Development

### **Project Structure**
```
yoruba-voice-speech-recorder/
├── src/                                # Source code
│   └── yoruba_voice_speech_recorder/
│       ├── __main__.py                 # Main application entry point
│       ├── __main__.qml                # QML user interface
│       ├── audio.py                    # Audio recording functionality
│       └── prompts/
│           └── yovo_3501.txt           # Yoruba text prompts
├── desktop-distribution/               # Desktop app packaging
│   ├── scripts/                        # Build and deployment scripts
│   ├── assets/                         # Icons and resources
│   └── github-pages-clean/             # Website source
├── requirements.txt                    # Python dependencies
├── setup.py                           # Package configuration
└── README.md                          # This file
```

### **Building Desktop Applications**

#### macOS
```bash
cd desktop-distribution
./scripts/build_pyinstaller.sh
```

#### Windows
```bash
cd desktop-distribution
scripts\build_windows.bat
```

### **Web Distribution**
```bash
cd desktop-distribution
./scripts/setup_github_pages.sh
```

## 🎯 Use Cases

### **Academic Research**
- **Linguistic Studies** - Collect voice samples for phonetic analysis
- **Language Documentation** - Preserve spoken Yoruba for future generations
- **Dialect Studies** - Record regional variations of Yoruba language
- **Machine Learning** - Provide training data for speech recognition systems

### **Educational Applications**
- **Language Learning** - Create pronunciation practice materials
- **Cultural Preservation** - Document oral traditions and stories
- **Teacher Training** - Develop language teaching resources

### **Community Projects**
- **Digital Archives** - Build community voice libraries
- **Oral History** - Record personal and family stories
- **Language Revitalization** - Support endangered language preservation

## 🔧 Technical Details

### **Audio Processing**
- **WebRTC VAD** - Voice Activity Detection for automatic recording
- **High-Quality Audio** - Professional-grade recording capabilities
- **Format Support** - WAV format for maximum compatibility
- **Metadata Tracking** - Automatic timestamp and prompt logging

### **User Interface**
- **PyQt6 Framework** - Modern, cross-platform GUI toolkit
- **QML Design** - Declarative UI with smooth animations
- **Responsive Layout** - Adapts to different screen sizes
- **Accessibility** - Keyboard navigation and screen reader support

### **Data Management**
- **Local Storage** - All recordings stored locally for privacy
- **Structured Metadata** - JSON format for easy data analysis
- **Prompt Management** - Randomized selection from curated text collection
- **Export Options** - Easy data export for research purposes

## 🌐 Web Distribution

The project includes a professional website hosted on GitHub Pages:

- **URL**: [https://sam4rano.github.io/yoruba-voice-speech-recorder/](https://sam4rano.github.io/yoruba-voice-speech-recorder/)
- **Features**: Responsive design, direct downloads, complete documentation
- **Hosting**: Free GitHub Pages with global CDN
- **Updates**: Automatic deployment from GitHub repository

## 📊 Project Evolution

### **Phase 1: Initial Development (2024)**
- Basic Python script for voice recording
- Simple command-line interface
- Yoruba text prompt integration

### **Phase 2: Desktop Application (2025)**
- **GUI Development** - PyQt6-based modern interface
- **Cross-Platform Support** - macOS, Windows, Linux compatibility
- **Professional Packaging** - Native app bundles and installers
- **Web Distribution** - Professional download website
- **GitHub Integration** - Automated releases and documentation

### **Phase 3: Future Enhancements**
- **Cloud Integration** - Optional cloud storage for research collaboration
- **Advanced Analytics** - Built-in voice analysis tools
- **Mobile Support** - iOS and Android applications
- **API Development** - RESTful API for research integration

## 🤝 Contributing

We welcome contributions to improve the Yoruba Voice Speech Recorder! Here's how you can help:

### **Ways to Contribute**
- **Bug Reports** - Report issues and suggest improvements
- **Feature Requests** - Propose new functionality
- **Code Contributions** - Submit pull requests
- **Documentation** - Improve guides and documentation
- **Testing** - Test on different platforms and configurations

### **Development Setup**
```bash
# Fork and clone the repository
git clone https://github.com/YOURUSERNAME/yoruba-voice-speech-recorder.git
cd yoruba-voice-speech-recorder

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install development dependencies
pip install -r requirements.txt

# Make your changes and test
python -m src.yoruba_voice_speech_recorder
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Yoruba Language Community** - For preserving this beautiful language
- **Linguistic Researchers** - For their valuable feedback and requirements
- **Open Source Community** - For the amazing tools and libraries
- **Contributors** - Everyone who has helped improve this project

## 📞 Support & Contact

- **Website**: [https://sam4rano.github.io/yoruba-voice-speech-recorder/](https://sam4rano.github.io/yoruba-voice-speech-recorder/)
- **GitHub Issues**: [Report bugs or request features](https://github.com/sam4rano/yoruba-voice-speech-recorder/issues)
- **Documentation**: Complete guides available on the website

## 🌍 Impact

The Yoruba Voice Speech Recorder is more than just a software application - it's a tool for cultural preservation and linguistic research. By making it easy to record and preserve Yoruba language samples, we're contributing to:

- **Language Preservation** - Ensuring Yoruba language documentation for future generations
- **Academic Research** - Supporting linguistic studies and phonetic research
- **Cultural Heritage** - Preserving oral traditions and cultural knowledge
- **Educational Resources** - Creating materials for language learning and teaching

---

**Made with ❤️ for the Yoruba language community and linguistic researchers worldwide.**

*Last updated: January 2025*