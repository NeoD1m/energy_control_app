import 'package:EnergyControl/widgets/topic.dart';
import 'package:flutter/material.dart';

class TopicList extends StatelessWidget {
  TopicList({super.key, required this.fetch});
  Function fetch;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!
                  .map((topic) => TopicWidget(
                        pdfId: topic.id,
                        title: topic.title,
                        isFavourite: topic.isFavourite,
                      ))
                  .toList(),
            ),
          );
        } else {
          return const Center(child: Text('Ошибка'));
        }
      },
    );
  }
}
