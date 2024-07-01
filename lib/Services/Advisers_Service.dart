import 'dart:ffi';

import '../api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdvisersService {
  static Future<List<dynamic>> getAdvisers() async {
    final reseponse = await http.get(Uri.parse('${baseUrl}advisers/'));
    if (reseponse.statusCode == 200) {
      final data = json.decode(reseponse.body);
      return data['advisers'];
    } else {
      throw('Advisers not found');
    }
  }

   static Future<int> count_Appointment(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}count/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['count'];
    } else {
      throw Exception('Failed to load appointment count');
    }
  }

static Future<Map<String, dynamic>> getAdvise(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}advise/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['advise'];
    } else {
      throw Exception('Advise not found');
    }
  }

}
