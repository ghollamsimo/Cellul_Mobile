import 'package:flutter_pr/Services/Auth_Service.dart';
import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class FeedbackService {
static Future<Map<String, dynamic>> add_feedback(
      String feedback, int id) async {
    final url = Uri.parse('${baseUrl}feedback/add_feedback/${id}');
     final token = await AuthService.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({'feedback': feedback});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        final error = json.decode(response.body);
        throw Exception(
            'Failed to add Feedback: ${error['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to Feedback: $e');
    }
  }

 static Future<List<dynamic>> getFeedback(int id) async {
  final response = await http.get(Uri.parse('${baseUrl}feedback/all_feedback/$id'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load feedback');
  }
}


}