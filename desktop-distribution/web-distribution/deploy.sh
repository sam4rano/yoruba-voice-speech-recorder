#!/bin/bash

# Web Deployment Script
# Uploads the web distribution to your server

echo "🚀 Deploying Yoruba Voice Recorder to web server..."

# Configuration (update these with your server details)
SERVER="your-server.com"
USER="your-username"
REMOTE_PATH="/var/www/html/yoruba-voice-recorder"

# Upload files
echo "Uploading files to server..."
rsync -avz --delete . $USER@$SERVER:$REMOTE_PATH/

echo "✅ Deployment complete!"
echo "Your app is now available at: https://$SERVER/yoruba-voice-recorder/"
