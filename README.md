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
