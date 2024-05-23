import 'package:EnergyControl/models/auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/downloaded_file.dart';
import '../widgets/topic.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = "";

  void update(String newSearch) {
    setState(() {
      searchQuery = newSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Поиск"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Search(
                update: update,
              ),
              searchQuery == ""
                  ? Container()
                  : TopicList(
                      searchQuery: searchQuery,
                    )
            ],
          ),
        ));
  }
}

class Search extends StatelessWidget {
  Search({super.key, required this.update});

  final TextEditingController _controller = TextEditingController();
  Function update;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Поиск',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              height: 50,
              width: 50,
              child: ElevatedButton(
                onPressed: () {
                  update(_controller.text);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(Icons.search),
              ),
            ),
          ],
        ));
  }
}

class TopicList extends StatelessWidget {
  TopicList({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: fetchTopics(searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
                      return Center(
                          child: Text('Error: ${isDownloadedSnapshot.error}'));
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
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}

Future<List<Topic>> fetchTopics(String searchQuery) async {
  String userId = await getUserId() ?? "";
  final response = await http.post(
    Uri.parse('$apiUrl/search'),
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "searchQuery": searchQuery,
      "userId": userId
    }), // Include userId in the request
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Topic.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load topics');
  }
}
