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

module.exports = { analyzeTweet };