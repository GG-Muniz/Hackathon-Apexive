# CRM Social Media Assistant

A comprehensive solution that integrates **Odoo CRM** with **AI-powered social media monitoring** to automatically detect leads, analyze sentiment, and streamline customer relationship management.

## 🚀 Project Overview

This system monitors social media mentions (currently Twitter), analyzes them using AI, and automatically creates qualified leads in your Odoo CRM system. It features platform-specific AI personas that provide contextual analysis and actionable insights.

### Core Features
- **Odoo CRM Integration** - Seamless lead creation and management
- **AI-Powered Social Media Analysis** - Sentiment analysis and lead qualification  
- **Platform-Specific AI Personas** - Specialized assistants for Twitter, LinkedIn, Instagram, and Facebook
- **Real-time Monitoring** - Live social media mention tracking
- **Interactive Analytics Dashboard** - Comprehensive analytics with charts, metrics, and insights
- **AI Chat Consultation** - Interactive chat with AI personas for strategy advice
- **Mock Development Environment** - Stable endpoints for rapid development

## 🛠️ Tech Stack

- **Backend:** Node.js, Express.js ([details](./crm_social_media_assistant/backend_service/README.md))
- **Frontend:** Flutter with Material Design 3 ([details](./crm_social_media_assistant/frontend_service/README.md))
- **Charts & Visualization:** FL Chart library for analytics dashboards
- **Platform:** Odoo (via Docker), PostgreSQL
- **External APIs:** Twitter API v2, OpenAI API
- **Development Tools:** Docker, Make, jq

## 🏗️ Architecture

```
Flutter App  <-->  Node.js Backend API  <-->  (Twitter API | OpenAI API | Odoo ERP)
```

## ⚙️ Quick Start

### Prerequisites
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/en/) (v18+) & npm
- [Docker](https://www.docker.com/products/docker-desktop/) & Docker Compose
- [Flutter](https://flutter.dev/docs/get-started/install) (for frontend development)
- The `apexive-hackaton-odoo` repository cloned locally

### 1. Start Odoo Environment

```bash
# Navigate to the Odoo repository
cd /path/to/apexive-hackaton-odoo

# Start Odoo with Docker
make run
```

Odoo will be available at http://127.0.0.1:8069

### 2. Setup Backend Service

```bash
# Navigate to backend directory
cd crm_social_media_assistant/backend_service

# Install dependencies from root package.json
npm install

# Configure environment
cp env_template.txt .env
# Edit .env with your API keys (Twitter, OpenAI)

# Start backend server
node index.js
```

Backend API will be available at http://localhost:3000

### 3. Setup Frontend (Optional)

```bash
# Navigate to Flutter app
cd crm_social_media_assistant/frontend_service

# Install Flutter dependencies
flutter pub get

# Run the app
flutter run -d web
```

## 📁 Project Structure

```
├── README.md                          # This file - project overview
├── package.json                       # Root dependencies
├── crm_social_media_assistant/
│   ├── backend_service/               # Node.js API service
│   │   ├── README.md                 # Backend documentation
│   │   ├── index.js                  # Main server file
│   │   ├── personas.js               # AI persona definitions
│   │   └── ...
│   └── frontend_service/             # Flutter frontend
│       ├── README.md                 # Frontend documentation  
│       ├── lib/
│       │   ├── main.dart
│       │   ├── screens/
│       │   └── services/
│       └── ...
```

## 🔗 Service Documentation

- **[Backend Service](./crm_social_media_assistant/backend_service/README.md)** - API endpoints, dependencies, configuration
- **[Frontend Service](./crm_social_media_assistant/frontend_service/README.md)** - Flutter app setup, components, state management

## 🤝 Contributing

1. Ensure Odoo environment is running
2. Set up backend service first
3. Configure API keys in `.env`
4. Use mock endpoints for development
5. Reference service-specific READMEs for detailed setup

## 📝 Development Notes

- Use `/analyze-mentions-mock` endpoint for development to avoid API rate limits
- Odoo credentials are pre-configured in the environment template
- Install `jq` for formatted JSON output: `sudo apt-get install jq`

## 🎨 Recent Updates

### Analytics Enhancement (Latest)
- **Interactive Analytics Dashboard** - Added comprehensive analytics with platform-specific metrics
- **Data Visualization** - Integrated FL Chart library for line charts, pie charts, and bar charts
- **AI-Powered Insights** - Contextual insights and recommendations based on analytics data
- **Platform Analytics Pages** - Dedicated analytics pages for each social media platform

### Chat Functionality
- **AI Persona Chat** - Interactive chat widget with platform-specific AI personalities
- **Context-Aware Responses** - Chat responses based on current analytics and performance data
- **Suggested Questions** - Platform-specific question suggestions for user guidance
- **Real-time Interaction** - Live chat simulation with typing indicators

### Design & UI Improvements
- **Warm Sand Color Palette** - Updated from gold to warm sand colors (#DAC0A7, #FFF2D7)
- **Dark Theme Implementation** - Professional dark theme with warm accent colors
- **Improved Typography** - Enhanced readability and visual hierarchy
- **UI Bug Fixes** - Fixed chat input visibility and header prominence issues

## 👥 Authors

- **Gabriel Garcia Muniz** - [GitHub](https://github.com/GG-Muniz)
- **Fernando Lockwood** - [GitHub](https://github.com/flockwood)