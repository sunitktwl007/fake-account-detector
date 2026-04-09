# Configuration & Advanced Setup Guide

**Social Media Fake Account Detector**
*Developed by Sunit Katuwal (BSc CSIT)*

---

## 🔧 Backend Configuration

### Environment Variables

Create a `.env` file in the `backend` directory:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# CORS Configuration
CORS_ORIGIN=*
CORS_METHODS=GET,POST,OPTIONS

# Analysis Configuration
SIMULATION_ENABLED=true
CACHE_ENABLED=false
CACHE_TTL=3600

# Logging
LOG_LEVEL=info
```

### Advanced Server Configuration

Edit `backend/server.js` to customize:

```javascript
// Custom CORS settings
const corsOptions = {
    origin: 'http://localhost:3000',
    credentials: true,
    optionsSuccessStatus: 200
};
app.use(cors(corsOptions));

// Custom body limits
app.use(bodyParser.json({ limit: '10mb' }));

// Custom port
const PORT = process.env.PORT || 3000;
```

---

## 🎨 Frontend Customization

### Tailwind CSS Configuration

The frontend uses Tailwind CSS via CDN. To customize colors, edit `frontend/style.css`:

```css
:root {
    --primary-gradient: linear-gradient(135deg, #00d4ff, #0099ff, #9900ff);
    --glass-blur: 10px;
    --glass-opacity: 0.1;
}
```

### Custom Color Schemes

Add theme colors to `frontend/style.css`:

```css
:root.theme-neon {
    --primary-gradient: linear-gradient(135deg, #ff006e, #fb5607, #ffbe0b);
}

:root.theme-ocean {
    --primary-gradient: linear-gradient(135deg, #0077b6, #0096c7, #00b4d8);
}
```

### Animation Speed Control

Modify animation durations in `frontend/style.css`:

```css
:root {
    --transition-smooth: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    --animation-speed: 1s; /* Change to adjust all animation speeds */
}
```

---

## 🌐 API Configuration

### Custom API Base URL

Edit `frontend/script.js`:

```javascript
// Change this to match your deployed backend
const API_BASE_URL = 'https://api.yourdomain.com';
```

### API Request Headers

Add custom headers for authentication or tracking:

```javascript
const response = await fetch(`${API_BASE_URL}/analyze`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN_HERE',
        'X-API-Key': 'your-api-key'
    },
    body: JSON.stringify({ username, platform })
});
```

---

## 🗄️ Database Integration (Optional)

To add database support (MongoDB example):

1. Install dependencies:
```bash
npm install mongoose
```

2. Create `backend/models/Analysis.js`:
```javascript
const mongoose = require('mongoose');

const AnalysisSchema = new mongoose.Schema({
    username: String,
    platform: String,
    fakeScore: Number,
    factors: Array,
    createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Analysis', AnalysisSchema);
```

3. Update `backend/controllers/analysisController.js`:
```javascript
const Analysis = require('../models/Analysis');

// Save analysis to database
const analysis = new Analysis({
    username,
    platform,
    fakeScore: result.fakeScore,
    factors: result.factors
});

await analysis.save();
```

---

## 📦 Docker Deployment

Create `Dockerfile` in root:

```dockerfile
FROM node:16-alpine

WORKDIR /app

# Backend
COPY backend/package.json backend/
RUN cd backend && npm install

# Copy all files
COPY . .

EXPOSE 3000

CMD ["node", "backend/server.js"]
```

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
  
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./frontend:/usr/share/nginx/html
```

Run:
```bash
docker-compose up -d
```

---

## 🚀 Deploy to Different Platforms

### Heroku Deployment

1. Create `Procfile` in `backend`:
```
web: node server.js
```

2. Deploy:
```bash
cd backend
heroku create your-app-name
git push heroku main
```

### Vercel Deployment (Frontend)

```bash
npm install -g vercel
cd frontend
vercel
```

### AWS Deployment

1. Create EC2 instance
2. SSH into instance
3. Clone repository:
```bash
git clone your-repo-url
cd your-repo
cd backend
npm install
npm start
```

### Google Cloud Run (Backend)

```bash
cd backend
gcloud run deploy fake-detector \
  --source . \
  --platform managed \
  --region us-central1
```

---

## 🔐 Security Best Practices

### CORS Configuration for Production

```javascript
const corsOptions = {
    origin: ['https://yourdomain.com', 'https://www.yourdomain.com'],
    credentials: true,
    methods: ['POST', 'GET'],
    allowedHeaders: ['Content-Type']
};

app.use(cors(corsOptions));
```

### Rate Limiting

Install: `npm install express-rate-limit`

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per windowMs
});

app.use('/api/', limiter);
```

### Input Validation

```javascript
const validator = require('validator');

function validateInput(username, platform) {
    if (!username || !platform) return false;
    if (username.length < 2 || username.length > 100) return false;
    if (!['instagram', 'tiktok', 'twitter'].includes(platform)) return false;
    return true;
}
```

---

## 📊 Performance Optimization

### Frontend Optimization

1. Lazy load Three.js:
```javascript
// Only load Three.js when window is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initThreeJSBackground);
} else {
    initThreeJSBackground();
}
```

2. Compress assets:
```bash
# Install ImageOptim or similar tool
# Compress images and CSS/JS files
```

### Backend Optimization

1. Enable response compression:
```bash
npm install compression
```

```javascript
const compression = require('compression');
app.use(compression());
```

2. Add caching:
```javascript
app.use((req, res, next) => {
    res.set('Cache-Control', 'public, max-age=3600');
    next();
});
```

---

## 🧪 Testing

### Backend Testing

Install: `npm install jest --save-dev`

Create `backend/tests/analysis.test.js`:

```javascript
const { analyzeUsername } = require('../utils/analysis');

test('analyzeUsername returns risk score', () => {
    const risk = analyzeUsername('test_user_123', 123);
    expect(typeof risk).toBe('number');
    expect(risk).toBeGreaterThanOrEqual(0);
    expect(risk).toBeLessThanOrEqual(100);
});
```

Run: `npm test`

### Frontend Testing

Install: `npm install cypress --save-dev`

Create test in `cypress/e2e/analysis.cy.js`:

```javascript
describe('Analysis Page', () => {
    it('loads the analysis form', () => {
        cy.visit('http://localhost:8000');
        cy.get('#username-input').should('be.visible');
        cy.get('#analyze-btn').should('be.visible');
    });

    it('submits analysis form', () => {
        cy.get('#username-input').type('testuser');
        cy.get('#analyze-btn').click();
        cy.get('#results-section').should('be.visible');
    });
});
```

---

## 📈 Analytics Integration

Add Google Analytics:

```html
<!-- In frontend/index.html before closing </head> -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

---

## 🔄 CI/CD Pipeline

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '16'
      - run: cd backend && npm install
      - run: npm test

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm run build
      - uses: actions/upload-artifact@v2
        with:
          name: build
          path: build/
```

---

## 🎯 Feature Flags

Add feature flags in `backend/server.js`:

```javascript
const features = {
    SIMULATION_MODE: true,
    ADVANCED_ANALYTICS: false,
    REAL_SCRAPING: false,
    CACHING: false
};

app.get('/api/features', (req, res) => {
    res.json(features);
});
```

---

## 📝 Logging & Monitoring

Install: `npm install winston`

```javascript
const winston = require('winston');

const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    transports: [
        new winston.transports.File({ filename: 'error.log', level: 'error' }),
        new winston.transports.File({ filename: 'combined.log' })
    ]
});

// Usage
logger.info('Account analyzed', { username, fakeScore });
```

---

## 🌍 Multi-Language Support

Add in `frontend/script.js`:

```javascript
const translations = {
    en: { button: 'Analyze', result: 'Analysis Complete' },
    es: { button: 'Analizar', result: 'Análisis Completo' },
    fr: { button: 'Analyser', result: 'Analyse Complète' }
};

function setLanguage(lang) {
    currentLanguage = lang;
    updateUI();
}
```

---

*For more information, see README.md*

*Developed by Sunit Katuwal (BSc CSIT)*
