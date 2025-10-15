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
