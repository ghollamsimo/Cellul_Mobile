import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CalendarService {
  static Future<List<Map<String, dynamic>>> getCalendar(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}all_calendar/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['calendar']);
    } else {
      throw ('Calendar not found');
    }
  }
}
