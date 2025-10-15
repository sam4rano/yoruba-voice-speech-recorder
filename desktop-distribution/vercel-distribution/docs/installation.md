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
