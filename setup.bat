@echo off
REM Quick Start Setup Script for Social Media Fake Account Detector
REM Developed by Sunit Katuwal (BSc CSIT)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  Social Media Fake Account Detector - Setup Script    ║
echo ║  Developed by Sunit Katuwal (BSc CSIT)                ║
echo ╚═══════════════════════════════════════════════════════╝
echo.

REM Check if Node.js is installed
echo Checking Node.js installation...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js is not installed. Please install Node.js first.
    echo    Visit: https://nodejs.org/
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✅ Node.js found: %NODE_VERSION%

REM Check if npm is installed
echo Checking npm installation...
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ npm is not installed. Please install npm first.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✅ npm found: %NPM_VERSION%
echo.

REM Install backend dependencies
echo Installing backend dependencies...
cd backend
call npm install
if %ERRORLEVEL% EQU 0 (
    echo ✅ Backend dependencies installed successfully
) else (
    echo ❌ Failed to install backend dependencies
    cd ..
    pause
    exit /b 1
)
cd ..
echo.

echo ✅ Setup complete!
echo.
echo 🚀 To start the application:
echo.
echo   1. Start the backend server:
echo      - Open Command Prompt/PowerShell
echo      - Navigate to: cd backend
echo      - Run: npm start
echo.
echo   2. Open the frontend:
echo      - Open frontend/index.html in your web browser, OR
echo      - Use Python: python -m http.server 8000 --directory frontend
echo      - Then visit: http://localhost:8000
echo.
echo ✨ Happy analyzing!
echo.
pause
