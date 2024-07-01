import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pr/Screen/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';

class AuthService {
  static Future<Map<String, dynamic>> register(
      String name, String password, String email, String role) async {
    final url = Uri.parse('${baseUrl}auth/register/');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'name': name,
      'password': password,
      'email': email,
      'role': role,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception(
            'Failed to register: ${error['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  static Future<Map<String, dynamic>> getProtectedData() async {
    final url = Uri.parse('${baseUrl}protected/data/');
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception(
            'Failed to get data: ${error['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  static Future<Map<String, dynamic>> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('${baseUrl}auth/login/');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        await _saveToken(responseData['token']);

        final user = responseData['user'];
        if (user == null || user['id'] == null) {
          throw Exception('User ID is missing in the response');
        }

        final id = user['id'];
        print('User ID: $id'); // For debugging purposes

        // Fetch user details

        return responseData;
      } else {
        final error = json.decode(response.body);
        throw Exception(
            'Failed to login: ${error['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<Map<String, dynamic>> getUser(int? id) async {
    final response = await http.get(Uri.parse('${baseUrl}auth/get_user/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('User not found');
    }
  }

   static Future<Map<String, dynamic>> changePassword(String password) async {
    final token = await AuthService.getToken();
    final url = Uri.parse('${baseUrl}auth/change_password/');
    
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    
    final body = json.encode({
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to change password: ${response.reasonPhrase}');
    }
  }
}
