# API Documentation

**Social Media Fake Account Detector API**
*Developed by Sunit Katuwal (BSc CSIT)*

Version: 1.0.0
Base URL: `http://localhost:3000`

---

## Table of Contents

1. [Authentication](#authentication)
2. [Endpoints](#endpoints)
3. [Request/Response Format](#requestresponse-format)
4. [Error Handling](#error-handling)
5. [Rate Limiting](#rate-limiting)
6. [Examples](#examples)

---

## Authentication

Currently, the API does not require authentication. For production deployment, implement API key or JWT authentication.

---

## Endpoints

### 1. Health Check

**Endpoint:** `GET /health`

**Description:** Check if the API server is running and healthy.

**Response:**
```json
{
  "status": "OK",
  "timestamp": "2026-04-09T10:30:00Z",
  "service": "Fake Account Detector API",
  "developer": "Sunit Katuwal (BSc CSIT)"
}
```

**Status Code:** `200 OK`

---

### 2. Analyze Account

**Endpoint:** `POST /api/analyze`

**Description:** Analyze a social media account and determine the probability of it being fake.

**Request Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "username": "string (required, 2-100 characters)",
  "platform": "string (required, one of: instagram, tiktok, twitter)"
}
```

**Response (Success):**
```json
{
  "success": true,
  "username": "example_user",
  "platform": "instagram",
  "timestamp": "2026-04-09T10:30:00Z",
  "followers": 1250,
  "following": 3400,
  "posts": 24,
  "fakeScore": 65,
  "engagementRate": 2.5,
  "activityFrequency": 15,
  "postConsistency": 8,
  "commentRatio": 3,
  "likeDensity": 45,
  "factors": [
    {
      "name": "Username Pattern",
      "description": "Suspicious random characters and numbers detected",
      "risk": 85,
      "icon": "⚠️"
    },
    {
      "name": "Follower Ratio",
      "description": "Unusual followers-to-following ratio (0.37)",
      "risk": 78,
      "icon": "⚠️"
    },
    {
      "name": "Engagement Rate",
      "description": "Engagement metrics are below average",
      "risk": 65,
      "icon": "⚠️"
    },
    {
      "name": "Activity Pattern",
      "description": "Irregular posting and interaction patterns",
      "risk": 72,
      "icon": "⚠️"
    },
    {
      "name": "Account Verification",
      "description": "Account is not officially verified",
      "risk": 30,
      "icon": "⚠️"
    }
  ]
}
```

**Status Code:** `200 OK`

---

## Response Format

### Analysis Response Object

| Field | Type | Description |
|-------|------|-------------|
| `success` | boolean | Whether the analysis was successful |
| `username` | string | The analyzed username |
| `platform` | string | The platform (instagram, tiktok, or twitter) |
| `timestamp` | string | ISO 8601 timestamp of analysis |
| `followers` | integer | Number of followers (simulated) |
| `following` | integer | Number of accounts following |
| `posts` | integer | Total number of posts |
| `fakeScore` | integer | 0-100 fake probability score |
| `engagementRate` | float | Engagement percentage |
| `activityFrequency` | integer | Activity frequency score |
| `postConsistency` | integer | Post consistency score |
| `commentRatio` | float | Comment-to-like ratio |
| `likeDensity` | integer | Like density score |
| `factors` | array | Array of analysis factors |

### Factor Object

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Name of the analysis factor |
| `description` | string | Detailed description |
| `risk` | integer | Risk score (0-100) |
| `icon` | string | Emoji icon for visual representation |

---

## Error Handling

### Error Response Format

```json
{
  "error": "Error Type",
  "message": "Detailed error message"
}
```

### Common Errors

#### 400 Bad Request

Missing or invalid parameters:
```json
{
  "error": "Missing required fields",
  "message": "Please provide username and platform"
}
```

Invalid platform:
```json
{
  "error": "Invalid platform",
  "message": "Platform must be one of: instagram, tiktok, twitter"
}
```

Invalid username length:
```json
{
  "error": "Invalid username",
  "message": "Username must be between 2 and 100 characters"
}
```

#### 404 Not Found

```json
{
  "error": "Not found",
  "message": "The requested endpoint does not exist"
}
```

#### 500 Internal Server Error

```json
{
  "error": "Analysis failed",
  "message": "An error occurred while analyzing the account"
}
```

---

## Rate Limiting

### Limits (Per IP Address)

- **Default:** 100 requests per 15 minutes
- **Status Header:** `X-RateLimit-Remaining`
- **Reset Header:** `X-RateLimit-Reset`

### Rate Limit Response

When limit is exceeded:
```
HTTP/1.1 429 Too Many Requests

{
  "error": "Rate limit exceeded",
  "message": "Maximum requests exceeded. Please try again later."
}
```

---

## Examples

### Example 1: Basic Analysis

**Request:**
```bash
curl -X POST http://localhost:3000/api/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "username": "real_user",
    "platform": "instagram"
  }'
```

**Response:**
```json
{
  "success": true,
  "username": "real_user",
  "platform": "instagram",
  "timestamp": "2026-04-09T10:35:42Z",
  "followers": 5420,
  "following": 1230,
  "posts": 145,
  "fakeScore": 25,
  "factors": [...]
}
```

---

### Example 2: Analyze Multiple Accounts (Batch)

**Frontend Code:**
```javascript
const accounts = [
  { username: 'user1', platform: 'instagram' },
  { username: 'user2', platform: 'tiktok' },
  { username: 'user3', platform: 'twitter' }
];

const results = await Promise.all(
  accounts.map(account => 
    fetch('http://localhost:3000/api/analyze', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(account)
    }).then(r => r.json())
  )
);
```

---

### Example 3: Error Handling

**Request:**
```bash
curl -X POST http://localhost:3000/api/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "username": "x",
    "platform": "facebook"
  }'
```

**Response (400 Bad Request):**
```json
{
  "error": "Invalid username",
  "message": "Username must be between 2 and 100 characters"
}
```

---

### Example 4: Health Check

**Request:**
```bash
curl http://localhost:3000/health
```

**Response:**
```json
{
  "status": "OK",
  "timestamp": "2026-04-09T10:40:00Z",
  "service": "Fake Account Detector API",
  "developer": "Sunit Katuwal (BSc CSIT)"
}
```

---

## Data Types

### Strings
- `username`: 2-100 characters, alphanumeric + underscore
- `platform`: One of `instagram`, `tiktok`, `twitter`
- `description`: Text description of analysis factor

### Numbers
- `fakeScore`: Integer 0-100
- `engagementRate`: Float representing percentage
- `followers`, `following`, `posts`: Non-negative integers
- `risk`: Integer 0-100 for each factor

### Timestamps
- ISO 8601 format: `2026-04-09T10:30:00Z`

---

## Pagination (Future)

When analysis history is implemented:

```json
{
  "results": [],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 50,
    "pages": 5
  }
}
```

---

## Webhooks (Future)

For real-time notifications:

```javascript
// Register webhook
POST /webhooks/register
{
  "url": "https://yourapp.com/webhook",
  "events": ["analysis.complete", "analysis.error"]
}
```

---

## API Versioning

Current version: `v1`

Future versions:
- `v2`: With authentication and caching
- `v3`: With real data integration

---

## CORS Headers

The API responds with these CORS headers:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, OPTIONS
Access-Control-Allow-Headers: Content-Type
```

---

## Best Practices

1. **Validate Input:** Always validate username and platform on client side
2. **Handle Errors:** Implement proper error handling for network failures
3. **Cache Results:** Cache analysis results to reduce API calls
4. **Rate Limiting:** Respect rate limits and implement backoff strategy
5. **Logging:** Log API responses for debugging
6. **Timeout:** Set appropriate timeouts (default 30 seconds recommended)

---

## Future Enhancements

- [ ] Authentication with API keys
- [ ] Webhook support for real-time updates
- [ ] Advanced filtering and search
- [ ] Historical data storage
- [ ] Batch analysis endpoint
- [ ] Export to CSV/JSON
- [ ] Analytics dashboard API

---

## Support & Contact

For API support or issues:
1. Check this documentation
2. Review error messages carefully
3. Check application logs
4. Contact development team

---

*API Developed by Sunit Katuwal (BSc CSIT)*
*Last Updated: April 9, 2026*
