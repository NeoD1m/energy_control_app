import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../main.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DownloadedFileViewerWidget extends StatefulWidget {
  const DownloadedFileViewerWidget({super.key, required this.localFilePath});
  final String localFilePath;

  @override
  _DownloadedFileViewerWidgetState createState() => _DownloadedFileViewerWidgetState();
}

class _DownloadedFileViewerWidgetState extends State<DownloadedFileViewerWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PDFView(
        filePath: widget.localFilePath,
      ),
    );
  }
}