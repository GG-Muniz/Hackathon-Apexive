import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      
      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Failed to connect to server'};
    }
  }

  Future<Map<String, dynamic>> generateSocialMediaPost(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/generate-post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'prompt': prompt}),
      );
      
      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Failed to generate post'};
    }
  }

  Future<Map<String, dynamic>> postToTwitter(String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/post-twitter'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'content': content}),
      );
      
      return json.decode(response.body);
    } catch (e) {
      return {'error': 'Failed to post to Twitter'};
    }
  }

  Future<Map<String, dynamic>> getAnalyzedMentions({String platform = 'twitter'}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/analyze-mentions?platform=$platform'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Return the full response with persona data and mentions
        return data;
      } else {
        throw Exception('Failed to load mentions');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> createLead(String contactName, String description) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create-lead'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'contact_name': contactName,
          'description': description,
        }),
      );
      
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create lead');
      }
    } catch (e) {
      throw Exception('Failed to create lead: $e');
    }
  }

  Future<Map<String, dynamic>> generateReply(Map<String, dynamic> mention) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-reply'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'tweet_text': mention['text'],
          'author_username': mention['author_username'],
          'sentiment': mention['ai_analysis']?['sentiment'] ?? 'Neutral',
          'is_lead': mention['ai_analysis']?['is_lead'] ?? false,
          'suggested_action': mention['ai_analysis']?['suggested_action'] ?? '',
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to generate reply');
      }
    } catch (e) {
      throw Exception('Failed to generate reply: $e');
    }
  }

  // Get all AI personas
  Future<Map<String, dynamic>> getPersonas() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/personas'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load personas');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Get specific platform persona
  Future<Map<String, dynamic>> getPersona(String platform) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/personas/$platform'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load $platform persona');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}