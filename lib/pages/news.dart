import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/auth.dart';
import '../widgets/topic_list.dart';
import '../widgets/topic.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Новости"),
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
  await http.get(Uri.parse('$apiUrl/files?type=news&userId=$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Topic.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load topics');
  }
}
