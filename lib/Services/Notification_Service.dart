import 'package:flutter_pr/Services/Auth_Service.dart';

import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static Future<List<dynamic>> getNotifications() async {
    try {
      final token = await AuthService.getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
        Uri.parse('${baseUrl}notification/get_notification'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<dynamic>.from(
            data['notifications']); // Ensure to convert to List<dynamic>
      } else {
        print('HTTP Error ${response.statusCode}: ${response.reasonPhrase}');
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      throw Exception('Failed to load notifications');
    }
  }


}
