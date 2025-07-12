// index.js
const express = require('express');
const cors = require('cors'); // <-- REQUIRE CORS
const odoo = require('./odoo_service');
const { getMentions } = require('./twitter_service');
const { analyzeTweet } = require('./ai_agent_service');
require('dotenv').config();

const app = express();
const port = 3000;

// --- MIDDLEWARE ---
app.use(cors()); // <-- USE CORS TO ALLOW REQUESTS FROM THE FLUTTER APP
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

// Create a CRM Lead in Odoo
app.post('/create-lead', async (req, res) => {
    const { contact_name, description } = req.body;
    if (!contact_name || !description) {
        return res.status(400).json({ error: 'contact_name and description are required.' });
    }
    try {
        await connectToOdoo();
        const leadId = await odoo.create('crm.lead', {
            name: `Lead from Twitter: ${contact_name}`,
            contact_name: contact_name,
            description: description,
        });
        res.status(201).json({ message: 'Lead created successfully', lead_id: leadId });
    } catch (err) {
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

// Fetch Twitter mentions and analyze them with the AI Agent
app.get('/analyze-mentions', async (req, res) => {
    try {
        const mentions = await getMentions();
        const analysisPromises = mentions.map(mention =>
            analyzeTweet(mention.text, mention.author_username)
        );
        const analyses = await Promise.all(analysisPromises);
        const enrichedMentions = mentions.map((mention, index) => ({
            ...mention,
            ai_analysis: analyses[index],
        }));
        res.status(200).json(enrichedMentions);
    } catch (err) {
        res.status(500).json({ error: 'Failed to analyze mentions.', details: err.message });
    }
});

// --- SERVER START ---
app.listen(port, () => {
  console.log(`Backend service listening at http://localhost:${port}`);
});