// import 'package:EnergyControl/main.dart';
// import 'package:EnergyControl/models/auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class MockClient extends Mock implements http.Client {}
//
// void main() {
//   group('registerUser', () {
//     MockClient client;
//     client = MockClient();
//
//     test('returns user ID if the http call completes successfully', () async {
//       final response = http.Response(jsonEncode({"id": "123"}), 201);
//       when(client.post(
//         Uri.parse('$apiUrl/register'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => response);
//
//       expect(await registerUser('testuser', 'password'), '123');
//     });
//
//     test('returns "Username already exists" if the username is taken', () async {
//       final response = http.Response('', 409);
//       when(client.post(
//         Uri.parse('$apiUrl/register'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => response);
//
//       expect(await registerUser('testuser', 'password'), 'Username already exists');
//     });
//
//     test('returns "Server error" if the server returns a 500', () async {
//       final response = http.Response('', 500);
//       when(client.post(
//         Uri.parse('$apiUrl/register'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => response);
//
//       expect(await registerUser('testuser', 'password'), 'Server error');
//     });
//
//     test('returns "Server error" if the http call fails', () async {
//       when(client.post(
//         Uri.parse('$apiUrl/register'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenThrow(Exception('Failed to load'));
//
//       expect(await registerUser('testuser', 'password'), 'Server error');
//     });
//   });
// }