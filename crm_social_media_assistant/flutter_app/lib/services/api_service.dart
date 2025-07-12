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
}