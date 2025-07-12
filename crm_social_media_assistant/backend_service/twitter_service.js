// twitter_service.js
const { TwitterApi } = require('twitter-api-v2');
require('dotenv').config();

const twitterClient = new TwitterApi(process.env.TWITTER_BEARER_TOKEN);
const roClient = twitterClient.readOnly;

const getMentions = async () => {
    try {
        // We now get the user ID directly from our environment variables.
        const userId = process.env.TWITTER_ACCOUNT_ID_TO_MONITOR;

        if (!userId) {
            throw new Error('TWITTER_ACCOUNT_ID_TO_MONITOR is not set in the .env file.');
        }

        console.log(`--- [Twitter API] Fetching mentions for configured user ID: ${userId} ---`);

        // Fetch the timeline of tweets mentioning the user ID
        const mentions = await roClient.v2.userMentionTimeline(userId, {
            'tweet.fields': ['created_at', 'author_id', 'text'],
            'expansions': ['author_id'],
        });

        // The data can be undefined if there are no mentions, so we default to an empty array.
        const tweets = mentions.data?.data || [];
        const users = mentions.data?.includes?.users || [];

        const userMap = users.reduce((acc, user) => {
            acc[user.id] = user.username;
            return acc;
        }, {});
        
        const formattedTweets = tweets.map(tweet => ({
            id: tweet.id,
            text: tweet.text,
            created_at: tweet.created_at,
            author_id: tweet.author_id,
            author_username: userMap[tweet.author_id]
        }));
        
        console.log(`> Found ${formattedTweets.length} mentions.`);
        return formattedTweets;

    } catch (err) {
        console.error('Error fetching Twitter mentions:', err);
        throw new Error('Could not fetch mentions from Twitter.');
    }
};

module.exports = { getMentions };