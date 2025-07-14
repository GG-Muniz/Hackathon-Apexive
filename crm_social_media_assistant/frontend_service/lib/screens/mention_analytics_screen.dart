import 'package:flutter/material.dart';
import '../widgets/persona_chat_widget.dart';

class MentionAnalyticsScreen extends StatefulWidget {
  final Map<String, dynamic> mention;
  final String platform;

  const MentionAnalyticsScreen({
    super.key,
    required this.mention,
    required this.platform,
  });

  @override
  State<MentionAnalyticsScreen> createState() => _MentionAnalyticsScreenState();
}

class _MentionAnalyticsScreenState extends State<MentionAnalyticsScreen> {
  
  // Get persona data for chat
  Map<String, dynamic> _getPersonaData() {
    final Map<String, Map<String, dynamic>> personas = {
      'twitter': {
        'name': 'Echo',
        'title': 'Real-Time Response Specialist',
        'avatar': '⚡',
      },
      'linkedin': {
        'name': 'Sterling',
        'title': 'B2B Lead Intelligence Expert',
        'avatar': '🧠',
      },
      'instagram': {
        'name': 'Vibe',
        'title': 'Creative Engagement Guru',
        'avatar': '✨',
      },
      'facebook': {
        'name': 'Harmony',
        'title': 'Community Growth Specialist',
        'avatar': '💫',
      },
    };
    return personas[widget.platform] ?? personas['twitter']!;
  }

  Map<String, dynamic> _getContextData() {
    final analysis = widget.mention['ai_analysis'] as Map<String, dynamic>? ?? {};
    return {
      'mention': widget.mention,
      'mentionsCount': 1200,
      'leadsCount': 247,
      'sentiment': analysis['sentiment'] ?? 'neutral',
      'priority': analysis['priority'] ?? 'Medium',
      'isLead': analysis['is_lead'] == true,
      'platform': widget.platform,
    };
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDAC0A7), Color(0xFFC8A882)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.analytics_outlined, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mention Analytics',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Color(0xFFDAC0A7)),
            onPressed: _bookmarkMention,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F0F0F),
                  Color(0xFF1A1A1A),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Original Mention Card
                  _buildOriginalMention(),
                  const SizedBox(height: 24),
                  
                  // Analytics Overview
                  _buildAnalyticsOverview(),
                  const SizedBox(height: 24),
                  
                  // Engagement Metrics
                  _buildEngagementMetrics(),
                  const SizedBox(height: 24),
                  
                  // AI Analysis Details
                  _buildAIAnalysisDetails(),
                  const SizedBox(height: 24),
                  
                  // Recommended Actions
                  _buildRecommendedActions(),
                  const SizedBox(height: 24),
                  
                  // Similar Mentions
                  _buildSimilarMentions(),
                ],
              ),
            ),
          ),
          // Floating Chat Widget
          PersonaChatWidget(
            platform: widget.platform,
            persona: _getPersonaData(),
            contextData: _getContextData(),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginalMention() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Original Mention',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFDAC0A7), // Warm sand for header prominence
                ),
              ),
              const Spacer(),
              _buildPlatformBadge(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFDAC0A7), Color(0xFFC8A882)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${widget.mention['author_username']?.toString() ?? 'Unknown'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.mention['text']?.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDAC0A7).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.platform.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Color(0xFFDAC0A7),
        ),
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    final analysis = widget.mention['ai_analysis'] as Map<String, dynamic>? ?? {};
    final sentiment = analysis['sentiment']?.toString() ?? 'neutral';
    final priority = analysis['priority']?.toString() ?? 'Medium';
    final isLead = analysis['is_lead'] == true;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analytics Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  'Sentiment',
                  sentiment,
                  _getSentimentIcon(sentiment),
                  _getSentimentColor(sentiment),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOverviewMetric(
                  'Priority',
                  priority,
                  Icons.flag,
                  _getPriorityColor(priority),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOverviewMetric(
                  'Lead Status',
                  isLead ? 'Qualified' : 'Standard',
                  isLead ? Icons.star : Icons.person,
                  isLead ? const Color(0xFFDAC0A7) : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementMetrics() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Engagement Metrics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildEngagementCard('Reach', '1.2K', Icons.visibility)),
              const SizedBox(width: 12),
              Expanded(child: _buildEngagementCard('Likes', '89', Icons.favorite)),
              const SizedBox(width: 12),
              Expanded(child: _buildEngagementCard('Shares', '23', Icons.share)),
              const SizedBox(width: 12),
              Expanded(child: _buildEngagementCard('Comments', '12', Icons.comment)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFDAC0A7), size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisDetails() {
    final analysis = widget.mention['ai_analysis'] as Map<String, dynamic>? ?? {};
    final insight = analysis['persona_insight']?.toString() ?? '';
    final personaName = analysis['persona_name']?.toString() ?? 'AI Assistant';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'AI Analysis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDAC0A7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'By $personaName',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFFDAC0A7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (insight.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFF2D7).withOpacity(0.1),
                    const Color(0xFFDAC0A7).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFDAC0A7).withOpacity(0.3),
                ),
              ),
              child: Text(
                insight,
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendedActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionItem(
            Icons.reply,
            'Respond Immediately',
            'High engagement potential - respond within 2 hours',
            const Color(0xFFDAC0A7),
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            Icons.trending_up,
            'Amplify Content',
            'Consider promoting this type of content',
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            Icons.person_add,
            'Follow Up',
            'User shows buying intent - schedule follow-up',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarMentions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Similar Mentions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildSimilarMentionItem('@user123', 'Great product! Really satisfied...'),
          const SizedBox(height: 8),
          _buildSimilarMentionItem('@customer456', 'Amazing customer service experience...'),
          const SizedBox(height: 8),
          _buildSimilarMentionItem('@reviewer789', 'Would definitely recommend to others...'),
        ],
      ),
    );
  }

  Widget _buildSimilarMentionItem(String username, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFDAC0A7),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFFDAC0A7),
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF888888),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSentimentIcon(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return Icons.sentiment_satisfied;
      case 'negative':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  void _bookmarkMention() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mention bookmarked for later review!'),
        backgroundColor: Color(0xFFDAC0A7),
      ),
    );
  }
}