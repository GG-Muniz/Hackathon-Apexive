// ai_agent_service.js
const OpenAI = require('openai');
require('dotenv').config();

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
});

/**
 * Analyzes a tweet using an LLM to determine sentiment, lead potential, and a suggested action.
 * @param {string} tweetText The text of the tweet to analyze.
 * @param {string} tweetAuthor The username of the person who wrote the tweet.
 * @returns {Promise<object>} A promise that resolves to an object with the analysis.
 */
const analyzeTweet = async (tweetText, tweetAuthor) => {
    console.log(`Analyzing tweet from ${tweetAuthor}: "${tweetText}"`);

    const prompt = `
        You are an expert Social Media Lead Qualifier for a software company.
        Analyze the following tweet and provide a JSON response.

        Tweet from user "${tweetAuthor}":
        ---
        ${tweetText}
        ---

        Analyze the tweet based on the following criteria:
        1.  **sentiment**: Classify the sentiment as 'Positive', 'Negative', or 'Neutral'.
        2.  **is_lead**: Determine if this tweet represents a potential sales lead. This is true if the user expresses interest in the product, asks about pricing, features, demos, or compares it to a competitor. It is false if they are just complaining, asking for support, or making a general comment.
        3.  **suggested_action**: Based on the analysis, suggest a concrete next step for the social media manager. Examples: "Create lead in CRM and reply with pricing info.", "Reply with a link to the support documentation.", "Thank the user for their positive feedback."

        Provide your response ONLY as a valid JSON object in the following format:
        {
          "sentiment": "...",
          "is_lead": boolean,
          "suggested_action": "..."
        }
    `;

    try {
        const response = await openai.chat.completions.create({
            model: "gpt-3.5-turbo-1106", // This model is good at following JSON format instructions
            messages: [{ role: "user", content: prompt }],
            response_format: { type: "json_object" }, // Enforce JSON output
        });

        const analysis = JSON.parse(response.choices[0].message.content);
        console.log('AI Analysis complete:', analysis);
        return analysis;

    } catch (err) {
        console.error("Error analyzing tweet with OpenAI:", err);
        throw new Error('Failed to get analysis from AI agent.');
    }
};

/**
 * Generates a contextually appropriate reply to a tweet using AI.
 * @param {string} tweetText The original tweet text
 * @param {string} tweetAuthor The username who wrote the tweet
 * @param {string} sentiment The sentiment analysis result
 * @param {boolean} isLead Whether this is identified as a potential lead
 * @param {string} suggestedAction The recommended action from analysis
 * @returns {Promise<string>} A suggested reply message
 */
const generateReply = async (tweetText, tweetAuthor, sentiment, isLead, suggestedAction) => {
    console.log(`[MOCK AI] Generating reply for tweet from ${tweetAuthor}`);

    // TEMPORARY: Mock reply generation while fixing OpenAI quota
    const mockReply = (() => {
        const text = tweetText.toLowerCase();
        
        if (isLead && (text.includes('help') || text.includes('support') || text.includes('problem'))) {
            return `Hi @${tweetAuthor}! I'm sorry to hear you're having trouble. Let me connect you with our support team who can help resolve this quickly. Please DM us your order details and we'll get this sorted out! 🛠️`;
        } else if (isLead && (text.includes('pricing') || text.includes('demo') || text.includes('interested'))) {
            return `Thanks for your interest @${tweetAuthor}! I'd love to show you what our software can do. Would you like to schedule a quick 15-minute demo? Feel free to DM me your availability! 📅`;
        } else if (sentiment === 'Positive' && (text.includes('love') || text.includes('awesome') || text.includes('amazing'))) {
            return `Thank you so much @${tweetAuthor}! 🙏 We're thrilled you're enjoying our product. Your feedback means the world to us. Mind sharing your experience with others who might benefit?`;
        } else if (sentiment === 'Positive' && text.includes('recommend')) {
            return `@${tweetAuthor} Thank you for the recommendation! 🌟 It's customers like you who make what we do so rewarding. We really appreciate you spreading the word!`;
        } else {
            return `Hi @${tweetAuthor}! Thanks for reaching out. We're here to help - please let us know if you have any questions or if there's anything we can assist you with! 😊`;
        }
    })();

    console.log('[MOCK AI] Generated reply:', mockReply);
    return mockReply;
};

module.exports = { analyzeTweet, generateReply };