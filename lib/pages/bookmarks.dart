import 'dart:convert';

import 'package:flutter/material.dart';
import '../main.dart';
import '../models/auth.dart';
import '../widgets/topic.dart';
import '../widgets/topic_list.dart';
import 'package:http/http.dart' as http;

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Закладки"),
      ),
        body: Scaffold(
          body: TopicList(
            fetch: fetchTopics,
          ),
        ));
  }
}

Future<List<Topic>> fetchTopics() async {
  String userId = await getUserId()??"";
  final response =
  await http.get(Uri.parse('$apiUrl/favourites/$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Topic.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load topics');
  }
}
