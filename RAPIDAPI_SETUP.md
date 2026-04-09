# RapidAPI Setup Guide

**Social Media Fake Account Detector - Real Data Integration**
*Developed by Sunit Katuwal (BSc CSIT)*

---

## 🚀 Option A: Use RapidAPI for Real Data

This guide explains how to integrate real Instagram, TikTok, and Twitter data.

### Step 1: Get a RapidAPI Account

1. Visit [RapidAPI.com](https://rapidapi.com)
2. Sign up for a free account
3. Confirm your email

### Step 2: Subscribe to Instagram API

1. Search for **"Instagram Data"** on RapidAPI
2. Choose **"instagram-data1"** (most popular and reliable)
3. Click **"Subscribe to Test"** → Free tier available
4. You'll get your API key automatically

### Step 3: Get Your API Key

1. Go to your RapidAPI Dashboard
2. Click on **"Applications"** in the left sidebar
3. Find your active application
4. Copy the **X-RapidAPI-Key** value

### Step 4: Set Environment Variable

**On Windows (PowerShell):**
```powershell
# Set temporary (for current session)
$env:RAPIDAPI_KEY = "your-api-key-here"

# Then start the server
cd backend
node server.js
```

**On Windows (Command Prompt):**
```cmd
set RAPIDAPI_KEY=your-api-key-here
cd backend
node server.js
```

**On Linux/Mac:**
```bash
export RAPIDAPI_KEY="your-api-key-here"
cd backend
node server.js
```

**Or Create .env File:**

Create `backend/.env`:
```env
RAPIDAPI_KEY=your-api-key-here
NODE_ENV=development
PORT=3000
```

Update `backend/server.js` to load .env:
```javascript
require('dotenv').config();
```

Install dotenv:
```bash
npm install dotenv
```

### Step 5: Test the Integration

1. Start the backend server (with RAPIDAPI_KEY set)
2. Open the frontend
3. Enter a real Instagram username (e.g., "instagram", "cristiano")
4. Click **Analyze**
5. Check browser console to confirm real data was fetched

Expected response will show:
```json
{
  "dataSource": "Real API Data",
  "followers": 12345,
  "following": 543,
  ...
}
```

---

## 📊 Supported Platforms

### 1. Instagram
- **API**: instagram-data1
- **Features**: Followers, Following, Posts, Verification status
- **Rate Limit**: Free tier usually allows 10-50 requests/month

### 2. TikTok
- **API**: tiktok-api6
- **Features**: Followers, Following, Videos, Verification
- **Rate Limit**: Limited on free tier

### 3. Twitter/X
- **API**: twitter-api45
- **Features**: Followers, Following, Tweets, Verification
- **Rate Limit**: Limited on free tier

---

## ⚠️ Important Notes

### Rate Limits
- Free tier has **monthly request limits**
- Each analysis = 1 API call
- Exceeding limits may require paid plan

### API Costs
| Plan | Cost | Requests/Month |
|------|------|---|
| Free | $0 | 10-50 |
| Basic | $9.99 | 1,000 |
| Pro | $29.99 | 10,000 |

### Data Accuracy
- Real API data is most accurate
- Profiles may not exist or be private
- Returns `null` if account not found
- Automatically falls back to simulation

---

## 🔄 Fallback to Simulated Data

If:
- API key is not set → Uses simulated data
- Account not found → Uses simulated data
- API rate limit exceeded → Uses simulated data
- Network error occurs → Uses simulated data

Response will show:
```json
{
  "dataSource": "Simulated Data",
  ...
}
```

---

## 🎯 Alternative: Paid Tier Setup

For production use, get a paid RapidAPI plan:

1. Go to RapidAPI pricing page
2. Select **"Basic Plan"** ($9.99/month)
3. Upgrade your API key
4. You get 1,000 requests/month

This is enough for ~33 analyses per day!

---

## 🛠️ Troubleshooting

### "Account not found"
- Username may not exist
- Account might be private
- Try famous accounts: instagram, cristiano, taylorswift

### "Too many requests"
- You've exceeded monthly limit
- Wait until next month for reset
- Or upgrade to paid plan

### "Invalid API key"
- Key might be copied incorrectly
- Check for extra spaces
- Regenerate key in RapidAPI dashboard

### No data showing in response
- Check if RAPIDAPI_KEY environment variable is set
- Restart server after setting env var
- Check server console for error messages

---

## 📝 Environment Variable Verification

**Check if RAPIDAPI_KEY is set (PowerShell):**
```powershell
$env:RAPIDAPI_KEY
```

**Check if RAPIDAPI_KEY is set (Linux/Mac):**
```bash
echo $RAPIDAPI_KEY
```

**Check if .env file exists:**
```bash
ls -la backend/.env
```

---

## 🎉 Success Indicators

✅ API key is set correctly
✅ Backend shows: "Fetching real profile data for @username..."
✅ Response includes: `"dataSource": "Real API Data"`
✅ Follower/following/posts match the actual profile

---

## 📞 Need Help?

### Check API Status
- Visit [RapidAPI Status](https://rapidapi.com/status)
- See if Instagram API is operational

### View API Documentation
1. Go to your subscribed API on RapidAPI
2. Click on **"Endpoints"**
3. Review request/response examples

### Common API Endpoints

**Instagram:**
```
GET /info?username=USERNAME
```

**TikTok:**
```
GET /user/info?username=USERNAME
```

**Twitter:**
```
GET /search?query=USERNAME&type=user
```

---

## 🚀 Deployment with RapidAPI Key

### Heroku
```bash
heroku config:set RAPIDAPI_KEY="your-key-here"
```

### Vercel
1. Project settings → Environment Variables
2. Add: `RAPIDAPI_KEY` = your key

### Railway
```bash
railway variables set RAPIDAPI_KEY="your-key-here"
```

### AWS Lambda
1. Environment variables section
2. Add `RAPIDAPI_KEY`

---

## 🎓 Learning Resources

- [RapidAPI Dashboard](https://dashboard.rapidapi.com)
- [Instagram Data API Docs](https://rapidapi.com/instagram-data1/api/instagram-data1)
- [TikTok API Docs](https://rapidapi.com/tiktok-api6-tiktok-api6-default/api/tiktok-api6)
- [Twitter API Docs](https://rapidapi.com/twitter-api45/api/twitter-api45)

---

## 💡 Tips

1. **Test with famous accounts first**
   - @instagram, @cristiano, @beyonce
   - These profiles always return data

2. **Monitor your usage**
   - Check RapidAPI dashboard monthly
   - See how many requests you've used

3. **Cache results** (advanced)
   - Store results in database
   - Reduce API calls for same username

4. **Cache for 24 hours**
   - Check database before API call
   - Save API quota

---

## 🔐 Security Best Practices

1. **Never commit API key to Git**
   - Add to .gitignore
   - Use environment variables

2. **Use .env file locally only**
   - Don't push .env to repository
   - Use platform-specific env vars in production

3. **Rotate keys regularly**
   - Regenerate on RapidAPI dashboard
   - Update environment variables

4. **Limit API key scope** (if possible)
   - Create read-only keys
   - Restrict to specific endpoints

---

*RapidAPI Integration Setup*
*Developed by Sunit Katuwal (BSc CSIT)*
*Last Updated: April 9, 2026*
