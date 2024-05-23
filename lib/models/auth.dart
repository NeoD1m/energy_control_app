import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

Future<void> saveUserId(String userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String?> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

Future<void> deleteUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}

Future<bool> userIdExists() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('userId');
}

Future<String> registerUser(String name, String password) async {
  String url = '$apiUrl/auth/register';
  var response;
  try {
    response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "password": password,
      }),
    );
  } catch (e) {}
  if (response.statusCode == 201) {
    final responseBody = jsonDecode(response.body);
    return responseBody["id"].toString();
  }
  if (response.statusCode == 409) {
    return "Username already exists";
  }
  if (response.statusCode == 500) {
    return "Server error";
  }
  return "Server error";
}

Future<String> loginUser(String name, String password) async {
  String url = '$apiUrl/auth/login';
  var response;
  try {
    response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'password': password,
      }),
    );
  } catch (e) {}
  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody["id"].toString();
  }
  if (response.statusCode == 401) {
    return "Invalid credentials";
  }
  if (response.statusCode == 500) {
    return "Server error";
  }
  return "Server error";
}
