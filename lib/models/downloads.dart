import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../main.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'downloaded_file.dart';


Future<void> downloadAndSavePdf({required int id,required String? title,required String? type}) async {
  print("start");
  try {
    final dio = Dio();
    final response = await dio.get(
      '$apiUrl/file/$id',
      options: Options(responseType: ResponseType.bytes),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$id.pdf');
    await file.writeAsBytes(response.data);

    // Create DownloadedFile object
    final downloadedFile = DownloadedFile(
      id: id,
      title: title??'TODO: Add title', // TODO: Add the title of the PDF
      type: type??'TODO: Add type', // TODO: Add the type of the PDF
      path: file.path,
    );

    // Add to the list of downloaded files
    await addDownloadedFile(downloadedFile);

  } catch (e) {
    // Handle error
    print("Error downloading PDF: $e");
  }
}