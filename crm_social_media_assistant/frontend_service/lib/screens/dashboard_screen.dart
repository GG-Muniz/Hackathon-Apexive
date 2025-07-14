import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'platform_analytics_screen.dart';
import 'mention_analytics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  String _selectedPlatform = 'twitter';
  
  final Map<String, IconData> _platformIcons = {
    'twitter': Icons.alternate_email,
    'linkedin': Icons.business,
    'instagram': Icons.camera_alt,
    'facebook': Icons.group,
  };

  // Custom persona avatars with unique personalities
  Widget _buildPersonaAvatar(String platform, String avatar, {double size = 48}) {
    final Map<String, Map<String, dynamic>> personaStyles = {
      'twitter': {
        'gradient': [const Color(0xFF1DA1F2), const Color(0xFF0D8BD9)], // Twitter blue
        'icon': Icons.flash_on, // Lightning for speed/real-time
        'emoji': '⚡',
      },
      'linkedin': {
        'gradient': [const Color(0xFF0077B5), const Color(0xFF005885)], // LinkedIn blue
        'icon': Icons.psychology, // Brain for intelligence
        'emoji': '🧠',
      },
      'instagram': {
        'gradient': [const Color(0xFFE1306C), const Color(0xFFFD1D1D)], // Instagram gradient
        'icon': Icons.auto_awesome, // Sparkle for creativity
        'emoji': '✨',
      },
      'facebook': {
        'gradient': [const Color(0xFF1877F2), const Color(0xFF166FE5)], // Facebook blue
        'icon': Icons.favorite, // Heart for community
        'emoji': '💫',
      },
    };

    final style = personaStyles[platform] ?? personaStyles['twitter']!;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: style['gradient'] as List<Color>,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (style['gradient'] as List<Color>)[0].withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
                stops: const [0.3, 1.0],
              ),
            ),
          ),
          // Main emoji/icon
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (size > 40) ...[
                  Text(
                    style['emoji'] as String,
                    style: TextStyle(fontSize: size * 0.4),
                  ),
                  SizedBox(height: size * 0.05),
                ],
                Icon(
                  style['icon'] as IconData,
                  size: size * 0.25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // 60% - Deep dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A), // Dark grey
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDAC0A7), Color(0xFFC8A882)], // Warm sand gradient
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.analytics_outlined, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text('SocialMind AI Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFDAC0A7)),
            onPressed: () {
              // Trigger refresh
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFDAC0A7)),
            onPressed: () {
              // Settings menu
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0F0F), // Deep dark
              Color(0xFF1A1A1A), // Lighter dark grey
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              'Social Media Intelligence Center',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'AI-powered insights across all your social platforms',
              style: TextStyle(
                fontSize: 16, 
                color: Color(0xFF888888), // Light grey
              ),
            ),
            const SizedBox(height: 20),
            
            // Platform Selector - Dark Modern Design
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A), // 30% - Medium grey
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3A3A3A),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your platform',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: _platformIcons.entries.map((entry) {
                      final isSelected = entry.key == _selectedPlatform;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPlatform = entry.key;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? const Color(0xFFDAC0A7) // 10% - Warm sand accent
                                    : const Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected 
                                    ? Border.all(color: const Color(0xFFDAC0A7), width: 2)
                                    : Border.all(color: const Color(0xFF4A4A4A), width: 1),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    entry.value,
                                    size: 24,
                                    color: isSelected 
                                        ? Colors.black 
                                        : const Color(0xFF888888),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    entry.key.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected 
                                          ? Colors.black 
                                          : const Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _apiService.getAnalyzedMentions(platform: _selectedPlatform),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text('Error: ${snapshot.error}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  final data = snapshot.data ?? <String, dynamic>{};
                  final mentions = (data['mentions'] as List?) ?? <dynamic>[];
                  final persona = (data['persona'] as Map<String, dynamic>?) ?? <String, dynamic>{};
                  
                  // Debug information
                  print('DEBUG: Data keys: ${data.keys.toList()}');
                  print('DEBUG: Mentions length: ${mentions.length}');
                  print('DEBUG: Persona: $persona');
                  
                  if (mentions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No mentions found'),
                          const SizedBox(height: 16),
                          Text('Debug: Data keys: ${data.keys.toList()}'),
                          Text('Debug: Response type: ${data.runtimeType}'),
                        ],
                      ),
                    );
                  }
                  
                  return Column(
                    children: [
                      // Analytics Header Bar
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF3A3A3A),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Platform info
                            _buildPersonaAvatar(_selectedPlatform, persona['avatar']?.toString() ?? '🤖', size: 40),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_selectedPlatform.toUpperCase()} Analytics Center',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFDAC0A7), // Warm sand color for prominence
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      _buildMetricChip('${mentions.length}', 'Mentions', Icons.forum),
                                      const SizedBox(width: 12),
                                      _buildMetricChip('${mentions.where((m) => (m as Map)['ai_analysis']?['is_lead'] == true).length}', 'Leads', Icons.star),
                                      const SizedBox(width: 12),
                                      _buildMetricChip('85%', 'Positive', Icons.sentiment_satisfied),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Analytics actions
                            Row(
                              children: [
                                _buildAnalyticsButton(
                                  'Deep Analytics',
                                  Icons.insights,
                                  () => _openPlatformAnalytics(_selectedPlatform),
                                ),
                                const SizedBox(width: 12),
                                _buildAnalyticsButton(
                                  'Chat with ${persona['name']}',
                                  Icons.chat,
                                  () => _openPlatformAnalytics(_selectedPlatform),
                                ),
                                const SizedBox(width: 12),
                                _buildAnalyticsButton(
                                  'Export Data',
                                  Icons.download,
                                  () => _exportData(_selectedPlatform),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Persona Chat Interface
                      if (persona.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Chat Header
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A), // 30% - Medium grey
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF3A3A3A),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Persona Avatar with Status
                                    Stack(
                                      children: [
                                        _buildPersonaAvatar(_selectedPlatform, persona['avatar']?.toString() ?? '🤖'),
                                        // Online status indicator
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDAC0A7), // Warm sand accent
                                              shape: BoxShape.circle,
                                              border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 12),
                                    // Persona Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            persona['name']?.toString() ?? 'AI Assistant',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            persona['title']?.toString() ?? 'Social Media Analyst',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF888888),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Chat Actions
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF2D7).withOpacity(0.3), // Light sand accent
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8,
                                            color: Color(0xFFDAC0A7),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Online',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFDAC0A7),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Chat Bubble with Greeting
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A), // 30% - Medium grey
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF3A3A3A),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Small avatar for chat bubble
                                    _buildPersonaAvatar(_selectedPlatform, persona['avatar']?.toString() ?? '🤖', size: 32),
                                    const SizedBox(width: 12),
                                    // Chat bubble
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF3A3A3A),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: const Color(0xFF4A4A4A),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              persona['greeting']?.toString() ?? 'Ready to help you analyze social media!',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                height: 1.4,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'just now',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF888888),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      // Mentions List
                      Expanded(
                        child: ListView.builder(
                          itemCount: mentions.length,
                          itemBuilder: (context, index) {
                            final mention = mentions[index] as Map<String, dynamic>? ?? <String, dynamic>{};
                            final analysis = (mention['ai_analysis'] as Map<String, dynamic>?) ?? <String, dynamic>{};
                            final isLead = analysis['is_lead'] == true;
                            final priority = analysis['priority']?.toString() ?? 'Medium';
                            final suggestedAction = analysis['suggested_action']?.toString() ?? '';
                      
                      Color priorityColor = Colors.green;
                      if (priority == 'Critical') priorityColor = Colors.red;
                      else if (priority == 'High') priorityColor = Colors.orange;
                      else if (priority == 'Low') priorityColor = Colors.blue;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A), // 30% - Medium grey
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF3A3A3A),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User Message Bubble
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // User Avatar
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          priorityColor.withOpacity(0.8),
                                          priorityColor,
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: priorityColor.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        _platformIcons[_selectedPlatform],
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Message Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header with username and priority
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '@${mention['author_username']?.toString() ?? 'Unknown'}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            if (isLead) 
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFDAC0A7), // 10% - Warm sand accent
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: const Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.star, size: 12, color: Colors.black),
                                                    SizedBox(width: 2),
                                                    Text('Lead', style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: priorityColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: priorityColor.withOpacity(0.3),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                priority,
                                                style: TextStyle(
                                                  color: priorityColor,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        // User message bubble
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF3A3A3A),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: const Color(0xFF4A4A4A),
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mention['text']?.toString() ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  height: 1.4,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Text(
                                                    '2 min ago',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFF888888),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  // Enhanced action buttons
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => _generateReply(mention),
                                                        child: Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFFFFF2D7).withOpacity(0.3),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: const Icon(
                                                            Icons.reply,
                                                            size: 16,
                                                            color: Color(0xFFDAC0A7),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      GestureDetector(
                                                        onTap: () => _openAnalytics(mention, _selectedPlatform),
                                                        child: Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFFDAC0A7).withOpacity(0.2),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: const Icon(
                                                            Icons.analytics_outlined,
                                                            size: 16,
                                                            color: Color(0xFFDAC0A7),
                                                          ),
                                                        ),
                                                      ),
                                                      if (isLead) ...[
                                                        const SizedBox(width: 6),
                                                        GestureDetector(
                                                          onTap: () => _createLead(mention),
                                                          child: Container(
                                                            padding: const EdgeInsets.all(6),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFF22C55E).withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: const Icon(
                                                              Icons.person_add,
                                                              size: 16,
                                                              color: Color(0xFF22C55E),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              // AI Persona Response
                              if (analysis['persona_insight']?.toString().isNotEmpty == true) ...[
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // AI Avatar
                                    _buildPersonaAvatar(_selectedPlatform, analysis['persona_avatar']?.toString() ?? '🤖', size: 36),
                                    const SizedBox(width: 12),
                                    // AI Response bubble
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            analysis['persona_name']?.toString() ?? 'AI Assistant',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: Color(0xFFDAC0A7),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFFFFF2D7).withOpacity(0.15), // Light sand
                                                  const Color(0xFFDAC0A7).withOpacity(0.1), // Warm sand
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                color: const Color(0xFFDAC0A7).withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  analysis['persona_insight']?.toString() ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    height: 1.4,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'just now',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF888888),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              
                              // Additional insights if available
                              if (suggestedAction.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3A3A3A),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF4A4A4A),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.lightbulb_outline,
                                        size: 16,
                                        color: Color(0xFFDAC0A7),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Recommended Action',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Color(0xFFDAC0A7),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              suggestedAction,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _createLead(Map<String, dynamic> mention) async {
    try {
      await _apiService.createLead(
        mention['author_username'] ?? 'Unknown',
        'Lead from Social Media: ${mention['text'] ?? ''}',
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create lead: $e')),
        );
      }
    }
  }

  // Analytics helper methods
  Widget _buildMetricChip(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2D7).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDAC0A7).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFDAC0A7)),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDAC0A7), Color(0xFFC8A882)],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDAC0A7).withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.black),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAnalytics(Map<String, dynamic> mention, String platform) {
    // Navigate to individual mention analytics
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MentionAnalyticsScreen(
          mention: mention,
          platform: platform,
        ),
      ),
    );
  }

  void _openPlatformAnalytics(String platform) {
    // Navigate to platform-wide analytics dashboard
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlatformAnalyticsScreen(platform: platform),
      ),
    );
  }

  void _exportData(String platform) {
    // Show export options dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Export Analytics Data',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildExportOption('CSV Report', Icons.table_chart, () {
              Navigator.pop(context);
              _showExportSuccess('CSV');
            }),
            const SizedBox(height: 8),
            _buildExportOption('PDF Summary', Icons.picture_as_pdf, () {
              Navigator.pop(context);
              _showExportSuccess('PDF');
            }),
            const SizedBox(height: 8),
            _buildExportOption('JSON Data', Icons.code, () {
              Navigator.pop(context);
              _showExportSuccess('JSON');
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFFDAC0A7))),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4A4A4A)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFDAC0A7), size: 20),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _showExportSuccess(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$format export started! Download will begin shortly.'),
        backgroundColor: const Color(0xFFDAC0A7),
      ),
    );
  }

  void _generateReply(Map<String, dynamic> mention) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final replyData = await _apiService.generateReply(mention);
      
      // Close loading dialog
      if (mounted) Navigator.of(context).pop();
      
      // Show reply dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('AI Generated Reply'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Original Post:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('"${mention['text']}"'),
                const SizedBox(height: 16),
                const Text(
                  'Suggested Reply:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(replyData['suggested_reply'] ?? 'No reply generated'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Copy to clipboard functionality could go here
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reply ready to use!')),
                  );
                },
                child: const Text('Copy Reply'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (mounted) Navigator.of(context).pop();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate reply: $e')),
        );
      }
    }
  }
}