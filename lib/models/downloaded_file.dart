import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadedFile {
  DownloadedFile({
    required this.id,
    required this.title,
    required this.type,
    required this.path,
  });

  int id;
  String title;
  String type;
  String path;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'path': path,
      };

  factory DownloadedFile.fromJson(Map<String, dynamic> json) => DownloadedFile(
        id: json['id'],
        title: json['title'],
        type: json['type'],
        path: json['path'],
      );
}

Future<void> saveDownloadedFiles(List<DownloadedFile> files) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> jsonList =
      files.map((file) => jsonEncode(file.toJson())).toList();
  prefs.setStringList('downloaded_files', jsonList);
}

Future<List<DownloadedFile>> getDownloadedFiles() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonList = prefs.getStringList('downloaded_files');
  if (jsonList != null) {
    return jsonList
        .map((jsonString) => DownloadedFile.fromJson(jsonDecode(jsonString)))
        .toList();
  } else {
    return [];
  }
}

Future<void> addDownloadedFile(DownloadedFile file) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonList = prefs.getStringList('downloaded_files');

  if (jsonList != null) {
    List<DownloadedFile> files = jsonList
        .map((jsonString) => DownloadedFile.fromJson(jsonDecode(jsonString)))
        .toList();

    bool fileExists = files.any((existingFile) => existingFile.id == file.id);

    if (!fileExists) {
      files.add(file);
      List<String> updatedJsonList =
          files.map((file) => jsonEncode(file.toJson())).toList();
      prefs.setStringList('downloaded_files', updatedJsonList);
    }
  } else {
    prefs.setStringList('downloaded_files', [jsonEncode(file.toJson())]);
  }
}

Future<bool> isDownloaded(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonList = prefs.getStringList('downloaded_files');

  if (jsonList != null) {
    List<DownloadedFile> files = jsonList
        .map((jsonString) => DownloadedFile.fromJson(jsonDecode(jsonString)))
        .toList();

    return files.any((file) => file.id == id);
  }

  return false;
}

Future<void> deleteDownloadedFile(int fileId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonList = prefs.getStringList('downloaded_files');

  if (jsonList != null) {
    List<DownloadedFile> files = jsonList
        .map((jsonString) => DownloadedFile.fromJson(jsonDecode(jsonString)))
        .toList();

    files.removeWhere((file) => file.id == fileId);

    List<String> updatedJsonList =
        files.map((file) => jsonEncode(file.toJson())).toList();
    prefs.setStringList('downloaded_files', updatedJsonList);
  }
}
