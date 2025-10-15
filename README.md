# Yorùbá Voice Speech Recorder

App for recording speech utterances dictated from text prompts. Speaker name, audio-recording path & prompt text are saved to a metadata file. Use it for building speech recognition and speech synthesis corpora for training and evaluation.

# 📖 Complete Installation Guide

This guide provides comprehensive installation instructions for both **Windows** and **macOS** systems.

📋 **Table of Contents**
1. [Prerequisites](#prerequisites)
2. [Windows Installation](#windows-installation)
3. [macOS Installation](#macos-installation)
4. [Common Usage](#common-usage)
5. [Troubleshooting](#troubleshooting)
6. [Developer Setup](#developer-setup)

---

## Prerequisites

### System Requirements
- **Operating System**: Windows 10/11 or macOS 10.14+
- **Python**: Version 3.9, 3.10, 3.11, or 3.12
- **RAM**: Minimum 4GB, Recommended 8GB+
- **Storage**: At least 1GB free space for installation
- **Audio**: Working microphone and speakers/headphones

---

## Windows Installation

### 📋 Step 1: Download Prerequisites

#### 🔧 Step 1.1: Download Git Bash
1. Navigate to https://git-scm.com/download/win
2. Download the latest version for Windows
3. Run the installer with default settings
4. ⚠️ **Important**: During installation, select "Use Git from the command line and also from 3rd-party software"
5. Complete the installation

#### 💻 Step 1.2: Download Visual Studio Code (Optional but Recommended)
1. Visit https://code.visualstudio.com/
2. Download the Windows version
3. Install with default settings

#### 🐍 Step 1.3: Download Python
1. Go to https://www.python.org/downloads/
2. Download Python 3.11 or 3.12 (latest stable version)
3. 🚨 **CRITICAL**: During installation, check "Add Python to PATH"
4. Check "Install for all users" if you have admin rights
5. Complete the installation

### ✅ Step 2: Verify Python Installation

#### Step 2.1: Open Terminal
1. Open Git Bash (search for "Git Bash" in Start menu)

#### Step 2.2: Verify Python
```bash
python --version
```
You should see something like: `Python 3.11.x` or `Python 3.12.x`

If you get "command not found", Python is not in PATH - reinstall Python with "Add to PATH" checked

#### Step 2.3: Verify pip
```bash
pip --version
```
You should see pip version information. If not found, try: `python -m pip --version`

#### Step 2.4: Upgrade pip (Recommended)
```bash
python -m pip install --upgrade pip
```

### 📁 Step 3: Project Setup

#### Step 3.1: Extract the Project
1. Extract the ZIP file to a location like:
   - `C:\Users\[YourUsername]\Desktop\yoruba-voice-speech-recorder`
   - Or `C:\project\yoruba-voice-speech-recorder`
2. ⚠️ **Important**: Avoid paths with spaces or special characters

#### Step 3.2: Navigate to Project Directory
```bash
cd /c/Users/[YourUsername]/Desktop/yoruba-voice-speech-recorder
# Or if you used C:\project:
cd /c/project/yoruba-voice-speech-recorder
```

#### Step 3.3: Verify Project Structure
```bash
ls -la
```
You should see folders like: `src`, `scripts`, `yorenv` and files like `setup.py`, `requirements.txt`

### 🔄 Step 4: Virtual Environment Setup

#### Step 4.1: Create Virtual Environment
```bash
python -m venv yorenv
```
Wait for creation to complete (may take 1-2 minutes)

#### Step 4.2: Activate Virtual Environment
```bash
source yorenv/Scripts/activate
```
You should see `(yorenv)` at the beginning of your command prompt

🔑 **Important**: You must activate the virtual environment every time you open a new terminal

### 📦 Step 5: Package Installation

#### Step 5.1: Install the Project Package
```bash
pip install -e .
```
This will install all required dependencies from requirements.txt

#### Step 5.2: Verify Installation
```bash
pip list | grep yoruba
```
You should see `yoruba-voice-speech-recorder` in the list

### ▶️ Step 6: Start the Application

#### Step 6.1: Create Audio Directory
```bash
mkdir -p ~/Desktop/audio-data
```

#### Step 6.2: Start the Application
```bash
python -m yoruba_voice_speech_recorder -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt -d ~/Desktop/audio-data
```

---

## macOS Installation

### 📋 Step 1: Install Prerequisites

#### 🔧 Step 1.1: Install Homebrew (if not already installed)
1. Open Terminal (Applications > Utilities > Terminal)
2. Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Follow the on-screen instructions
4. Add Homebrew to your PATH (the installer will provide instructions)

#### 🐍 Step 1.2: Install Python
```bash
brew install python@3.11
```
Or for the latest version:
```bash
brew install python@3.12
```

#### 🔊 Step 1.3: Install PortAudio (Required for Audio Recording)
```bash
brew install portaudio
```

#### 💻 Step 1.4: Install Git (if not already installed)
```bash
brew install git
```

### ✅ Step 2: Verify Installation

#### Step 2.1: Verify Python
```bash
python3 --version
```
You should see something like: `Python 3.11.x` or `Python 3.12.x`

#### Step 2.2: Verify pip
```bash
pip3 --version
```

#### Step 2.3: Upgrade pip (Recommended)
```bash
python3 -m pip install --upgrade pip
```

### 📁 Step 3: Project Setup

#### Step 3.1: Navigate to Project Directory
```bash
cd /path/to/yoruba-voice-speech-recorder
```

#### Step 3.2: Verify Project Structure
```bash
ls -la
```
You should see folders like: `src`, `scripts`, `yorenv` and files like `setup.py`, `requirements.txt`

### 🔄 Step 4: Virtual Environment Setup

#### Step 4.1: Create Virtual Environment
```bash
python3 -m venv yorenv
```

#### Step 4.2: Activate Virtual Environment
```bash
source yorenv/bin/activate
```
You should see `(yorenv)` at the beginning of your command prompt

### 📦 Step 5: Package Installation

#### Step 5.1: Install with Architecture-Specific Flags

**For Apple Silicon Macs (M1, M2, M3)**:
```bash
CPPFLAGS="-I/opt/homebrew/include" LDFLAGS="-L/opt/homebrew/lib" pip3 install -e .
```

**For Intel Macs**:
```bash
CPPFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib" pip3 install -e .
```

**For MacPorts users**:
```bash
CPPFLAGS="-I/opt/local/include" LDFLAGS="-L/opt/local/lib" pip3 install -e .
```

#### Step 5.2: Verify Installation
```bash
pip3 list | grep yoruba
```

### ▶️ Step 6: Start the Application

#### Step 6.1: Use the Provided Scripts

**For Apple Silicon Macs (M1, M2, M3)**:
```bash
./scripts/start_macos_arm64.sh
```

**For Intel Macs**:
```bash
./scripts/start_macos_x86_64.sh
```

#### Step 6.2: Alternative Start Method
```bash
python3 -m yoruba_voice_speech_recorder -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt -d ~/Desktop/audio-data
```

---

## Common Usage

### 🎵 Starting the Application
After installation, you can start the application with:

**Windows**:
```bash
# Activate virtual environment first
source yorenv/Scripts/activate
# Then start the app
python -m yoruba_voice_speech_recorder -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt -d ~/Desktop/audio-data
```

**macOS**:
```bash
# Activate virtual environment first
source yorenv/bin/activate
# Then start the app
python3 -m yoruba_voice_speech_recorder -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt -d ~/Desktop/audio-data
```

### ⚙️ Command Line Options
```bash
python -m yoruba_voice_speech_recorder --help
```

Common parameters:
- `-p [prompt_file]`: Path to text file with prompts
- `-d [output_dir]`: Directory to save audio recordings
- `-s [speaker_name]`: Speaker name for recordings

### 📂 Output Files
The application creates:
- `.wav` audio files in your specified output directory
- `recorder.tsv` metadata file containing recording information

---

## Troubleshooting

### Windows Issues

#### ❌ "Microsoft Visual C++ 14.0 or greater is required"
**Solution**:
1. Download Visual Studio Build Tools from: https://visualstudio.microsoft.com/downloads/
2. Install "C++ build tools" workload
3. Restart your computer
4. Try installing packages again

#### ❌ "python: command not found"
**Solution**:
1. Reinstall Python with "Add to PATH" checked
2. Restart Git Bash
3. Try using `python3` instead of `python`

#### ❌ Audio recording not working
**Solution**:
1. Check Windows audio settings
2. Make sure microphone is enabled
3. Try running as administrator if needed

### macOS Issues

#### ❌ "portaudio not found" or audio library errors
**Solution**:
```bash
# Reinstall portaudio
brew uninstall portaudio
brew install portaudio

# Then reinstall the project
pip3 uninstall yoruba-voice-speech-recorder
# Use appropriate CPPFLAGS/LDFLAGS for your Mac architecture
CPPFLAGS="-I/opt/homebrew/include" LDFLAGS="-L/opt/homebrew/lib" pip3 install -e .
```

#### ❌ "No module named yoruba_voice_speech_recorder"
**Solution**:
1. Make sure virtual environment is activated
2. Reinstall the package: `pip3 install -e .`
3. Verify installation: `python3 -c "import yoruba_voice_speech_recorder"`

#### ❌ Permission denied on scripts
**Solution**:
```bash
chmod +x scripts/*.sh
```

### Cross-Platform Issues

#### ❌ Unicode/Character display issues
**Solution**: The application handles UTF-8 encoding automatically. If issues persist, check your terminal encoding settings.

#### ❌ Virtual environment activation issues
**Solution**: Make sure you're using the correct activation command for your platform:
- Windows: `source yorenv/Scripts/activate`
- macOS/Linux: `source yorenv/bin/activate`

---

## Developer Setup

For advanced users and developers who want to contribute to the project:

### Prerequisites for Development
- **Git**: For version control
- **Python 3.9+**: Programming language
- **Code Editor**: VS Code, PyCharm, or similar

### Quick Developer Setup

#### Windows (Git Bash)
```bash
git clone https://github.com/Niger-Volta-LTI/yoruba-voice-speech-recorder.git
cd yoruba-voice-speech-recorder
python -m venv yorenv
source yorenv/Scripts/activate
pip install -e .
```

#### macOS
```bash
git clone https://github.com/Niger-Volta-LTI/yoruba-voice-speech-recorder.git
cd yoruba-voice-speech-recorder
python3 -m venv yorenv
source yorenv/bin/activate
# For Apple Silicon Macs:
CPPFLAGS="-I/opt/homebrew/include" LDFLAGS="-L/opt/homebrew/lib" pip3 install -e .
# For Intel Macs:
CPPFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib" pip3 install -e .
```

### macOS App Bundle Creation (py2app)
```bash
python3 ./setup.py py2app -A    # Creates app bundle (.app)
./dist/Yorùbá\ Voice\ Speech\ Recorder.app/Contents/MacOS/Yorùbá\ Voice\ Speech\ Recorder \
    -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt \
    -d ~/Desktop/audio-data
```

---

## 🚀 Quick Reference

### Essential Commands

#### Windows Quick Start
```bash
# Open Git Bash, then:
cd /c/path/to/yoruba-voice-speech-recorder
source yorenv/Scripts/activate
python -m yoruba_voice_speech_recorder -p src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt -d ~/Desktop/audio-data
```

#### macOS Quick Start
```bash
# Open Terminal, then:
cd /path/to/yoruba-voice-speech-recorder
source yorenv/bin/activate
./scripts/start_macos_arm64.sh  # For Apple Silicon
# OR
./scripts/start_macos_x86_64.sh  # For Intel
```

### File Locations Reference

| Component | Windows | macOS |
|-----------|---------|-------|
| Virtual Environment | `yorenv/Scripts/` | `yorenv/bin/` |
| Activation Script | `source yorenv/Scripts/activate` | `source yorenv/bin/activate` |
| Audio Output | `~/Desktop/audio-data/` | `~/Desktop/audio-data/` |
| Prompts File | `src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt` | `src/yoruba_voice_speech_recorder/prompts/yovo_3501.txt` |
| Start Scripts | N/A | `scripts/start_macos_*.sh` |

### Verification Checklist

- [ ] Python 3.9+ installed and accessible
- [ ] Virtual environment created and activated
- [ ] All packages installed without errors
- [ ] Application starts without crashes
- [ ] Audio recording functionality works
- [ ] Output files are created correctly

### Common File Extensions
- `.wav` - Audio recordings
- `.tsv` - Tab-separated metadata file
- `.txt` - Prompt files
- `.py` - Python source files

---

## 🆘 Support and Help

### Getting Help
1. ✅ Check this installation guide first
2. ✅ Verify all prerequisites are installed correctly
3. ✅ Make sure virtual environment is activated
4. ✅ Check the terminal output for specific error messages
5. ✅ Try the troubleshooting section for your platform

### Reporting Issues
When reporting issues, please include:
- Operating system and version
- Python version (`python --version` or `python3 --version`)
- Full error message
- Steps that led to the error

---

## Other Packaging Solutions

For developers interested in alternative packaging methods:
- [PyOxidizer](https://pyoxidizer.readthedocs.io/en/stable/index.html)
- [Nuitka](https://doc.qt.io/qtforpython/deployment-nuitka.html)
- [Typer](https://typer.tiangolo.com)
- [cx_freeze](https://cx-freeze.readthedocs.io/en/latest/)
- [shiv](https://shiv.readthedocs.io/en/latest/)

---

## License

Distributed under the AGPL-3.0 license. See the LICENSE text file for more information.

---

## Acknowledgements

This repository is based on a fork of https://github.com/daanzu/speech-training-recorder.

### New Features and Improvements

We have implemented significant updates, bugfixes, enhancements and new features:

#### Technical Improvements
- ✅ Updates and fixes to support latest version of Python 3
- ✅ Updates and fixes to run on the latest macOS ARM-based CPUs (M1, M2, M3)
- ✅ Resolved Homebrew & `portaudio` compatibility issues
- ✅ Improvements to the audio playback engine and recording fidelity (48kHz samplerate)
- ✅ Updates to the latest version of PySide6 (Qt6) for modern GUI applications

#### User Experience Enhancements
- ✅ New feature: Per-prompt-file speaker labels support
- ✅ New feature: Load prompt files directly with open-file dialog
- ✅ New feature: Automatic layouts based on available prompt lines
- ✅ Cosmetic updates to the User Interface
- ✅ Cross-platform installation scripts for easier deployment

#### Developer Experience
- ✅ Updated installation and start scripts for non-developers
- ✅ Initial scripts for py2app and PyInstaller packaging
- ✅ Comprehensive documentation for both Windows and macOS

---

## 📚 Citation

If you found this tool useful, please consider citing:

```bibtex
@software{yvspeechrecorder,
  author = {Iroro Orife and Aremu Anuoluwapo and K\d{\'{o}}l\'{a} T\'{u}b\d{\`{o}}s\'{u}n and David Ifeoluwa Adelani and Tol\'{u}l\d{o}p\d{\'{e}} \'{O}g\'{u}nr\d{\`{e}}m\'{i}},
  title = {Yorùbá Voice Speech Recorder},
  url = {https://github.com/Niger-Volta-LTI/yoruba-voice-speech-recorder},
  version = {v0.1-alpha},
  date = {2022-08-31},
  year = {2022},
}
```

---

📅 **Last updated**: January 2025  
💬 **For technical support**: Refer to this documentation or contact the development team.
