# Quick Reference Guide

**Social Media Fake Account Detector** - Developer Quick Reference
*Developed by Sunit Katuwal (BSc CSIT)*

---

## 🎯 Project Overview

```
Social Media Fake Account Detector
├── Frontend (Vanilla JS + HTML + CSS)
├── Backend (Node.js + Express)
└── Utilities (Analysis algorithms)
```

---

## 🚀 Quick Start Commands

```bash
# Setup
cd backend && npm install

# Start Backend
cd backend && npm start
# Runs on: http://localhost:3000

# Start Frontend
# Option 1: Open frontend/index.html in browser
# Option 2: python -m http.server 8000 --directory frontend
# Access: http://localhost:8000
```

---

## 📁 File Structure at a Glance

```
project/
├── frontend/
│   ├── index.html       ← Main UI
│   ├── style.css        ← All styling & animations
│   └── script.js        ← Frontend logic, API calls, 3D effects
│
├── backend/
│   ├── server.js        ← Express server, routes
│   ├── package.json     ← Dependencies
│   ├── controllers/
│   │   └── analysisController.js ← Analysis logic
│   └── utils/
│       └── analysis.js   ← Analysis algorithms
│
├── README.md            ← Main documentation
├── API_DOCUMENTATION.md ← API reference
└── CONFIGURATION.md     ← Advanced setup
```

---

## 🔑 Key Files & Their Purpose

| File | Purpose | Key Functions |
|------|---------|---|
| `index.html` | Main page structure | Form, results display |
| `style.css` | All styling | Glassmorphism, animations |
| `script.js` | Frontend logic | API calls, 3D, charts |
| `server.js` | Express app | Routes, middleware |
| `analysisController.js` | API handler | Process requests |
| `analysis.js` | Analysis logic | Calculate risk scores |

---

## 🧠 Core Analysis Algorithms

### Risk Scoring Formula
```
Fake Score = (25% Username) + (25% Ratio) + (25% Engagement) + (25% Activity)
```

### Analysis Factors
1. **Username Pattern** - Detects suspicious naming patterns
2. **Follower Ratio** - Analyzes followers vs following
3. **Engagement Rate** - Checks engagement metrics
4. **Activity Pattern** - Evaluates posting consistency
5. **Verification** - Checks if account is verified

---

## 🌐 API Endpoints

```
POST /api/analyze
├── Input: { username, platform }
├── Output: { fakeScore, factors, metrics }
└── Status: 200-500

GET /health
├── Output: { status, service }
└── Status: 200
```

---

## 🎨 Frontend Architecture

```javascript
// Initialization
initThreeJSBackground()  // 3D particles

// User Input
analyzeAccount()         // Main function

// API Communication
fetch(API_BASE_URL)      // Send to backend

// Display Results
displayResults()         // Show analysis
createEngagementChart()  // Chart.js
createFactorsChart()     // Chart.js

// Notifications
showError()              // Error toast
showSuccess()            // Success toast
```

---

## ⚙️ Backend Architecture

```
Express Server
├── Middleware
│   ├── CORS
│   └── Body Parser
├── Routes
│   ├── POST /api/analyze → analysisController
│   ├── GET /health
│   └── GET /
└── Utils
    └── Analysis algorithms
```

---

## 🎯 Common Tasks

### Add New Platform
1. Edit `frontend/index.html` - Add platform radio button
2. Edit `backend/analysisController.js` - Add validation
3. Test with API

### Change Colors
Edit `frontend/style.css`:
```css
:root {
    --primary-gradient: linear-gradient(135deg, #color1, #color2, #color3);
}
```

### Modify Risk Calculation
Edit `backend/utils/analysis.js`:
```javascript
function analyzeUsername(username, seed) {
    let risk = 20; // Base risk
    // ... modify logic ...
    return risk;
}
```

### Add New Analysis Factor
1. Create function in `backend/utils/analysis.js`
2. Call function in `analysisController.js`
3. Add to `factors` array in results

### Change API Port
1. Backend: Edit `backend/server.js` - Change PORT
2. Frontend: Edit `frontend/script.js` - Update API_BASE_URL

---

## 📊 Important Variables

### Frontend (script.js)
```javascript
API_BASE_URL          // Backend server URL
mouse.x, mouse.y      // Cursor position
soundContext          // Web Audio API
engagementChart       // Chart.js instance
factorsChart          // Chart.js instance
```

### Backend (analysisController.js)
```javascript
username              // Input username
platform              // Selected platform
fakeScore             // 0-100 risk percentage
factors               // Array of analysis items
```

---

## 🔍 Debug Tips

### Frontend Issues
```javascript
// Check API connection
fetch('http://localhost:3000/health')
    .then(r => r.json())
    .then(d => console.log(d))

// Check CSS animations
document.body.classList.toggle('debug-mode')

// Check 3D canvas
console.log(scene, camera, renderer)
```

### Backend Issues
```bash
# Check server is running
curl http://localhost:3000/health

# Test API
curl -X POST http://localhost:3000/api/analyze \
  -H "Content-Type: application/json" \
  -d '{"username":"test","platform":"instagram"}'

# Check logs
tail -f error.log
```

---

## 🐛 Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Port 3000 already in use | Change PORT in `server.js` or kill process |
| CORS errors | Check origin in server.js CORS settings |
| 3D background not showing | Clear cache, check WebGL support |
| Charts not displaying | Verify Chart.js library is loaded |
| Sounds not working | Check browser audio permissions |
| Animations stuttering | Reduce animation complexity in CSS |

---

## 📈 Performance Tips

1. **Lazy load Three.js** - Only init when needed
2. **Debounce cursor movement** - Reduce updates
3. **Cache API responses** - Store in localStorage
4. **Minimize repaints** - Use will-change CSS
5. **Compress assets** - Minify CSS/JS before deploy

---

## 🔐 Security Checklist

- [ ] Validate all input (frontend + backend)
- [ ] Sanitize user input
- [ ] Use HTTPS in production
- [ ] Implement rate limiting
- [ ] Add authentication for admin
- [ ] Log security events
- [ ] Keep dependencies updated
- [ ] Use environment variables

---

## 📦 Dependencies

### Frontend
- Tailwind CSS (via CDN)
- Chart.js (via CDN)
- Three.js (via CDN)
- No npm packages needed

### Backend
- express (4.18.2)
- cors (2.8.5)
- body-parser (1.20.2)

---

## 🚀 Deployment Checklist

- [ ] Set NODE_ENV=production
- [ ] Update API_BASE_URL in frontend
- [ ] Configure CORS properly
- [ ] Enable HTTPS
- [ ] Set up monitoring
- [ ] Configure logging
- [ ] Test all endpoints
- [ ] Optimize assets
- [ ] Set up backups
- [ ] Configure CDN

---

## 📞 Quick Contacts

- **Developer:** Sunit Katuwal (BSc CSIT)
- **Issue Tracker:** Check project repo
- **Documentation:** See README.md
- **API Docs:** See API_DOCUMENTATION.md

---

## 🎓 Learning Resources

### Concepts Used
- Vanilla JavaScript
- Express.js REST API
- Chart.js visualization
- Three.js 3D graphics
- Glassmorphism UI
- Responsive Design
- Web Audio API

### Recommended Learning
- MDN Web Docs (JavaScript)
- Express.js Official Docs
- Chart.js Documentation
- Three.js Tutorial
- CSS Animation Guides

---

## 📝 Code Style Guide

```javascript
// Use meaningful variable names
const analysisResult // ✓ good
const res           // ✗ avoid

// Add comments for complex logic
// Calculate risk based on follower ratio
const risk = followers / following

// Use arrow functions
const analyze = (data) => { }  // ✓ good
const analyze = function() { } // ✗ avoid

// Use const by default
const MAX_LENGTH = 100      // ✓ good
var username = "abc"        // ✗ avoid
```

---

## 🔄 Development Workflow

1. **Plan** → Figure out what to build
2. **Code** → Write the code
3. **Test** → Test locally
4. **Commit** → Commit to git
5. **Deploy** → Deploy to production
6. **Monitor** → Watch for errors

---

## 💡 Pro Tips

1. Use browser DevTools → F12 or Right-click → Inspect
2. Use `console.log()` for debugging
3. Use `network` tab to see API calls
4. Use `performance` tab to measure speed
5. Use git for version control
6. Write comments for complex code
7. Keep code DRY (Don't Repeat Yourself)
8. Test edge cases (empty input, invalid data)

---

## 🎯 Next Steps

- [ ] Understand the codebase
- [ ] Run the application locally
- [ ] Try modifying colors
- [ ] Add a new platform
- [ ] Deploy to cloud
- [ ] Add authentication
- [ ] Integrate with real API

---

*For detailed information, see README.md, API_DOCUMENTATION.md, and CONFIGURATION.md*

*Developed by Sunit Katuwal (BSc CSIT)*
