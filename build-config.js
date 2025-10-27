#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: './backend/.env' });

// Configuration template
const configTemplate = `
// Auto-generated configuration file - DO NOT EDIT MANUALLY
// This file is generated from environment variables during build

window.FncherConfig = {
  firebase: {
    apiKey: "${process.env.FIREBASE_API_KEY}",
    authDomain: "${process.env.FIREBASE_AUTH_DOMAIN}",
    projectId: "${process.env.FIREBASE_PROJECT_ID}",
    storageBucket: "${process.env.FIREBASE_STORAGE_BUCKET}",
    messagingSenderId: "${process.env.FIREBASE_MESSAGING_SENDER_ID}",
    appId: "${process.env.FIREBASE_APP_ID}",
    measurementId: "${process.env.FIREBASE_MEASUREMENT_ID}"
  },
  stripe: {
    publishableKey: "${process.env.STRIPE_PUBLISHABLE_KEY}"
  }
};

// Initialize Firebase automatically
if (typeof firebase !== 'undefined') {
  firebase.initializeApp(window.FncherConfig.firebase);
  window.db = firebase.firestore();
  window.auth = firebase.auth();
}
`;

// Ensure js directory exists
const jsDir = path.join(__dirname, 'js');
if (!fs.existsSync(jsDir)) {
  fs.mkdirSync(jsDir, { recursive: true });
}

// Write the configuration file
const configPath = path.join(jsDir, 'config.js');
fs.writeFileSync(configPath, configTemplate);

console.log('✅ Configuration file generated successfully!');
console.log('📁 File location:', configPath);

// Validate that all required environment variables are set
const requiredVars = [
  'FIREBASE_API_KEY',
  'FIREBASE_AUTH_DOMAIN', 
  'FIREBASE_PROJECT_ID',
  'FIREBASE_STORAGE_BUCKET',
  'FIREBASE_MESSAGING_SENDER_ID',
  'FIREBASE_APP_ID',
  'STRIPE_PUBLISHABLE_KEY'
];

const missingVars = requiredVars.filter(varName => !process.env[varName]);

if (missingVars.length > 0) {
  console.log('⚠️  Warning: Missing environment variables:');
  missingVars.forEach(varName => {
    console.log(`   - ${varName}`);
  });
  console.log('   Please set these in your backend/.env file');
} else {
  console.log('✅ All required environment variables are set!');
}