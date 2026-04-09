# Deployment Guide

**Social Media Fake Account Detector** - Complete Deployment Instructions
*Developed by Sunit Katuwal (BSc CSIT)*

---

## Table of Contents

1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Local Deployment](#local-deployment)
3. [Cloud Deployments](#cloud-deployments)
4. [Production Configuration](#production-configuration)
5. [Troubleshooting](#troubleshooting)

---

## Pre-Deployment Checklist

Before deploying, ensure:

- [ ] All dependencies installed (`npm install`)
- [ ] Application tested locally
- [ ] Environment variables configured
- [ ] API endpoints verified
- [ ] Frontend assets optimized
- [ ] Security settings reviewed
- [ ] CORS configured for production domain
- [ ] Error logging enabled
- [ ] Monitoring setup complete
- [ ] Backup plan exists

---

## Local Deployment

### Development Environment

```bash
# Backend
cd backend
npm install
npm start
# Runs on http://localhost:3000

# Frontend (in another terminal)
cd frontend
python -m http.server 8080
# Access at http://localhost:8080
```

### Production Like Setup

```bash
# Install production dependencies
cd backend
npm install --production

# Set environment
export NODE_ENV=production
export PORT=3000

# Start with process manager (PM2)
npm install -g pm2
pm2 start server.js --name "fake-detector"
pm2 save
pm2 startup
```

---

## Cloud Deployments

### 1. Heroku Deployment

#### Prepare Application

1. Create `Procfile` in `backend/`:
```
web: node server.js
```

2. Create `.env` file:
```
NODE_ENV=production
PORT=3000
```

#### Deploy

```bash
# Install Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli

# Login
heroku login

# Create app
heroku create your-app-name

# Set environment variables
heroku config:set NODE_ENV=production

# Deploy
git push heroku main

# View logs
heroku logs --tail

# Open app
heroku open
```

#### Cost
- **Free tier**: Available (limited)
- **Paid**: Starting $7/month
- **Scaling**: Dyno hours

---

### 2. Vercel Deployment (Frontend)

#### Prepare

1. Push code to GitHub
2. Create `vercel.json` in root:
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "frontend",
  "env": {
    "NEXT_PUBLIC_API_URL": "@api_url"
  }
}
```

#### Deploy

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Set production environment
vercel env add NEXT_PUBLIC_API_URL https://your-api.com

# Deploy to production
vercel --prod
```

#### Cost
- **Free tier**: Generous free plan
- **Pro**: $20/month
- **Unlimited bandwidth**

---

### 3. Netlify Deployment (Frontend)

#### Prepare

1. Create `netlify.toml` in root:
```toml
[build]
  command = "echo 'Frontend ready'"
  publish = "frontend"

[dev]
  publish = "frontend"
  command = "echo 'Dev mode'"

[[redirects]]
  from = "/api/*"
  to = "https://your-api.com/api/:splat"
  status = 200
```

#### Deploy

```bash
# Connect GitHub repository
# Or use Netlify CLI
npm install -g netlify-cli
netlify deploy --prod --dir frontend
```

#### Cost
- **Free**: Unlimited sites, 1 concurrent build
- **Pro**: $19/month
- **Enterprise**: Custom pricing

---

### 4. AWS Deployment

#### EC2 Setup

```bash
# 1. Create EC2 instance (Ubuntu 20.04)

# 2. Connect via SSH
ssh -i your-key.pem ubuntu@your-instance-ip

# 3. Install Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# 4. Clone repository
git clone your-repo.git
cd your-repo

# 5. Install dependencies
cd backend && npm install

# 6. Install PM2
sudo npm install -g pm2

# 7. Start application
pm2 start server.js
pm2 startup
pm2 save

# 8. Configure Nginx
sudo apt-get install nginx
# Configure proxy to localhost:3000

# 9. Enable HTTPS with Let's Encrypt
sudo apt-get install certbot python3-certbot-nginx
sudo certbot certonly --nginx -d yourdomain.com
```

#### Cost
- **EC2**: $0.0116/hour (~$8.50/month for t2.micro)
- **Data transfer**: Varies
- **Storage**: $0.10/GB/month

---

### 5. Google Cloud Run (Backend)

```bash
# 1. Create `cloudbuild.yaml`
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/fake-detector', '.']
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/fake-detector']
  - name: 'gcr.io/cloud-builders/gke-deploy'
    args: ['run', '--filename=k8s/']

# 2. Create Dockerfile
FROM node:16-alpine
WORKDIR /app
COPY backend/package.json .
RUN npm install --production
COPY backend/ .
EXPOSE 3000
CMD ["node", "server.js"]

# 3. Deploy
gcloud run deploy fake-detector \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

#### Cost
- **Free tier**: 2 million requests/month
- **Paid**: $0.40 per million requests
- **Execution time**: 180 second timeout

---

### 6. Railway Deployment

```bash
# 1. Install Railway CLI
npm i -g @railway/cli

# 2. Login
railway login

# 3. Create project
railway init

# 4. Add service
railway add --name fake-detector

# 5. Deploy
railway up

# 6. View logs
railway logs
```

#### Cost
- **Pay-as-you-go**: ~$5-10/month typical
- **No credit card needed initially**

---

### 7. DigitalOcean App Platform

```bash
# 1. Create app.yaml in root
apps:
  - name: fake-detector
    github:
      repo: username/repo
      branch: main
    services:
      - name: api
        source_dir: backend
        build_command: "npm install"
        run_command: "npm start"
        http_port: 3000
      - name: web
        source_dir: frontend
        http_port: 80

# 2. Deploy via DigitalOcean console
# Or use doctl:
doctl apps create --spec=app.yaml
```

#### Cost
- **Starter**: $12+/month
- **Pay-as-you-go**: ~$0.018/hour compute

---

## Production Configuration

### Environment Variables

Create `.env` file in `backend/`:

```env
# Server
NODE_ENV=production
PORT=3000
HOSTNAME=0.0.0.0

# CORS
CORS_ORIGIN=https://yourdomain.com
CORS_CREDENTIALS=true

# Security
RATE_LIMIT_WINDOW=15m
RATE_LIMIT_MAX=100

# Logging
LOG_LEVEL=info
LOG_FILE=logs/app.log

# Analytics
ENABLE_ANALYTICS=true
GOOGLE_ANALYTICS_ID=UA-XXXXXXXXX-X
```

### Nginx Configuration

Create `/etc/nginx/sites-available/fake-detector`:

```nginx
upstream backend {
    server localhost:3000;
}

server {
    listen 80;
    server_name yourdomain.com;
    
    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    # SSL certificates (Let's Encrypt)
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # Security headers
    add_header Strict-Transport-Security "max-age=31536000" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;

    # Compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript;

    # Frontend
    location / {
        root /var/www/fake-detector/frontend;
        try_files $uri /index.html;
    }

    # API
    location /api {
        proxy_pass http://backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### PM2 Ecosystem File

Create `ecosystem.config.js`:

```javascript
module.exports = {
  apps: [{
    name: 'fake-detector-api',
    script: './server.js',
    cwd: './backend/',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production'
    },
    error_file: './logs/error.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    merge_logs: true,
    autorestart: true,
    watch: false,
    max_memory_restart: '500M',
    time: true
  }]
};
```

Start with:
```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

---

## SSL/HTTPS Setup

### Using Let's Encrypt (Free)

```bash
# Install Certbot
sudo apt-get install certbot python3-certbot-nginx

# Generate certificate
sudo certbot certonly --standalone -d yourdomain.com

# Auto-renewal
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer
```

### Using Cloudflare (Free)

1. Add domain to Cloudflare
2. Change nameservers
3. Enable Universal SSL
4. Set Flexible SSL mode

---

## Monitoring & Logging

### Application Monitoring

```bash
# Install PM2 monitoring
pm2 install pm2-logrotate
pm2 install pm2-auto-kill

# View metrics
pm2 monit
```

### Log Aggregation (ELK Stack)

```yaml
version: '3'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.0.0
    environment:
      - discovery.type=single-node
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:8.0.0
    ports:
      - "5601:5601"

  logstash:
    image: docker.elastic.co/logstash/logstash:8.0.0
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf
    ports:
      - "5000:5000"
```

---

## Performance Optimization

### CDN Setup (Cloudflare)

1. Sign up for Cloudflare account
2. Change nameservers
3. Enable caching rules
4. Enable Brotli compression
5. Enable HTTP/2

### Database Optimization

```javascript
// Enable query caching
const cache = {};

function getCachedAnalysis(key) {
    return cache[key];
}

function setCachedAnalysis(key, data) {
    cache[key] = data;
    // Clear after 1 hour
    setTimeout(() => delete cache[key], 3600000);
}
```

---

## Backup Strategy

```bash
# Daily backups
0 2 * * * /home/user/backup.sh

# Backup script
#!/bin/bash
DATE=$(date +\%Y-\%m-\%d)
tar -czf /backups/fake-detector-$DATE.tar.gz /var/www/fake-detector/
aws s3 cp /backups/fake-detector-$DATE.tar.gz s3://your-bucket/backups/
```

---

## Troubleshooting

### Can't connect to backend
```bash
# Check if running
curl http://localhost:3000/health

# Check logs
pm2 logs

# Restart
pm2 restart all
```

### CORS errors
```javascript
// Update in server.js
const corsOptions = {
    origin: 'https://yourdomain.com',
    credentials: true
};
```

### High memory usage
```bash
# Check memory
free -h

# Increase swap
sudo dd if=/dev/zero of=/swapfile bs=1G count=2
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Slow API responses
```bash
# Monitor performance
pm2 monit

# Enable compression
npm install compression

# Add to server.js
const compression = require('compression');
app.use(compression());
```

---

## Post-Deployment Testing

```bash
# Health check
curl https://yourdomain.com/health

# API test
curl -X POST https://yourdomain.com/api/analyze \
  -H "Content-Type: application/json" \
  -d '{"username":"test","platform":"instagram"}'

# SSL test
https://www.ssllabs.com/ssltest/

# Performance test
https://pagespeed.web.dev/

# Uptime monitoring
https://uptimerobot.com/
```

---

## Scaling Strategy

### Horizontal Scaling

```
Load Balancer (Nginx)
├── Server 1 (PM2 cluster mode)
├── Server 2 (PM2 cluster mode)
└── Server 3 (PM2 cluster mode)
```

### Vertical Scaling

- Increase server RAM
- Upgrade CPU
- Add more storage
- Optimize code/database

---

## Security Hardening

```bash
# Update system
sudo apt-get update && sudo apt-get upgrade

# Enable firewall
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443

# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# SSH key authentication
ssh-keygen -t ed25519
ssh-copy-id user@server
```

---

## Rollback Procedure

```bash
# Keep previous version
git tag v1.0.0
git push origin v1.0.0

# Rollback if needed
git checkout v1.0.0
npm install
npm start

# Or with Docker
docker pull your-registry/fake-detector:v1.0.0
docker run -p 3000:3000 your-registry/fake-detector:v1.0.0
```

---

## Support

For deployment issues:
1. Check application logs
2. Verify environment variables
3. Check firewall rules
4. Test API endpoints
5. Monitor system resources

---

*Comprehensive Deployment Guide*
*Developed by Sunit Katuwal (BSc CSIT)*
*Last Updated: April 9, 2026*
