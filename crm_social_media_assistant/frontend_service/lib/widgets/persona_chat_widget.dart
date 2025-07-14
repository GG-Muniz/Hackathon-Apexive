import 'package:flutter/material.dart';

class PersonaChatWidget extends StatefulWidget {
  final String platform;
  final Map<String, dynamic> persona;
  final Map<String, dynamic>? contextData;

  const PersonaChatWidget({
    super.key,
    required this.platform,
    required this.persona,
    this.contextData,
  });

  @override
  State<PersonaChatWidget> createState() => _PersonaChatWidgetState();
}

class _PersonaChatWidgetState extends State<PersonaChatWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Add initial greeting
    _addPersonaMessage(_getPersonaGreeting());
    _addSuggestedQuestions();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Chat Window
          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _expandAnimation.value,
                alignment: Alignment.bottomRight,
                child: _isExpanded ? _buildChatWindow() : const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(height: 12),
          // Floating Action Button
          _buildFloatingChatButton(),
        ],
      ),
    );
  }

  Widget _buildFloatingChatButton() {
    return GestureDetector(
      onTap: _toggleChat,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getPersonaGradient(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _getPersonaGradient()[0].withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Persona Avatar
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getPersonaEmoji(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Icon(
                    _isExpanded ? Icons.close : Icons.chat,
                    size: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Notification Badge
            if (_hasNewMessages())
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatWindow() {
    return Container(
      width: 350,
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chat Header
          _buildChatHeader(),
          // Messages
          Expanded(
            child: _buildMessagesList(),
          ),
          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getPersonaGradient(),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _getPersonaEmoji(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.persona['name']?.toString() ?? 'AI Assistant',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.persona['title']?.toString() ?? 'Your AI Consultant',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _toggleChat,
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _messages.length + (_isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _messages.length && _isTyping) {
            return _buildTypingIndicator();
          }
          return _buildMessageBubble(_messages[index]);
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: _getPersonaGradient()),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(_getPersonaEmoji(), style: const TextStyle(fontSize: 10)),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser 
                        ? const Color(0xFFDAC0A7) 
                        : const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(
                          color: isUser ? Colors.black : Colors.white,
                          height: 1.4,
                        ),
                      ),
                      if (message.suggestedQuestions.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...message.suggestedQuestions.map((question) => 
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: () => _sendMessage(question),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF2D7).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFDAC0A7).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  question,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFDAC0A7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
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
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: _getPersonaGradient()),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(_getPersonaEmoji(), style: const TextStyle(fontSize: 10)),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(200),
                const SizedBox(width: 4),
                _buildTypingDot(400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int delay) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double value = (_animationController.value + delay / 1000) % 1.0;
        return Transform.translate(
          offset: Offset(0, -4 * (0.5 - (value - 0.5).abs()) * 2),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFFDAC0A7),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2D7), // Light sand background for better contrast
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFDAC0A7).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  hintText: 'Ask me anything about your analytics...',
                  hintStyle: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onSubmitted: (text) {
                  if (text.isNotEmpty) {
                    _sendMessage(text);
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                _sendMessage(_messageController.text);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: _getPersonaGradient()),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleChat() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(ChatMessage(
            text: _generatePersonaResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    });
  }

  void _addPersonaMessage(String text, {List<String> suggestedQuestions = const []}) {
    _messages.add(ChatMessage(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
      suggestedQuestions: suggestedQuestions,
    ));
  }

  void _addSuggestedQuestions() {
    final questions = _getPersonaSuggestedQuestions();
    if (questions.isNotEmpty) {
      _addPersonaMessage(
        "Here are some questions I can help you with:",
        suggestedQuestions: questions,
      );
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getPersonaGreeting() {
    switch (widget.platform.toLowerCase()) {
      case 'twitter':
        return "Hi! I'm Echo, your real-time Twitter specialist. I'm here to help you navigate trends, optimize engagement, and maximize your Twitter presence. What would you like to know?";
      case 'linkedin':
        return "Hello! I'm Sterling, your B2B LinkedIn expert. I can help with professional networking, lead generation, and industry insights. How can I assist your LinkedIn strategy today?";
      case 'instagram':
        return "Hey there! I'm Vibe, your Instagram creative guru. Let's talk visual storytelling, hashtag strategies, and community building. What's on your mind?";
      case 'facebook':
        return "Welcome! I'm Harmony, your Facebook community specialist. I'm here to help with audience growth, engagement strategies, and local business insights. What can I help you with?";
      default:
        return "Hello! I'm your AI social media consultant. I'm here to help you understand your analytics and improve your social media strategy. What would you like to discuss?";
    }
  }

  List<String> _getPersonaSuggestedQuestions() {
    switch (widget.platform.toLowerCase()) {
      case 'twitter':
        return [
          "What's trending in my industry?",
          "When should I post for maximum reach?",
          "How can I increase engagement?",
          "What hashtags should I use?",
        ];
      case 'linkedin':
        return [
          "How can I generate more B2B leads?",
          "What content performs best?",
          "Who should I connect with?",
          "How do I optimize my profile?",
        ];
      case 'instagram':
        return [
          "What hashtags work for my niche?",
          "How can I improve my visual content?",
          "What's my best posting time?",
          "How do I grow my followers?",
        ];
      case 'facebook':
        return [
          "How can I grow my community?",
          "What's my audience demographic?",
          "Should I boost this post?",
          "How do I increase local reach?",
        ];
      default:
        return [
          "Analyze my recent performance",
          "What should I post next?",
          "How can I improve engagement?",
        ];
    }
  }

  String _generatePersonaResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    // Context-aware responses based on current analytics data
    if (widget.contextData != null) {
      final mentionsCount = widget.contextData!['mentionsCount'] ?? 0;
      final leadsCount = widget.contextData!['leadsCount'] ?? 0;
      final sentiment = widget.contextData!['sentiment'] ?? 85;
      
      if (message.contains('performance') || message.contains('analytics')) {
        return "Based on your current data, you have $mentionsCount mentions with $leadsCount qualified leads. Your sentiment is $sentiment% positive, which is excellent! I recommend focusing on the content types that are generating the most engagement.";
      }
    }

    // Platform-specific responses
    switch (widget.platform.toLowerCase()) {
      case 'twitter':
        if (message.contains('trend') || message.contains('hashtag')) {
          return "For Twitter trends, I recommend monitoring hashtags in your industry daily. Based on your recent performance, tech and business-related hashtags are performing well. Try using 2-3 relevant hashtags per tweet and engage with trending topics when they align with your brand.";
        }
        if (message.contains('engagement')) {
          return "To boost Twitter engagement, post when your audience is most active (typically 9-10 AM and 7-9 PM). Ask questions, use polls, and respond quickly to comments. Visual content gets 3x more engagement than text-only tweets.";
        }
        break;
        
      case 'linkedin':
        if (message.contains('lead') || message.contains('b2b')) {
          return "For B2B lead generation on LinkedIn, focus on value-driven content. Share industry insights, case studies, and thought leadership posts. Engage meaningfully in comments and send personalized connection requests. Your current conversion rate suggests your content resonates well with your target audience.";
        }
        if (message.contains('content')) {
          return "LinkedIn favors educational and professional content. Posts with industry insights, tips, and behind-the-scenes content perform best. Aim for 1-3 posts per week with native video content getting the highest engagement rates.";
        }
        break;
        
      case 'instagram':
        if (message.contains('hashtag') || message.contains('visual')) {
          return "For Instagram, use a mix of popular and niche hashtags. Aim for 20-30 hashtags including branded ones. Your visual content should maintain consistent aesthetics. Stories and Reels are currently getting the most reach - consider posting 3-5 stories daily.";
        }
        if (message.contains('follower') || message.contains('grow')) {
          return "To grow Instagram followers authentically, post consistently (1-2 feed posts daily), engage with your community within the first hour of posting, collaborate with micro-influencers in your niche, and use location tags for local discovery.";
        }
        break;
        
      case 'facebook':
        if (message.contains('community') || message.contains('audience')) {
          return "Facebook community growth requires consistent value delivery. Create or join relevant groups, share community-focused content, and respond promptly to comments. Local businesses should leverage Facebook Events and location-based targeting.";
        }
        if (message.contains('boost') || message.contains('ad')) {
          return "For Facebook advertising, I recommend starting with a small budget on your best organic posts. Target lookalike audiences based on your current engaged followers. Video content typically has lower CPMs and higher engagement rates.";
        }
        break;
    }

    // Generic helpful responses
    if (message.contains('help') || message.contains('advice')) {
      return "I'm here to help you optimize your social media strategy! I can analyze your current performance, suggest content ideas, recommend posting times, and help you understand your audience better. What specific area would you like to focus on?";
    }

    return "Great question! Based on your ${widget.platform} analytics, I can see several opportunities for improvement. Would you like me to dive deeper into your content strategy, audience engagement, or growth tactics? I'm here to provide personalized insights for your specific situation.";
  }

  List<Color> _getPersonaGradient() {
    switch (widget.platform.toLowerCase()) {
      case 'twitter':
        return [const Color(0xFF1DA1F2), const Color(0xFF0D8BD9)];
      case 'linkedin':
        return [const Color(0xFF0077B5), const Color(0xFF005885)];
      case 'instagram':
        return [const Color(0xFFE1306C), const Color(0xFFFD1D1D)];
      case 'facebook':
        return [const Color(0xFF1877F2), const Color(0xFF166FE5)];
      default:
        return [const Color(0xFFDAC0A7), const Color(0xFFC8A882)];
    }
  }

  String _getPersonaEmoji() {
    switch (widget.platform.toLowerCase()) {
      case 'twitter':
        return '⚡';
      case 'linkedin':
        return '🧠';
      case 'instagram':
        return '✨';
      case 'facebook':
        return '💫';
      default:
        return '🤖';
    }
  }

  bool _hasNewMessages() {
    return false; // Implement logic for new message notifications
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String> suggestedQuestions;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.suggestedQuestions = const [],
  });
}