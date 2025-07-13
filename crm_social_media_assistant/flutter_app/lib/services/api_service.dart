import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

<<<<<<< HEAD
  Future<List<dynamic>> getAnalyzedMentions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/analyze-mentions'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
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

  Future<Map<String, dynamic>> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Server unhealthy');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
=======
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
}