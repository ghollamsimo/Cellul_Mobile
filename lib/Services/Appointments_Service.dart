import 'dart:convert';
import 'package:flutter_pr/Services/Auth_Service.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';

class AppointmentsService{
  static Future<Map<String, dynamic>> getAppointment() async {
    final url = await Uri.parse('${baseUrl}appointment_get/appointment');
    final token = await AuthService.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

     if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Appointment not found');
    }
  }
}