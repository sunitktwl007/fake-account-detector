#!/bin/bash

# Quick Start Setup Script for Social Media Fake Account Detector
# Developed by Sunit Katuwal (BSc CSIT)

echo "╔═══════════════════════════════════════════════════════╗"
echo "║  Social Media Fake Account Detector - Setup Script    ║"
echo "║  Developed by Sunit Katuwal (BSc CSIT)                ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""

# Check if Node.js is installed
echo "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi
echo "✅ Node.js found: $(node --version)"

# Check if npm is installed
echo "Checking npm installation..."
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi
echo "✅ npm found: $(npm --version)"
echo ""

# Install backend dependencies
echo "Installing backend dependencies..."
cd backend
npm install
if [ $? -eq 0 ]; then
    echo "✅ Backend dependencies installed successfully"
else
    echo "❌ Failed to install backend dependencies"
    exit 1
fi
cd ..
echo ""

echo "✅ Setup complete!"
echo ""
echo "🚀 To start the application:"
echo ""
echo "  1. Start the backend server:"
echo "     cd backend && npm start"
echo ""
echo "  2. In another terminal, open the frontend:"
echo "     - Open frontend/index.html in your browser, OR"
echo "     - Run: python -m http.server 8000 --directory frontend"
echo "     - Then visit: http://localhost:8000"
echo ""
echo "✨ Happy analyzing!"
