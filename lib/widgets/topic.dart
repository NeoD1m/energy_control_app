import 'package:EnergyControl/models/downloaded_file.dart';
import 'package:EnergyControl/widgets/file_viewer.dart';
import 'package:flutter/material.dart';
import '../models/downloads.dart';
import '../models/favourites.dart';

class Topic {
  Topic({required this.id, required this.title, this.isFavourite = false});

  final int id;
  final String title;
  final bool isFavourite;

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      isFavourite: json['is_favourite'] ?? false,
    );
  }
}

class TopicWidget extends StatefulWidget {
  TopicWidget(
      {super.key,
      required this.pdfId,
      required this.title,
      required this.isFavourite,
      required this.isDownloaded});

  int pdfId;
  String title;
  bool isFavourite;
  bool isDownloaded;

  @override
  State<TopicWidget> createState() => _TopicWidgetState();
}

class _TopicWidgetState extends State<TopicWidget> {
  void setFavourite(bool isFavourite) {
    setState(() {
      if (isFavourite) {
        addToFavorites(fileId: widget.pdfId);
      } else {
        removeFromFavorites(fileId: widget.pdfId);
      }
      widget.isFavourite = isFavourite;
    });
  }

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
                        builder: (context) => FileViewerWidget(
                              pdfId: widget.pdfId,
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
              IconButton(
                icon: Icon(
                  widget.isFavourite ? Icons.star : Icons.star_border,
                  color: widget.isFavourite ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  setFavourite(!widget.isFavourite);
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
