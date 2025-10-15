# App Icons and Assets

This directory contains the app icons and other assets needed for desktop distribution.

## Required Files

### macOS Icons
- `icon.icns` - macOS app icon bundle (1024x1024 source)
- `icon_1024.png` - Source PNG for icon.icns
- `icon_512.png` - 512x512 version
- `icon_256.png` - 256x256 version
- `icon_128.png` - 128x128 version
- `icon_32.png` - 32x32 version

### Windows Icons
- `icon.ico` - Windows app icon (256x256 source)
- `icon_256.png` - Source PNG for icon.ico
- `icon_150.png` - 150x150 version
- `icon_44.png` - 44x44 version

## Creating Icons

### From a 1024x1024 PNG source:

#### macOS (.icns)
```bash
# Create icon.icns from PNG files
iconutil -c icns icon.iconset
```

#### Windows (.ico)
```bash
# Create icon.ico from PNG files
# Use online converter or ImageMagick
convert icon_256.png icon_150.png icon_44.png icon.ico
```

## Design Guidelines

### App Icon Design
- **Style**: Clean, modern, recognizable
- **Colors**: Use Yoruba cultural colors (green, white, red)
- **Symbols**: Microphone, sound waves, or Yoruba text
- **Background**: Simple, not cluttered
- **Text**: Avoid small text that won't be readable at small sizes

### Technical Requirements
- **Format**: PNG source files, final formats as specified
- **Transparency**: Supported for both platforms
- **Quality**: High resolution, sharp edges
- **Consistency**: Same design across all sizes

## Current Status
- [ ] Create 1024x1024 source icon
- [ ] Generate all required sizes
- [ ] Create macOS .icns file
- [ ] Create Windows .ico file
- [ ] Test icons in built applications
