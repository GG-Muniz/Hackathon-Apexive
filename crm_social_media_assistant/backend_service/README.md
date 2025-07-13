# Backend Service

Node.js Express API service that handles social media monitoring, AI analysis, and Odoo CRM integration.

## 🚀 Overview

This backend service acts as the central orchestration layer, connecting external APIs (Twitter, OpenAI) with the Odoo CRM system. It features AI-powered analysis with platform-specific personas and provides both mock and live endpoints for development and production use.

## 🛠️ Tech Stack

- **Runtime:** Node.js (v18+)
- **Framework:** Express.js  
- **Database Integration:** Odoo ERP (via odoo-await)
- **External APIs:**
  - Twitter API v2 (twitter-api-v2)
  - OpenAI API (openai)
- **Environment:** dotenv
- **CORS:** cors middleware

## 📁 Service Structure

```
backend_service/
├── index.js                 # Main Express server
├── ai_agent_service.js      # OpenAI integration & analysis
├── twitter_service.js       # Twitter API integration
├── odoo_service.js          # Odoo CRM connection
├── personas.js              # AI persona definitions
├── env_template.txt         # Environment variables template
├── get_id.sh               # Twitter account ID utility
└── tests/
    └── mock_data.js         # Development mock data
```

## ⚙️ Setup & Installation

### Prerequisites
- Node.js v18 or later
- npm package manager
- Running Odoo instance (see [root README](../../README.md))

### Installation

```bash
# Navigate to backend directory
cd crm_social_media_assistant/backend_service

# Install dependencies (from root package.json)
cd ../../ && npm install && cd crm_social_media_assistant/backend_service

# Configure environment
cp env_template.txt .env
# Edit .env with your API credentials
```

### Environment Configuration

Edit the `.env` file with your credentials:

```bash
# Odoo Credentials (pre-configured for local setup)
ODOO_URL=http://127.0.0.1:8069
ODOO_DB=odoo
ODOO_USERNAME=admin
ODOO_PASSWORD=admin

# Twitter API v2 Credentials (required)
TWITTER_BEARER_TOKEN=your_bearer_token_here
TWITTER_ACCOUNT_ID_TO_MONITOR=twitter_account_numeric_id

# OpenAI API Key (required)
OPENAI_API_KEY=sk-your_openai_key_here
```

### Running the Service

```bash
# Start the server
node index.js
```

Server will be available at http://localhost:3000

## 🔗 API Endpoints

### Development Endpoints

#### GET `/analyze-mentions-mock`
Returns mock social media data for development.

**Response:** Array of analyzed mentions with AI persona insights
```json
[
  {
    "platform": "twitter",
    "username": "example_user",
    "content": "Tweet content...",
    "sentiment": "Positive",
    "is_lead": true,
    "persona_analysis": "Echo's analysis here..."
  }
]
```

### Production Endpoints

#### GET `/analyze-mentions`
Fetches live Twitter mentions and analyzes them with AI.

**Response:** Array of analyzed live mentions

#### POST `/create-lead`
Creates a new lead in Odoo CRM.

**Request Body:**
```json
{
  "contact_name": "twitter_username",
  "description": "Tweet or social media content"
}
```

**Response:** `201 Created` on success

## 🤖 AI Personas

The service includes platform-specific AI personas defined in `personas.js`:

- **Echo** (Twitter) - Real-time response specialist
- **Sterling** (LinkedIn) - B2B lead intelligence expert  
- **Vibe** (Instagram) - Brand partnership curator
- **Harmony** (Facebook) - Community engagement orchestrator

Each persona provides contextual analysis and platform-appropriate insights.

## 🔧 Service Components

### ai_agent_service.js
- OpenAI API integration
- Tweet sentiment analysis
- Lead qualification logic
- AI persona response generation

### twitter_service.js
- Twitter API v2 connection
- Mention fetching and monitoring
- Rate limit handling

### odoo_service.js
- Odoo ERP connection management
- Lead creation functionality
- CRM data synchronization

### personas.js
- AI personality definitions
- Platform-specific response templates
- Contextual analysis patterns

## 🧪 Development Tools

### Mock Data
Use `/analyze-mentions-mock` endpoint for development to avoid API rate limits.

### Twitter Account ID Utility
```bash
# Get Twitter account ID for monitoring
chmod +x get_id.sh
./get_id.sh @username
```

### JSON Formatting
Install `jq` for readable API responses:
```bash
sudo apt-get install jq
curl http://localhost:3000/analyze-mentions-mock | jq
```

## 🔧 Troubleshooting

### Common Issues

1. **Odoo Connection Failed**
   - Ensure Odoo is running: `cd /path/to/apexive-hackaton-odoo && make run`
   - Check Odoo is accessible at http://127.0.0.1:8069

2. **Twitter API Errors**
   - Verify `TWITTER_BEARER_TOKEN` in `.env`
   - Check `TWITTER_ACCOUNT_ID_TO_MONITOR` is numeric ID, not username

3. **OpenAI API Errors**
   - Confirm `OPENAI_API_KEY` starts with `sk-`
   - Check API quota and billing status

### Environment Variables Validation
The service will log missing environment variables on startup.

## 📝 Development Notes

- Use mock endpoints during frontend development
- All external API calls include error handling and logging
- CORS is enabled for cross-origin requests
- Service logs all requests with detailed information

## 🔄 Data Flow

1. **Incoming Request** → Express middleware
2. **Twitter API** → Fetch mentions
3. **OpenAI API** → Analyze content with persona
4. **Odoo CRM** → Create qualified leads
5. **Response** → Return analyzed data to frontend

## 🚀 Production Considerations

- Environment variables must be properly secured
- Consider rate limiting for production use
- Monitor API quotas for Twitter and OpenAI
- Implement proper logging and error handling
- Set up health checks for Odoo connectivity

## 👥 Authors

- **Gabriel Garcia Muniz** 
- **Fernando Lockwood**