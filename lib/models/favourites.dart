import 'dart:convert';
import 'package:EnergyControl/main.dart';
import 'package:EnergyControl/models/auth.dart';
import 'package:http/http.dart' as http;

Future<void> addToFavorites({required int fileId}) async {
  String userId = await getUserId() ?? "";

  final url = Uri.parse('$apiUrl/favourites/add');
  final headers = {"Content-Type": "application/json"};
  final body = json.encode({
    "userId": userId,
    "fileId": fileId,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print("PDF added to favorites successfully");
    } else {
      print("Failed to add PDF to favorites");
    }
  } catch (e) {
    print("Error adding PDF to favorites: $e");
  }
}

Future<void> removeFromFavorites({required int fileId}) async {
  String userId = await getUserId() ?? "";
  final String url = '$apiUrl/favorites/$userId/$fileId';

  try {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print('File removed from favorites successfully');
    } else if (response.statusCode == 404) {
      print('File not found in favorites');
    } else {
      print('Failed to delete the file from favorites');
    }
  } catch (e) {
    print('Error occurred while trying to delete the file from favorites: $e');
  }
}
