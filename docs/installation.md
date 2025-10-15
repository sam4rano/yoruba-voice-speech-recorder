# Installation Guide

## macOS Installation

### Method 1: DMG File (Recommended)
1. Go to [GitHub Releases](https://github.com/sam4rano/yoruba-voice-speech-recorder/releases)
2. Download the latest `YorubaVoiceRecorder.dmg` file
3. Double-click to mount the disk image
4. Drag the app to your Applications folder
5. Launch from Applications or Spotlight

### Method 2: App Bundle
1. Go to [GitHub Releases](https://github.com/sam4rano/yoruba-voice-speech-recorder/releases)
2. Download the latest `YorubaVoiceRecorder.app.zip` file
3. Extract the ZIP file
4. Move the app to your Applications folder
5. Right-click and select "Open" (first time only)

## Windows Installation

### From Source Code
1. Download the source code from [GitHub](https://github.com/sam4rano/yoruba-voice-speech-recorder/archive/refs/heads/main.zip)
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
1. Download the source code from [GitHub](https://github.com/sam4rano/yoruba-voice-speech-recorder/archive/refs/heads/main.zip)
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
For technical support, please open an issue on [GitHub](https://github.com/sam4rano/yoruba-voice-speech-recorder/issues) or contact [your-email@domain.com]
