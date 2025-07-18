// crm_social_media_assistant/backend_service/index.js

const express = require('express');
const cors = require('cors');
const odoo = require('./odoo_service');
const { getMentions } = require('./twitter_service');
const { analyzeTweet, generateReply } = require('./ai_agent_service');
const { mockMentions, generateMockDataByPlatform } = require('./tests/mock_data');
const { SOCIAL_MEDIA_PERSONAS, getPersona, generatePersonaResponse } = require('./personas');
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

// ANALYZE MENTIONS ENDPOINT (USING MOCK DATA WITH PERSONA INTEGRATION)
app.get('/analyze-mentions', async (req, res) => {
    const platform = req.query.platform || 'twitter';
    console.log('\n--- [MOCK REQUEST] Received request to /analyze-mentions ---');
    console.log(` > Platform: ${platform}`);
    console.log(' > Using mock data for reliable testing (Twitter API disabled)');
    
    try {
        // Get platform-specific mock data
        const platformData = generateMockDataByPlatform(platform);
        
        // Get platform persona
        const persona = getPersona(platform);
        
        // Enhance each mention with persona insights
        const enhancedData = platformData.map(mention => {
            const analysisData = mention.ai_analysis || {};
            
            // Generate persona-specific response
            const personaResponse = generatePersonaResponse(platform, {
                ...analysisData,
                username: mention.author_username,
                business_classification: analysisData.business_classification || 'Unknown',
                job_title: analysisData.job_title || 'Unknown',
                company: analysisData.company || 'Unknown',
                influencer_tier: analysisData.platform_insights?.influencer_tier || 'Unknown',
                organization_type: analysisData.platform_insights?.business_type || 'Unknown',
                community_context: analysisData.platform_insights?.community_focus ? 'local' : 'general',
                engagement_rate: 'high',
                content_style: 'professional',
                event_indicator: 'networking'
            });
            
            return {
                ...mention,
                ai_analysis: {
                    ...analysisData,
                    persona_insight: personaResponse,
                    persona_name: persona.name,
                    persona_avatar: persona.avatar
                }
            };
        });
        
        const response = {
            platform,
            mentions: enhancedData,
            persona: {
                name: persona.name,
                avatar: persona.avatar,
                title: persona.title,
                greeting: persona.greeting
            },
            count: enhancedData.length,
            timestamp: new Date().toISOString()
        };
        
        console.log(` > SUCCESS: Serving ${enhancedData.length} ${platform} mentions with ${persona.name} insights`);
        res.status(200).json(response);

    } catch (err) {
        console.error(' > ENHANCED ANALYSIS ERROR:', err);
        res.status(500).json({ error: 'Failed to serve enhanced analysis data.', details: err.message });
    }
});

// Generate AI reply for a tweet
app.post('/generate-reply', async (req, res) => {
    const { tweet_text, author_username, sentiment, is_lead, suggested_action } = req.body;
    console.log('\n--- [REQUEST] Received request to /generate-reply ---');
    console.log(` > Tweet: "${tweet_text}" by @${author_username}`);
    console.log(` > Context: ${sentiment} sentiment, ${is_lead ? 'IS' : 'NOT'} a lead`);
    
    if (!tweet_text || !author_username) {
        return res.status(400).json({ error: 'tweet_text and author_username are required.' });
    }
    
    try {
        console.log(' > Generating AI reply...');
        const reply = await generateReply(tweet_text, author_username, sentiment, is_lead, suggested_action);
        
        const result = {
            original_tweet: tweet_text,
            author_username,
            suggested_reply: reply,
            context: { sentiment, is_lead, suggested_action },
            timestamp: new Date().toISOString()
        };
        
        console.log(' > AI reply generated successfully');
        res.status(200).json(result);
        
    } catch (err) {
        console.error(' > REPLY GENERATION ERROR:', err);
        res.status(500).json({ error: 'Failed to generate reply.', details: err.message });
    }
});

// =============================================================================
// PERSONA ENDPOINTS
// =============================================================================

// Get all AI personas
app.get('/personas', (req, res) => {
    console.log('\n--- [REQUEST] Received request to /personas ---');
    console.log(' > Serving all AI persona data');
    
    try {
        const response = {
            personas: SOCIAL_MEDIA_PERSONAS,
            total_personas: Object.keys(SOCIAL_MEDIA_PERSONAS).length,
            available_platforms: Object.keys(SOCIAL_MEDIA_PERSONAS),
            timestamp: new Date().toISOString()
        };
        
        console.log(` > SUCCESS: Serving ${response.total_personas} personas`);
        res.status(200).json(response);
        
    } catch (err) {
        console.error(' > PERSONAS ERROR:', err);
        res.status(500).json({ error: 'Failed to fetch personas.', details: err.message });
    }
});

// Get specific platform persona
app.get('/personas/:platform', (req, res) => {
    const platform = req.params.platform.toLowerCase();
    console.log(`\n--- [REQUEST] Received request to /personas/${platform} ---`);
    
    try {
        const persona = getPersona(platform);
        
        if (!SOCIAL_MEDIA_PERSONAS[platform]) {
            console.log(` > WARNING: Platform '${platform}' not found, returning default (Twitter)`);
        }
        
        const response = {
            platform,
            persona,
            is_default: !SOCIAL_MEDIA_PERSONAS[platform],
            available_platforms: Object.keys(SOCIAL_MEDIA_PERSONAS),
            timestamp: new Date().toISOString()
        };
        
        console.log(` > SUCCESS: Serving ${persona.name} (${persona.title}) for ${platform}`);
        res.status(200).json(response);
        
    } catch (err) {
        console.error(` > PERSONA ERROR for ${platform}:`, err);
        res.status(500).json({ error: `Failed to fetch ${platform} persona.`, details: err.message });
    }
});

// --- SERVER START ---
app.listen(port, () => {
  console.log(`Backend service listening at http://localhost:${port}`);
});