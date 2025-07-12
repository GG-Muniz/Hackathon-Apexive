import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();

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
              'Twitter mentions analyzed with AI',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _apiService.getAnalyzedMentions(),
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
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            mention['ai_analysis']?['is_lead'] == true 
                              ? Icons.star 
                              : Icons.chat_bubble_outline,
                            color: mention['ai_analysis']?['is_lead'] == true 
                              ? Colors.amber 
                              : Colors.blue,
                          ),
                          title: Text(mention['author_username'] ?? 'Unknown'),
                          subtitle: Text(mention['text'] ?? ''),
                          trailing: mention['ai_analysis']?['is_lead'] == true
                            ? IconButton(
                                icon: const Icon(Icons.person_add),
                                onPressed: () => _createLead(mention),
                              )
                            : null,
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
        'Lead from Twitter: ${mention['text'] ?? ''}',
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
}