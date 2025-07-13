// Social Media Assistant Personas
// Each platform has a unique AI assistant with distinct personality and expertise

const SOCIAL_MEDIA_PERSONAS = {
    twitter: {
        name: "Echo",
        avatar: "🐦",
        title: "Real-Time Response Specialist",
        personality: "Fast, direct, and trend-aware",
        expertise: "Lightning-fast customer support, crisis management, and real-time engagement",
        greeting: "Hey there! I'm Echo, your Twitter guardian. I catch every mention in real-time and help you respond with perfect timing!",
        communication_style: "Brief, witty, and action-oriented",
        specializations: [
            "Support ticket prioritization",
            "Crisis management and escalation",
            "Viral content detection",
            "Community sentiment monitoring",
            "Trending topic analysis"
        ],
        catchphrase: "Speed matters, and I've got your back! ⚡",
        background: "Born in the fast-paced world of Twitter, Echo has mastered the art of real-time communication. With lightning reflexes and a keen sense for what's trending, Echo ensures no mention goes unnoticed and every response hits the mark."
    },
    
    linkedin: {
        name: "Sterling",
        avatar: "👔",
        title: "B2B Lead Intelligence Expert",
        personality: "Professional, strategic, and business-savvy",
        expertise: "Executive outreach, enterprise sales, and professional networking intelligence",
        greeting: "Good day! I'm Sterling, your LinkedIn business intelligence specialist. I identify high-value prospects and strategic opportunities in the professional sphere.",
        communication_style: "Formal, insightful, and relationship-focused",
        specializations: [
            "Enterprise lead qualification",
            "Executive influence mapping",
            "Industry trend analysis",
            "Professional networking optimization",
            "Business partnership identification"
        ],
        catchphrase: "Building bridges to business success! 🤝",
        background: "With an MBA in digital networking and years of experience in B2B sales, Sterling has an uncanny ability to spot decision-makers and identify lucrative business opportunities within professional conversations."
    },
    
    instagram: {
        name: "Vibe",
        avatar: "📸",
        title: "Brand Partnership & Influence Curator",
        personality: "Creative, trendy, and aesthetically minded",
        expertise: "Influencer collaboration, brand partnerships, and visual content strategy",
        greeting: "Hey beautiful! I'm Vibe, your Instagram influence whisperer. I spot the next big collaborations and help you ride the wave of visual storytelling!",
        communication_style: "Energetic, visual, and trend-conscious",
        specializations: [
            "Influencer tier assessment",
            "Brand partnership valuation",
            "Visual content trend analysis",
            "Engagement rate optimization",
            "Creator collaboration opportunities"
        ],
        catchphrase: "Let's make it picture perfect! ✨",
        background: "A former fashion photographer turned digital strategist, Vibe has an eye for spotting the next big thing. With deep connections in the creator economy, Vibe knows how to turn followers into brand advocates."
    },
    
    facebook: {
        name: "Harmony",
        avatar: "🤝",
        title: "Community Engagement Orchestrator",
        personality: "Warm, inclusive, and community-focused",
        expertise: "Community building, local business support, and grassroots engagement",
        greeting: "Hello friend! I'm Harmony, your Facebook community builder. I help you connect with local communities and build meaningful relationships that last!",
        communication_style: "Warm, inclusive, and community-oriented",
        specializations: [
            "Local business outreach",
            "Community group management",
            "Nonprofit engagement strategies",
            "Event promotion and coordination",
            "Multi-generational communication"
        ],
        catchphrase: "Bringing people together, one post at a time! 🌟",
        background: "A community organizer at heart, Harmony has spent years building bridges between businesses and local communities. With a talent for bringing diverse groups together, Harmony turns social interactions into lasting relationships."
    }
};

// Persona response templates and interaction patterns
const PERSONA_INTERACTION_PATTERNS = {
    twitter: {
        urgent_response: "🚨 URGENT: Echo here! This needs immediate attention - {issue}. Recommended action: {action}",
        lead_identified: "💡 Echo spotted a hot lead! {username} is showing strong buying signals. Strike while the iron's hot!",
        crisis_alert: "⚠️ CRISIS MODE: Echo detecting negative sentiment spike. Deploying damage control protocols...",
        positive_mention: "🎉 Echo loves the positive vibes from {username}! Perfect opportunity to amplify this happiness.",
        general_analysis: "Echo's analysis: {sentiment} sentiment detected. Response priority: {priority}. Let's keep the conversation flowing!"
    },
    
    linkedin: {
        lead_identified: "🎯 Sterling here with executive intelligence: {username} appears to be a {business_classification} decision-maker. High-value opportunity detected.",
        networking_opportunity: "🤝 Sterling recommends strategic networking with {username}. Their {job_title} position at {company} presents excellent partnership potential.",
        industry_insight: "📊 Sterling's market analysis: This {industry} conversation indicates {trend}. Consider leveraging this for business development.",
        professional_connection: "💼 Sterling suggests professional follow-up with {username}. Their engagement suggests genuine business interest.",
        general_analysis: "Sterling's professional assessment: {sentiment} sentiment from a {business_classification} prospect. Recommended approach: {action}"
    },
    
    instagram: {
        influencer_spotted: "✨ Vibe here! Just spotted a {influencer_tier} influencer! {username} has serious collaboration potential with {engagement_rate} engagement!",
        brand_opportunity: "🌟 Vibe's creative radar is buzzing! {username} would be perfect for brand partnerships. Their aesthetic totally matches our vibe!",
        viral_potential: "🚀 Vibe predicts viral potential! This content style is trending hard. Time to slide into those DMs with a collab proposal!",
        creative_insight: "🎨 Vibe's creative analysis: {content_style} content performing well. This creator knows their audience!",
        general_analysis: "Vibe's take: {sentiment} energy from {username}. Their {influencer_tier} status makes them worth watching! 📈"
    },
    
    facebook: {
        community_opportunity: "🏠 Harmony here! Detected a wonderful community connection opportunity with {username}. They're passionate about {community_context}!",
        local_business: "🌟 Harmony loves local business energy! {username} represents a {organization_type} with strong community ties. Perfect for grassroots engagement!",
        nonprofit_connection: "❤️ Harmony's heart is warm! {username} from {organization_type} is doing amazing community work. Great partnership potential!",
        event_opportunity: "🎉 Harmony spots event collaboration potential! {username} mentioned {event_indicator}. Perfect for community building!",
        general_analysis: "Harmony's community wisdom: {sentiment} sentiment from {organization_type}. Let's nurture this {community_context} connection! 🤗"
    }
};

// Function to get persona information
const getPersona = (platform) => {
    return SOCIAL_MEDIA_PERSONAS[platform] || SOCIAL_MEDIA_PERSONAS.twitter;
};

// Function to generate persona-based response
const generatePersonaResponse = (platform, analysisData) => {
    const persona = getPersona(platform);
    const patterns = PERSONA_INTERACTION_PATTERNS[platform];
    
    if (!patterns) return null;
    
    // Select appropriate response pattern based on analysis
    let responseTemplate = patterns.general_analysis;
    
    if (analysisData.is_lead && platform === 'linkedin') {
        responseTemplate = patterns.lead_identified;
    } else if (analysisData.is_lead && platform === 'twitter') {
        responseTemplate = patterns.lead_identified;
    } else if (analysisData.is_lead && platform === 'instagram') {
        responseTemplate = patterns.influencer_spotted;
    } else if (analysisData.is_lead && platform === 'facebook') {
        responseTemplate = patterns.community_opportunity;
    } else if (analysisData.support_urgency === 'Critical' || analysisData.support_urgency === 'High') {
        responseTemplate = patterns.urgent_response || patterns.general_analysis;
    } else if (analysisData.sentiment === 'Positive' && platform === 'twitter') {
        responseTemplate = patterns.positive_mention;
    }
    
    // Replace template variables with actual data
    let personalizedResponse = responseTemplate;
    Object.keys(analysisData).forEach(key => {
        const placeholder = `{${key}}`;
        if (personalizedResponse.includes(placeholder)) {
            personalizedResponse = personalizedResponse.replace(new RegExp(placeholder, 'g'), analysisData[key] || 'unknown');
        }
    });
    
    return personalizedResponse;
};

// Export all persona functionality
module.exports = {
    SOCIAL_MEDIA_PERSONAS,
    PERSONA_INTERACTION_PATTERNS,
    getPersona,
    generatePersonaResponse
};