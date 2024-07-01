import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsService {
  static Future<List<dynamic>> getEvents() async {
    final response = await http.get(Uri.parse('${baseUrl}events/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['events']; 
    } else {
      throw Exception('Failed to load events');
    }
  }

  static Future<Map<String, dynamic>> getEvent(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}event/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['event'];
    } else {
      throw Exception('Event not found');
    }
  }
}

