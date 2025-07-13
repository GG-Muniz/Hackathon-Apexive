// crm_social_media_assistant/backend_service/tests/mock_data.js

/**
 * This file contains platform-specific, realistic-looking data that mimics the output
 * of our live /analyze-mentions endpoint with rich AI analysis and platform insights.
 */

// Platform-specific mock data generator
const generateMockDataByPlatform = (platform) => {
  const platformData = {
    twitter: [
      {
        "id": "1234567890123456789",
        "text": "@company API integration urgent! Our production app is down and we need immediate support 🚨",
        "created_at": "2025-07-13T00:10:00.000Z",
        "author_id": "987654321",
        "author_username": "startup_cto",
        "platform": "twitter",
        "followers": 2500,
        "is_verified": true,
        "ai_analysis": {
          "sentiment": "Negative",
          "is_lead": true,
          "suggested_action": "URGENT: Immediate response required - escalate to support team.",
          "priority": "Critical",
          "lead_score": 85,
          "topic_category": "technical_support",
          "platform_insights": {
            "urgency_level": "high",
            "support_request": true,
            "technical_inquiry": true,
            "frustration_detected": false,
            "response_time_needed": "immediate"
          },
          "platform_context": "concise_helpful",
          "influence_score": "Verified User"
        }
      },
      {
        "id": "2234567890123456789",
        "text": "Loving @company's new features! The analytics dashboard is exactly what our team needed 📊",
        "created_at": "2025-07-13T00:05:00.000Z",
        "author_id": "112233445",
        "author_username": "marketing_lead",
        "platform": "twitter",
        "followers": 1200,
        "is_verified": false,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": false,
          "suggested_action": "Thank the user for their positive feedback.",
          "priority": "Medium",
          "lead_score": 35,
          "topic_category": "product_feedback",
          "platform_insights": {
            "urgency_level": "normal",
            "support_request": false,
            "technical_inquiry": false,
            "frustration_detected": false,
            "response_time_needed": "standard"
          },
          "platform_context": "concise_helpful",
          "influence_score": "1200 followers"
        }
      },
      {
        "id": "3234567890123456789",
        "text": "Evaluating @company vs competitors for our enterprise deployment. Need demo for 500+ users.",
        "created_at": "2025-07-13T00:02:00.000Z",
        "author_id": "667788990",
        "author_username": "enterprise_buyer",
        "platform": "twitter",
        "followers": 5600,
        "is_verified": true,
        "ai_analysis": {
          "sentiment": "Neutral",
          "is_lead": true,
          "suggested_action": "Enterprise opportunity: Route to enterprise sales team for immediate follow-up.",
          "priority": "High",
          "lead_score": 95,
          "topic_category": "enterprise_evaluation",
          "platform_insights": {
            "urgency_level": "normal",
            "support_request": false,
            "technical_inquiry": true,
            "frustration_detected": false,
            "response_time_needed": "standard"
          },
          "platform_context": "concise_helpful",
          "influence_score": "Verified User"
        }
      }
    ],
    linkedin: [
      {
        "id": "4234567890123456789",
        "text": "As CEO of TechCorp, I'm always evaluating new solutions. @company's enterprise features look promising for our global operations.",
        "created_at": "2025-07-13T00:10:00.000Z",
        "author_id": "987654321",
        "author_username": "ceo_techcorp",
        "platform": "linkedin",
        "followers": 15000,
        "is_verified": true,
        "job_title": "CEO",
        "company": "TechCorp",
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": true,
          "suggested_action": "Decision maker identified: Schedule executive demo and provide ROI analysis.",
          "priority": "Critical",
          "lead_score": 98,
          "topic_category": "executive_interest",
          "platform_insights": {
            "decision_maker": true,
            "enterprise_signal": true,
            "job_title": "CEO",
            "company_context": "TechCorp",
            "business_intent": true
          },
          "platform_context": "professional",
          "influence_score": "Verified User"
        }
      },
      {
        "id": "5234567890123456789",
        "text": "Our procurement team at BigEnterprise is reviewing CRM solutions. @company is on our shortlist for Q1 budget.",
        "created_at": "2025-07-13T00:05:00.000Z",
        "author_id": "112233445",
        "author_username": "procurement_director",
        "platform": "linkedin",
        "followers": 3200,
        "is_verified": false,
        "job_title": "Procurement Director",
        "company": "BigEnterprise",
        "ai_analysis": {
          "sentiment": "Neutral",
          "is_lead": true,
          "suggested_action": "Enterprise opportunity: Route to enterprise sales team for immediate follow-up.",
          "priority": "Critical",
          "lead_score": 92,
          "topic_category": "procurement_evaluation",
          "platform_insights": {
            "decision_maker": true,
            "enterprise_signal": true,
            "job_title": "Procurement Director",
            "company_context": "BigEnterprise",
            "business_intent": true
          },
          "platform_context": "professional",
          "influence_score": "3200 followers"
        }
      },
      {
        "id": "6234567890123456789",
        "text": "Just completed my MBA and exploring B2B software trends. @company seems to have innovative approach to CRM.",
        "created_at": "2025-07-13T00:02:00.000Z",
        "author_id": "667788990",
        "author_username": "mba_graduate",
        "platform": "linkedin",
        "followers": 800,
        "is_verified": false,
        "job_title": "Business Analyst",
        "company": "Consulting Firm",
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": false,
          "suggested_action": "Monitor and engage as appropriate.",
          "priority": "Low",
          "lead_score": 25,
          "topic_category": "industry_interest",
          "platform_insights": {
            "decision_maker": false,
            "enterprise_signal": false,
            "job_title": "Business Analyst",
            "company_context": "Consulting Firm",
            "business_intent": false
          },
          "platform_context": "professional",
          "influence_score": "800 followers"
        }
      }
    ],
    instagram: [
      {
        "id": "7234567890123456789",
        "text": "Managing 50+ brand accounts and @company helps me track all partnerships! Perfect for agencies 📈 #CreatorLife",
        "created_at": "2025-07-13T00:10:00.000Z",
        "author_id": "987654321",
        "author_username": "agency_creative",
        "platform": "instagram",
        "followers": 150000,
        "is_verified": true,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": true,
          "suggested_action": "High-influence creator: Explore partnership and collaboration opportunities.",
          "priority": "High",
          "lead_score": 80,
          "topic_category": "agency_endorsement",
          "platform_insights": {
            "influencer_tier": "macro",
            "business_account": true,
            "engagement_potential": "high",
            "collaboration_opportunity": true
          },
          "platform_context": "casual_visual",
          "influence_score": "Verified User"
        }
      },
      {
        "id": "8234567890123456789",
        "text": "Small business owner here! @company analytics show which posts drive actual sales vs just likes 💰",
        "created_at": "2025-07-13T00:05:00.000Z",
        "author_id": "112233445",
        "author_username": "boutique_owner",
        "platform": "instagram",
        "followers": 8500,
        "is_verified": false,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": false,
          "suggested_action": "Business opportunity: Offer content management and analytics solutions.",
          "priority": "Medium",
          "lead_score": 45,
          "topic_category": "small_business_success",
          "platform_insights": {
            "influencer_tier": "nano",
            "business_account": true,
            "engagement_potential": "medium",
            "collaboration_opportunity": false
          },
          "platform_context": "casual_visual",
          "influence_score": "8500 followers"
        }
      },
      {
        "id": "9234567890123456789",
        "text": "Love creating content! @company helps me understand my audience better ✨ #ContentCreator",
        "created_at": "2025-07-13T00:02:00.000Z",
        "author_id": "667788990",
        "author_username": "lifestyle_blogger",
        "platform": "instagram",
        "followers": 25000,
        "is_verified": false,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": false,
          "suggested_action": "Monitor and engage as appropriate.",
          "priority": "Medium",
          "lead_score": 30,
          "topic_category": "creator_feedback",
          "platform_insights": {
            "influencer_tier": "micro",
            "business_account": false,
            "engagement_potential": "high",
            "collaboration_opportunity": true
          },
          "platform_context": "casual_visual",
          "influence_score": "25000 followers"
        }
      }
    ],
    facebook: [
      {
        "id": "10234567890123456789",
        "text": "Our local medical practice has been using @company for patient engagement. HIPAA compliance features are excellent!",
        "created_at": "2025-07-13T00:10:00.000Z",
        "author_id": "987654321",
        "author_username": "family_clinic",
        "platform": "facebook",
        "followers": 2800,
        "is_verified": false,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": true,
          "suggested_action": "Regulated industry: Highlight compliance features and security certifications.",
          "priority": "High",
          "lead_score": 75,
          "topic_category": "healthcare_endorsement",
          "platform_insights": {
            "business_type": "healthcare",
            "community_focus": true,
            "compliance_needs": true,
            "nonprofit_program": false
          },
          "platform_context": "community_friendly",
          "influence_score": "2800 followers"
        }
      },
      {
        "id": "11234567890123456789",
        "text": "Running our nonprofit's social media is challenging! @company helps us connect with volunteers in our community.",
        "created_at": "2025-07-13T00:05:00.000Z",
        "author_id": "112233445",
        "author_username": "community_foundation",
        "platform": "facebook",
        "followers": 5200,
        "is_verified": true,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": true,
          "suggested_action": "Nonprofit detected: Offer nonprofit program and community support.",
          "priority": "Medium",
          "lead_score": 60,
          "topic_category": "nonprofit_use",
          "platform_insights": {
            "business_type": "nonprofit",
            "community_focus": true,
            "compliance_needs": false,
            "nonprofit_program": true
          },
          "platform_context": "community_friendly",
          "influence_score": "Verified User"
        }
      },
      {
        "id": "12234567890123456789",
        "text": "Local restaurant owner here. @company helps us manage our neighborhood customer relationships and events.",
        "created_at": "2025-07-13T00:02:00.000Z",
        "author_id": "667788990",
        "author_username": "neighborhood_bistro",
        "platform": "facebook",
        "followers": 1500,
        "is_verified": false,
        "ai_analysis": {
          "sentiment": "Positive",
          "is_lead": false,
          "suggested_action": "Local business: Emphasize community engagement and local presence tools.",
          "priority": "Medium",
          "lead_score": 40,
          "topic_category": "local_business",
          "platform_insights": {
            "business_type": "local",
            "community_focus": true,
            "compliance_needs": false,
            "nonprofit_program": false
          },
          "platform_context": "community_friendly",
          "influence_score": "1500 followers"
        }
      }
    ]
  };

  return platformData[platform] || platformData.twitter;
};

const mockMentions = generateMockDataByPlatform('twitter'); // Default to Twitter

module.exports = { mockMentions, generateMockDataByPlatform };