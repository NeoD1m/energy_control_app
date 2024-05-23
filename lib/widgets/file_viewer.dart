import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../main.dart';

class FileViewerWidget extends StatelessWidget {
  const FileViewerWidget({super.key, required this.pdfId});

  final int pdfId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.network(
        '$apiUrl/files/$pdfId',
      ),
    );
  }
}
