# 🏪 Store Submission Guide: Mac App Store & Microsoft Store

This guide walks you through the complete process of submitting your Yoruba Voice Speech Recorder to both the Mac App Store and Microsoft Store.

## 📋 **Quick Start Checklist**

### **Immediate Actions Required**
- [ ] **Apple Developer Account** ($99/year) - [developer.apple.com](https://developer.apple.com)
- [ ] **Microsoft Partner Center Account** ($19 one-time) - [partner.microsoft.com](https://partner.microsoft.com)
- [ ] **Domain & Email** for privacy policy and support
- [ ] **Company/Developer Name** for store listings

---

## 🍎 **Mac App Store Submission**

### **Phase 1: Apple Developer Setup (1-2 days)**
1. **Enroll in Apple Developer Program**
   - Visit [developer.apple.com](https://developer.apple.com)
   - Choose "Individual" or "Organization" account
   - Pay $99/year fee
   - Complete identity verification

2. **Set up App Store Connect**
   - Log into [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   - Create new app with bundle ID: `com.yorubavoice.recorder`
   - Fill in basic app information

### **Phase 2: Code Signing & Notarization (2-3 days)**
1. **Create Certificates**
   ```bash
   # In Keychain Access or Xcode
   # Create "Mac App Store" certificate
   # Create "Developer ID Application" certificate
   ```

2. **Code Sign Your App**
   ```bash
   # Sign the app bundle
   codesign --force --deep --sign "Developer ID Application: Your Name" YorubaVoiceRecorder.app
   ```

3. **Notarize the App**
   ```bash
   # Create zip file
   ditto -c -k --keepParent YorubaVoiceRecorder.app YorubaVoiceRecorder.zip
   
   # Submit for notarization
   xcrun altool --notarize-app --primary-bundle-id "com.yorubavoice.recorder" --username "your-email@domain.com" --password "app-specific-password" --file YorubaVoiceRecorder.zip
   ```

### **Phase 3: App Store Connect Setup (1 day)**
1. **App Information**
   - **Name**: Yoruba Voice Speech Recorder
   - **Subtitle**: Record and preserve Yoruba language voice samples
   - **Category**: Education
   - **Age Rating**: 4+ (suitable for all ages)
   - **Keywords**: yoruba, voice, speech, recording, language, africa, education

2. **App Description**
   ```
   Record and preserve Yoruba language voice samples for research and education.
   
   Features:
   • High-quality voice recording with professional audio processing
   • Random prompt selection from curated Yoruba text samples
   • Metadata tracking for research purposes
   • Easy-to-use graphical interface
   • Command-line mode for advanced users
   • Cross-platform compatibility
   
   Perfect for:
   • Linguists studying Yoruba language
   • Language preservation initiatives
   • Educational institutions
   • Cultural organizations
   • Voice data collection projects
   ```

3. **Screenshots Required**
   - 1280x800 (MacBook Air 13")
   - 1440x900 (MacBook Pro 13")
   - 1680x1050 (MacBook Pro 15")
   - 2560x1600 (MacBook Pro 16")

### **Phase 4: Privacy & Legal (1 day)**
1. **Privacy Policy** (Required for microphone access)
   - Host on your website
   - Include data collection practices
   - Explain microphone usage

2. **App Store Review Guidelines**
   - Ensure compliance with Apple's guidelines
   - Test thoroughly on different macOS versions

---

## 🪟 **Microsoft Store Submission**

### **Phase 1: Microsoft Partner Center Setup (1 day)**
1. **Create Partner Center Account**
   - Visit [partner.microsoft.com](https://partner.microsoft.com)
   - Register as developer
   - Pay $19 one-time fee
   - Complete identity verification

2. **Create App Identity**
   - App name: Yoruba Voice Speech Recorder
   - Package name: YorubaVoiceRecorder
   - Publisher: Your Company Name

### **Phase 2: MSIX Package Creation (2-3 days)**
1. **Install Windows SDK**
   - Download from Microsoft website
   - Install Windows 10 SDK (version 10.0.22621.0 or later)

2. **Create MSIX Package**
   ```bash
   # Use the provided build_msix.bat script
   cd windows-store-prep
   build_msix.bat
   ```

3. **Sign MSIX Package**
   ```bash
   # Sign with your certificate
   signtool sign /fd SHA256 /f "your-certificate.pfx" /p "password" YorubaVoiceRecorder.msix
   ```

### **Phase 3: Store Listing (1 day)**
1. **App Information**
   - **Name**: Yoruba Voice Speech Recorder
   - **Category**: Education
   - **Age Rating**: E (Everyone)
   - **Keywords**: yoruba, voice, speech, recording, language, africa

2. **Description**
   ```
   Record and preserve Yoruba language voice samples for research and education.
   
   This application helps collect high-quality audio recordings of Yoruba speech for linguistic research, language preservation, and educational purposes.
   
   Features:
   • High-quality voice recording
   • Random prompt selection
   • Metadata tracking
   • Easy-to-use interface
   • Command-line and GUI modes
   ```

---

## 🛠️ **Technical Preparation**

### **Run Preparation Scripts**
```bash
# Prepare for Mac App Store
cd desktop-distribution
./scripts/prepare_app_store.sh

# Prepare for Windows Store
./scripts/prepare_windows_store.sh
```

### **Required Assets**
1. **App Icons** ✅ (Already created)
   - macOS: `icon.icns` (multiple sizes)
   - Windows: `icon.ico` (multiple sizes)

2. **Screenshots** (Need to create)
   - Take screenshots of your app running
   - Show main interface, recording screen, settings
   - Use different window sizes for different requirements

3. **Privacy Policy** (Need to create)
   - Host on your website
   - Include microphone usage explanation
   - Data collection and storage practices

---

## 💰 **Costs Summary**

| Store | Account Fee | Annual Cost | Total First Year |
|-------|-------------|-------------|------------------|
| Mac App Store | $99 | $99 | $99 |
| Microsoft Store | $19 | $0 | $19 |
| **Total** | | | **$118** |

---

## ⏱️ **Timeline Estimate**

| Phase | Mac App Store | Microsoft Store | Notes |
|-------|---------------|-----------------|-------|
| Account Setup | 1-2 days | 1 day | Verification required |
| Code Signing | 2-3 days | 2-3 days | Certificate creation |
| Store Listing | 1 day | 1 day | Metadata and assets |
| Review Process | 1-7 days | 1-3 days | Apple is typically slower |
| **Total** | **5-13 days** | **5-8 days** | **Can be done in parallel** |

---

## 🚀 **Getting Started**

1. **Run the preparation scripts** to create all necessary files
2. **Get developer accounts** for both stores
3. **Create privacy policy** and host it online
4. **Take screenshots** of your app
5. **Follow the step-by-step checklists** in the generated files

---

## 📞 **Support Resources**

- **Apple Developer Documentation**: [developer.apple.com/documentation](https://developer.apple.com/documentation)
- **Microsoft Store Documentation**: [docs.microsoft.com/en-us/windows/uwp/publish](https://docs.microsoft.com/en-us/windows/uwp/publish)
- **App Store Review Guidelines**: [developer.apple.com/app-store/review/guidelines](https://developer.apple.com/app-store/review/guidelines)

---

## ✅ **Success Metrics**

After successful submission, you can track:
- **Downloads** from both stores
- **User ratings** and reviews
- **Revenue** (if you choose to monetize)
- **Usage analytics** (if implemented)

Your Yoruba Voice Speech Recorder will help preserve an important language and serve researchers, educators, and cultural organizations worldwide! 🌍
