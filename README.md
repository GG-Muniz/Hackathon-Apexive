## 🚀 Core Features (Current Status)

The backend service provides a stable API with the following capabilities:

*   **Odoo CRM Integration:** Securely connects to a local Odoo instance to create new CRM leads.
*   **Live Twitter Mention Fetching:** Ingests live mentions for any configured public Twitter account using the Twitter v2 API.
*   **AI-Powered Analysis:** Leverages an LLM (via OpenAI) to perform:
    *   Sentiment Analysis (Positive, Negative, Neutral)
    *   Lead Qualification (`is_lead`: true/false)
    *   Actionable Suggestions for social media managers.
*   **Stable Mock Endpoint:** Provides a hardcoded, instant, and reliable mock data endpoint (`/analyze-mentions-mock`) to enable rapid and isolated frontend development without hitting API rate limits.

---

## 🛠️ Tech Stack

*   **Backend:** Node.js, Express.js
*   **Frontend:** Flutter (in development)
*   **Platform & Database:** Odoo (via Docker), PostgreSQL
*   **External APIs:**
    *   Twitter API v2
    *   OpenAI API (GPT-3.5)
*   **Developer Tools:** `jq` (for terminal JSON formatting)

---

## 🏗️ Project Architecture

The system is designed with a simple, decoupled architecture:

`Flutter App  <-->  Node.js Backend API  <--> (Twitter API | OpenAI API | Odoo ERP)`

The Flutter app only communicates with our Node.js backend, which acts as the central brain, orchestrating calls to all external services.

---

## ⚙️ Getting Started: Local Setup Guide

Follow these steps to get the complete project running on your local machine.

### Prerequisites

*   [Git](https://git-scm.com/)
*   [Node.js](https://nodejs.org/en/) (v18 or later) & npm
*   [Docker](https://www.docker.com/products/docker-desktop/) & Docker Compose
*   The original `apexive-hackaton-odoo` repository cloned locally.

### Step 1: Run the Odoo Environment

This project requires the local Odoo ERP instance.

```bash
# Navigate to the original hackathon boilerplate directory
cd /path/to/apexive-hackaton-odoo

# Build and run the Docker containers
make run


Leave this terminal running. It is your Odoo server, available at http://127.0.0.1:8069.

Step 2: Configure the Backend Service

In a new terminal, set up our application's backend.

Generated bash
# Navigate to this project's backend directory
cd /path/to/Hackathon-Apexive/crm_social_media_assistant/backend_service

# CRITICAL: Create your local environment file from the template
cp env_template.txt .env
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Bash
IGNORE_WHEN_COPYING_END

Now, open the newly created .env file and fill in your three secret keys from Twitter and OpenAI. The Odoo credentials are pre-filled.

Step 3: Install Dependencies & Run the Backend

Once your .env file is configured, install the Node.js packages and start the server.

Generated bash
# Install all required libraries from package.json
npm install

# Start the server
node index.js
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Bash
IGNORE_WHEN_COPYING_END

The backend is now running at http://localhost:3000.

💡 Developer Tips & API Endpoints
Recommended Tool: jq

To make testing the API from the terminal easier, install jq, a command-line JSON processor. It will format the raw JSON output into a beautiful, readable structure.

Installation (Debian/Ubuntu): sudo apt-get install jq

Usage:

Generated bash
curl http://localhost:3000/analyze-mentions-mock | jq
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Bash
IGNORE_WHEN_COPYING_END
API Endpoints
Mock Endpoint (For Development)

URL: GET /analyze-mentions-mock

Description: Returns instant, hardcoded data for frontend development. Use this to build the UI.

Response: 200 OK with a JSON array of analyzed mentions.

Live Endpoint (For Final Demo)

URL: GET /analyze-mentions

Description: Hits the live Twitter and OpenAI APIs. Subject to rate limits.

Response: 200 OK with a JSON array of live, analyzed mentions.

CRM Endpoint

URL: POST /create-lead

Description: Creates a new lead in the Odoo CRM.

Request Body (JSON):

Generated json
{
  "contact_name": "some_twitter_user",
  "description": "The full text of the tweet."
}
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Json
IGNORE_WHEN_COPYING_END

Response: 201 Created.

🗺️ Next Steps (Project Roadmap)

Phase 2 (In Progress): Complete the Flutter frontend development.

Build the main dashboard UI to display data from the mock endpoint.

Implement the "Create Lead" button functionality to call the POST /create-lead endpoint.

Phase 3 (Next): Integration, Testing & Demo Prep.

Perform a full end-to-end test with the live API.

Refine the UI/UX based on testing.

Prepare the final presentation script and visuals.

Generated code
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
IGNORE_WHEN_COPYING_END