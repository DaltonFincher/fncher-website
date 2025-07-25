# Fncher - Production Ready Setup

This repository contains the production-ready version of the Fncher website with secure environment variable management.

## 🔧 Setup Instructions

### 1. Environment Configuration

1. Copy the example environment file:
   ```bash
   cp backend/.env.example backend/.env
   ```

2. Fill in your actual API keys in `backend/.env`:
   ```env
   FIREBASE_API_KEY=your_actual_firebase_api_key
   FIREBASE_AUTH_DOMAIN=your_project_id.firebaseapp.com
   FIREBASE_PROJECT_ID=your_actual_project_id
   FIREBASE_STORAGE_BUCKET=your_project_id.appspot.com
   FIREBASE_MESSAGING_SENDER_ID=your_actual_sender_id
   FIREBASE_APP_ID=your_actual_app_id
   FIREBASE_MEASUREMENT_ID=your_actual_measurement_id
   STRIPE_PUBLISHABLE_KEY=pk_test_your_actual_stripe_publishable_key
   STRIPE_SECRET_KEY=sk_test_your_actual_stripe_secret_key
   ```

### 2. Install Dependencies

```bash
npm install
```

### 3. Build Configuration

Generate the configuration file from your environment variables:

```bash
npm run build-config
```

This will create `js/config.js` with your actual API keys loaded from the `.env` file.

### 4. Development

Run the development server:

```bash
npm run dev
```

### 5. Production Build

For production deployment:

```bash
npm run build
```

## 🚀 Deployment

### Firebase Hosting

1. Make sure you have Firebase CLI installed:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Build the configuration:
   ```bash
   npm run build
   ```

4. Deploy:
   ```bash
   firebase deploy
   ```

### Other Static Hosting (Netlify, Vercel, etc.)

1. Build the configuration:
   ```bash
   npm run build
   ```

2. Upload all files to your hosting provider, making sure `js/config.js` is included.

## 🔒 Security Features

- ✅ **No Hardcoded API Keys**: All sensitive configuration is loaded from environment variables
- ✅ **Build-time Configuration**: API keys are injected during build process, not runtime
- ✅ **Environment Separation**: Different configurations for development/staging/production
- ✅ **Error Handling**: Graceful handling of missing configuration

## 📁 File Structure

```
├── homeowner/
│   └── signup.html          # Production-ready signup page
├── backend/
│   ├── .env                 # Your environment variables (do not commit)
│   └── .env.example         # Template for environment variables
├── js/
│   └── config.js            # Auto-generated configuration (do not commit)
├── build-config.js          # Script to generate config from env vars
├── package.json             # Dependencies and build scripts
└── README.md               # This file
```

## 🛠️ Development Workflow

1. **First Time Setup**:
   ```bash
   npm install
   cp backend/.env.example backend/.env
   # Edit backend/.env with your actual keys
   npm run build-config
   ```

2. **Daily Development**:
   ```bash
   npm run dev
   ```

3. **Before Deployment**:
   ```bash
   npm run build
   # Check that js/config.js exists and has the right values
   ```

## ⚠️ Important Notes

- **Never commit** `backend/.env` or `js/config.js` to version control
- Always run `npm run build-config` after updating environment variables
- The `js/config.js` file is auto-generated - don't edit it manually
- For production, make sure to use production Firebase and Stripe keys

## 🔍 Troubleshooting

### Configuration Not Loading
- Make sure you ran `npm run build-config`
- Check that `js/config.js` exists
- Verify all required environment variables are set in `backend/.env`

### Firebase Not Working
- Ensure your Firebase project settings match the environment variables
- Check Firebase console for any configuration issues
- Verify that your domain is authorized in Firebase settings

### Build Script Errors
- Make sure Node.js is installed
- Run `npm install` to install dependencies
- Check that `backend/.env` exists and has all required variables