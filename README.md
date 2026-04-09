# 🔍 Social Media Fake Account Detector

**Advanced AI-powered fake account detection system for social media profiles**

Developed by **Sunit Katuwal (BSc CSIT)**

---

## 🎯 Overview

A production-ready web application that analyzes social media profiles and determines the probability of them being fake accounts. The system uses machine learning-inspired algorithms to evaluate multiple factors including username patterns, follower ratios, engagement metrics, and activity patterns.

### Features
- ✨ Ultra-modern, futuristic UI with glassmorphism design
- 🎨 Smooth animations and micro-interactions
- 📊 Interactive charts and data visualization
- 🌙 Dark/Light theme toggle
- 📱 Fully responsive design (mobile & desktop)
- 🎵 Sound effects for interactions
- 🎯 Multiple platform support (Instagram, TikTok, Twitter/X)
- 🚀 Easy deployment ready

---

## 📁 Project Structure

```
├── frontend/
│   ├── index.html          # Main HTML page
│   ├── style.css           # All styling & animations
│   └── script.js           # Frontend logic & interactions
├── backend/
│   ├── server.js           # Express server
│   ├── package.json        # Node dependencies
│   ├── controllers/
│   │   └── analysisController.js  # Analysis logic
│   └── utils/
│       └── analysis.js     # Analysis algorithms
└── README.md              # This file
```

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn
- Modern web browser (Chrome, Firefox, Safari, Edge)

### Installation

#### 1. Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Start the server
npm start
```

The backend server will start at `http://localhost:3000`

#### 2. Frontend Setup

The frontend is a static web application and doesn't require any build process or installation.

Simply open the `frontend/index.html` file in your web browser, or serve it with a simple HTTP server:

```bash
# Using Python 3
python -m http.server 8000 --directory frontend

# Using Python 2
python -m SimpleHTTPServer 8000
```

Then navigate to `http://localhost:8000` in your browser.

---

## 🎮 How to Use

1. **Select Platform**: Choose between Instagram, TikTok, or Twitter/X
2. **Enter Username**: Type in a username or profile link
3. **Click Analyze**: The system will analyze the account
4. **View Results**: 
   - Fake account probability score (0-100%)
   - Risk level indicator
   - Detailed breakdown of analysis factors
   - Interactive charts showing metrics
5. **Download Report**: Export the analysis as a text file

### Demo Mode
Click the **📊 Demo** button to view example results without analyzing a real account.

---

## 🧪 Testing

### Backend Health Check
```bash
curl http://localhost:3000/health
```

### API Endpoint
```bash
curl -X POST http://localhost:3000/api/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "username": "example_user",
    "platform": "instagram"
  }'
```

---

## 🔧 API Endpoints

### POST /api/analyze
Analyzes a social media account and returns fake score and detailed metrics.

**Request:**
```json
{
  "username": "username_here",
  "platform": "instagram|tiktok|twitter"
}
```

**Response:**
```json
{
  "success": true,
  "username": "username_here",
  "platform": "instagram",
  "fakeScore": 65,
  "followers": 1250,
  "following": 3400,
  "posts": 24,
  "engagementRate": 2.5,
  "activityFrequency": 15,
  "postConsistency": 8,
  "commentRatio": 3,
  "likeDensity": 45,
  "factors": [
    {
      "name": "Username Pattern",
      "description": "Suspicious random characters...",
      "risk": 85,
      "icon": "⚠️"
    }
    // ... more factors
  ]
}
```

### GET /health
Health check endpoint.

**Response:**
```json
{
  "status": "OK",
  "timestamp": "2026-04-09T10:30:00.000Z",
  "service": "Fake Account Detector API"
}
```

---

## 🎨 Design Features

### UI/UX Elements
- **Glassmorphism**: Frosted glass effect with backdrop blur
- **Neumorphism**: Subtle depth and embossing effects
- **Animations**: 
  - Fade-in animations on page load
  - Slide-up animations for content
  - Smooth hover transitions
  - Animated progress bars
  - Pulse effects on score display
- **Custom Cursor**: Interactive cursor with glow trail effect
- **3D Background**: Animated particle system using Three.js
- **Gradient Text**: Dynamic gradient effects on headings

### Theme Support
- Dark theme (default) - Modern dark interface
- Light theme - Clean light interface
- Smooth transitions between themes

---

## 🔊 Audio Effects

The application includes subtle sound effects:
- **Button Click**: Soft beep when clicking buttons
- **Analyze Sound**: Multi-tone sound when starting analysis
- **Success Sound**: Positive sound when analysis completes

---

## 📊 Analysis Factors

The fake account detection considers:

1. **Username Pattern** (25% weight)
   - Excessive numbers
   - Suspicious characters
   - Bot-like naming patterns
   - Account age indicators

2. **Follower Ratio** (25% weight)
   - Followers vs Following balance
   - Unusual ratios
   - Bot follower indicators

3. **Engagement Rate** (25% weight)
   - Verification status
   - Follower-post relationship
   - Interaction patterns

4. **Activity Pattern** (25% weight)
   - Posting consistency
   - Post frequency
   - Temporal distribution

---

## 🌐 Deployment Guide

### Deploy Backend (Heroku)

1. Create a Heroku account and install Heroku CLI
2. Navigate to backend directory
3. Login to Heroku: `heroku login`
4. Create app: `heroku create your-app-name`
5. Deploy: `git push heroku main`

### Deploy Frontend (GitHub Pages, Netlify, or Vercel)

1. Push frontend folder to GitHub
2. Deploy using:
   - GitHub Pages: Enable in repository settings
   - Netlify: Connect repository and deploy
   - Vercel: Connect and deploy

### Environment Variables

No environment variables required for basic setup. To customize:
- Backend port: Set `PORT` environment variable
- CORS settings: Modify in `server.js`

---

## 🔐 Security Notes

- All analysis is simulated/mocked data for demonstration
- No real social media scraping is performed
- No user data is stored or collected
- CORS is enabled for development (should be restricted in production)
- Input validation is implemented for all API endpoints

---

## 🐛 Troubleshooting

### Backend won't start
- Ensure port 3000 is not in use
- Check Node.js is installed: `node --version`
- Check npm is installed: `npm --version`

### Frontend can't reach backend
- Ensure backend is running on port 3000
- Check CORS is enabled in server.js
- Check firewall settings

### Charts not displaying
- Clear browser cache
- Check Chart.js library is loaded
- Check browser console for errors

### 3D background not showing
- Ensure Three.js library is loaded
- Check browser WebGL support
- Try updating graphics drivers

---

## 📱 Browser Compatibility

| Browser | Desktop | Mobile |
|---------|---------|--------|
| Chrome  | ✅      | ✅     |
| Firefox | ✅      | ✅     |
| Safari  | ✅      | ✅     |
| Edge    | ✅      | ✅     |

---

## 🎓 Educational Purpose

This project is designed for educational purposes to demonstrate:
- Full-stack web development
- API design and implementation
- Frontend UI/UX best practices
- Data analysis and visualization
- Real-time data processing
- Animation and interactive design

---

## 📝 License

MIT License - Feel free to use and modify for educational purposes.

---

## 👨‍💻 Developer

**Sunit Katuwal**
- BSc CSIT (Bachelor of Science in Computer Science and Information Technology)
- Full-stack Developer
- UI/UX Designer

---

## 🙏 Credits

Built with:
- [Express.js](https://expressjs.com/) - Backend framework
- [Chart.js](https://www.chartjs.org/) - Data visualization
- [Three.js](https://threejs.org/) - 3D graphics
- [Tailwind CSS](https://tailwindcss.com/) - Utility CSS
- Vanilla JavaScript - Frontend logic

---

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the code comments
3. Check browser console for errors
4. Ensure all dependencies are installed

---

## 🚀 Roadmap

Future enhancements:
- Real API integration with social media platforms
- Machine learning model for better accuracy
- Database for storing analysis history
- User accounts and authentication
- Advanced analytics dashboard
- Mobile native apps
- Real-time account monitoring

---

**Last Updated**: April 9, 2026
**Version**: 1.0.0

---

*Developed by Sunit Katuwal (BSc CSIT)*
