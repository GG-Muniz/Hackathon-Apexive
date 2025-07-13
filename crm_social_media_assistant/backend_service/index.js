// crm_social_media_assistant/backend_service/index.js

const express = require('express');
const cors = require('cors');
const odoo = require('./odoo_service');
const { getMentions } = require('./twitter_service');
const { analyzeTweet } = require('./ai_agent_service');
const mockMentions = require('./tests/mock_data');
require('dotenv').config();

const app = express();
const port = 3000;

// --- MIDDLEWARE ---
app.use(cors());
app.use(express.json());
// Re-usable connection function
const connectToOdoo = async () => {
    try {
        await odoo.connect();
    } catch (err) {
        console.error('Failed to connect to Odoo:', err);
        throw new Error('Could not connect to Odoo.');
    }
};

// --- API ENDPOINTS ---

// =============================================================================
// MOCK DATA ENDPOINT FOR DEVELOPMENT
// =============================================================================
app.get('/analyze-mentions-mock', (req, res) => {
    console.log('\n--- [MOCK REQUEST] Received request to /analyze-mentions-mock ---');
    console.log(' > Serving mock data from ./tests/mock_data.js.');
    res.status(200).json(mockMentions);
});
// =============================================================================


// Create a CRM Lead in Odoo
app.post('/create-lead', async (req, res) => {
    const { contact_name, description } = req.body;
    console.log('\n--- [REQUEST] Received request to /create-lead ---');
    console.log(` > Contact Name: ${contact_name}`);

    if (!contact_name || !description) {
        console.log(' > Validation FAILED: Missing parameters.');
        return res.status(400).json({ error: 'contact_name and description are required.' });
    }
    try {
        console.log(' > Connecting to Odoo...');
        await connectToOdoo();
        console.log(' > Creating lead in Odoo CRM...');
        const leadId = await odoo.create('crm.lead', {
            name: `Lead from Twitter: ${contact_name}`,
            contact_name: contact_name,
            description: description,
        });
        console.log(` > SUCCESS: Lead created with ID: ${leadId}`);
        res.status(201).json({ message: 'Lead created successfully', lead_id: leadId });
    } catch (err) {
        console.error(' > ODOO ERROR:', err);
        res.status(500).json({ error: 'Failed to create lead.', details: err.message });
    }
});

// Schedule a post using Odoo's Social Marketing module
app.post('/schedule-post', async (req, res) => {
    const { message, social_account_id } = req.body;
    if (!message || !social_account_id) {
        return res.status(400).json({ error: 'message and social_account_id are required.' });
    }
    try {
        await connectToOdoo();
        const postId = await odoo.create('social.post', {
            'message': message,
            'account_ids': [[6, 0, [social_account_id]]],
            'state': 'draft',
        });
        res.status(201).json({ message: 'Social post created successfully', post_id: postId });
    } catch (err) {
        res.status(500).json({ error: 'Failed to create social post.', details: err.message });
    }
});

// ANALYZE MENTIONS ENDPOINT (USING MOCK DATA)
app.get('/analyze-mentions', async (req, res) => {
    console.log('\n--- [MOCK REQUEST] Received request to /analyze-mentions ---');
    console.log(' > Using mock data for reliable testing (Twitter API disabled)');
    try {
        // Use mock data instead of live Twitter API
        console.log(' > Serving pre-analyzed mock mentions data');
        res.status(200).json(mockMentions);

    } catch (err) {
        console.error(' > MOCK DATA ERROR:', err);
        res.status(500).json({ error: 'Failed to serve mock data.', details: err.message });
    }
});

// --- SERVER START ---
app.listen(port, () => {
  console.log(`Backend service listening at http://localhost:${port}`);
});