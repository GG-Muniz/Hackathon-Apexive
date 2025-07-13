// crm_social_media_assistant/backend_service/tests/mock_data.js

/**
 * This file contains hardcoded, realistic-looking data that mimics the output
 * of our live /analyze-mentions endpoint. This allows for rapid frontend
 * development and testing without hitting API rate limits or incurring costs.
 */

const mockMentions = [
  {
    "id": "1234567890123456789",
    "text": "Hey @HackathonCrmT, this test application is amazing. How much does it cost? I'd like a demo.",
    "created_at": "2025-07-13T00:10:00.000Z",
    "author_id": "987654321",
    "author_username": "potential_customer",
    "ai_analysis": {
      "sentiment": "Positive",
      "is_lead": true,
      "suggested_action": "Create lead in CRM and reply with pricing/demo info."
    }
  },
  {
    "id": "9988776655443322110",
    "text": "Just want to say thanks to @HackathonCrmT for this awesome project! Keep up the great work. #dev",
    "created_at": "2025-07-13T00:05:00.000Z",
    "author_id": "112233445",
    "author_username": "happy_developer",
    "ai_analysis": {
      "sentiment": "Positive",
      "is_lead": false,
      "suggested_action": "Thank the user for their positive feedback."
    }
  },
  {
    "id": "5555555555555555555",
    "text": "My @HackathonCrmT app is broken after the last update, can someone help?",
    "created_at": "2025-07-13T00:02:00.000Z",
    "author_id": "667788990",
    "author_username": "unhappy_user",
    "ai_analysis": {
      "sentiment": "Negative",
      "is_lead": false,
      "suggested_action": "Reply with a link to the support documentation or ask for more details."
    }
  },
  {
    "id": "4444444444444444444",
    "text": "Just making a neutral comment about @HackathonCrmT, nothing special.",
    "created_at": "2025-07-13T00:01:00.000Z",
    "author_id": "333222111",
    "author_username": "neutral_observer",
    "ai_analysis": {
      "sentiment": "Neutral",
      "is_lead": false,
      "suggested_action": "Monitor for further engagement."
    }
  }
];

module.exports = mockMentions;