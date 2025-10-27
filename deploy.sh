#!/bin/bash

# Fncher Production Deployment Script
# This script prepares the site for production deployment

echo "🚀 Starting Fncher production deployment..."

# Check if .env file exists
if [ ! -f "backend/.env" ]; then
    echo "❌ Error: backend/.env file not found!"
    echo "Please copy backend/.env.example to backend/.env and fill in your API keys"
    exit 1
fi

# Check if required variables are set
echo "🔍 Checking environment variables..."

# Read .env file and check for required variables
source backend/.env

required_vars=("FIREBASE_API_KEY" "FIREBASE_AUTH_DOMAIN" "FIREBASE_PROJECT_ID" "FIREBASE_STORAGE_BUCKET" "FIREBASE_MESSAGING_SENDER_ID" "FIREBASE_APP_ID" "STRIPE_PUBLISHABLE_KEY")

missing_vars=()
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        missing_vars+=("$var")
    fi
done

if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "❌ Error: Missing required environment variables:"
    printf '   - %s\n' "${missing_vars[@]}"
    echo "Please set these in your backend/.env file"
    exit 1
fi

echo "✅ All required environment variables are set"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Generate configuration
echo "🔧 Generating configuration..."
npm run build-config

# Check if config was generated successfully
if [ ! -f "js/config.js" ]; then
    echo "❌ Error: Configuration file was not generated!"
    exit 1
fi

echo "✅ Configuration generated successfully"

# Clean up any sensitive files that shouldn't be deployed
echo "🧹 Cleaning up sensitive files..."
rm -f backend/.env.example

# Check if this is a Firebase project
if [ -f "firebase.json" ]; then
    echo "🔥 Firebase project detected"
    echo "Ready for Firebase deployment!"
    echo ""
    echo "Run the following command to deploy:"
    echo "firebase deploy"
else
    echo "📁 Static site ready for deployment"
    echo ""
    echo "Upload all files to your hosting provider"
    echo "Make sure js/config.js is included in the deployment"
fi

echo ""
echo "🎉 Production build complete!"
echo ""
echo "📋 Next steps:"
echo "1. Test your site locally with: npm run dev"
echo "2. Deploy to your hosting provider"
echo "3. Update your Firebase authorized domains if needed"