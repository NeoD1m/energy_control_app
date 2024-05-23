import 'package:flutter/material.dart';
import '../models/downloaded_file.dart';
import '../models/downloads.dart';
import '../widgets/local_file_viewer.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  late Future<List<DownloadedFile>> _downloadedFilesFuture;

  @override
  void initState() {
    super.initState();
    _downloadedFilesFuture = getDownloadedFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Загрузки"),
      ),
      body: FutureBuilder<List<DownloadedFile>>(
        future: _downloadedFilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет загрузок.'));
          } else {
            final downloadedFiles = snapshot.data!;
            return ListView.builder(
              itemCount: downloadedFiles.length,
              itemBuilder: (context, index) {
                final file = downloadedFiles[index];
                return DownloadedTopicWidget(
                  pdfId: file.id,
                  title: file.title,
                  path: file.path,
                  isDownloaded: true,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DownloadedTopicWidget extends StatefulWidget {
  DownloadedTopicWidget(
      {super.key,
      required this.pdfId,
      required this.title,
      required this.path,
      required this.isDownloaded});

  int pdfId;
  String title;
  String path;
  bool isDownloaded;

  @override
  State<DownloadedTopicWidget> createState() => _DownloadedTopicWidgetState();
}

class _DownloadedTopicWidgetState extends State<DownloadedTopicWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DownloadedFileViewerWidget(
                              localFilePath: widget.path,
                            )))
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8, bottom: 8),
                    backgroundColor: Theme.of(context).canvasColor,
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.title,
                          style: const TextStyle(fontSize: 14.0))),
                ),
              ),
              IconButton(
                icon: Icon(
                  widget.isDownloaded
                      ? Icons.delete_forever
                      : Icons.download_outlined,
                  color: widget.isDownloaded
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Colors.grey,
                ),
                onPressed: () {
                  if (widget.isDownloaded) {
                    deleteDownloadedFile(widget.pdfId);
                  } else {
                    downloadAndSavePdf(
                        id: widget.pdfId, title: widget.title, type: '');
                  }
                  setState(() {
                    widget.isDownloaded = !widget.isDownloaded;
                  });
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }
}
