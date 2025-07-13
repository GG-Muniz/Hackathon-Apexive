import 'package:flutter/material.dart';
import '../services/api_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Social Media Assistant',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Social media mentions analyzed with AI',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            // Platform Selector
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Text('Platform: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      children: _platformIcons.entries.map((entry) {
                        final isSelected = entry.key == _selectedPlatform;
                        return FilterChip(
                          avatar: Icon(entry.value, size: 16),
                          label: Text(entry.key.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedPlatform = entry.key;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: FutureBuilder<List<dynamic>>(
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
                  
                  final mentions = snapshot.data ?? [];
                  
                  if (mentions.isEmpty) {
                    return const Center(
                      child: Text('No mentions found'),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: mentions.length,
                    itemBuilder: (context, index) {
                      final mention = mentions[index];
                      final analysis = mention['ai_analysis'] ?? {};
                      final isLead = analysis['is_lead'] == true;
                      final priority = analysis['priority'] ?? 'Medium';
                      final suggestedAction = analysis['suggested_action'] ?? '';
                      
                      Color priorityColor = Colors.green;
                      if (priority == 'Critical') priorityColor = Colors.red;
                      else if (priority == 'High') priorityColor = Colors.orange;
                      else if (priority == 'Low') priorityColor = Colors.blue;
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Row
                              Row(
                                children: [
                                  Icon(_platformIcons[_selectedPlatform], size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '@${mention['author_username'] ?? 'Unknown'}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  if (isLead) const Icon(Icons.star, color: Colors.amber, size: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: priorityColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      priority,
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // Content
                              Text(
                                mention['text'] ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 12),
                              
                              // Prominent Suggested Action
                              if (suggestedAction.isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.lightbulb_outline, size: 16, color: Colors.blue),
                                          SizedBox(width: 4),
                                          Text('Suggested Action:', 
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(suggestedAction, style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 12),
                              
                              // Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => _generateReply(mention),
                                    icon: const Icon(Icons.reply, size: 16),
                                    label: const Text('Reply'),
                                  ),
                                  if (isLead) ...[
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      onPressed: () => _createLead(mention),
                                      icon: const Icon(Icons.person_add, size: 16),
                                      label: const Text('Create Lead'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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