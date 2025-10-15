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
