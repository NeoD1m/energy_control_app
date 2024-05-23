import 'package:EnergyControl/widgets/topic.dart';
import 'package:flutter/material.dart';
import '../models/downloaded_file.dart';
import 'no_internet_button.dart';

class TopicList extends StatelessWidget {
  TopicList({super.key, required this.fetch});

  final Future<List<Topic>> Function() fetch;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: NoInternetButton());
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((topic) {
                return FutureBuilder<bool>(
                  future: isDownloaded(topic.id),
                  builder: (context, isDownloadedSnapshot) {
                    if (isDownloadedSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (isDownloadedSnapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (isDownloadedSnapshot.hasData) {
                      return TopicWidget(
                        pdfId: topic.id,
                        title: topic.title,
                        isFavourite: topic.isFavourite,
                        isDownloaded: isDownloadedSnapshot.data!,
                      );
                    } else {
                      return const Center(child: Text('Ошибка'));
                    }
                  },
                );
              }).toList(),
            ),
          );
        } else {
          return const Center(child: Text('Ошибка'));
        }
      },
    );
  }
}
