import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/auth.dart';
import '../widgets/topic_list.dart';
import '../widgets/topic.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Частые ошибки"),
        ),
        body: Scaffold(
          body: TopicList(
            fetch: fetchTopics,
          ),
        ));
  }
}

Future<List<Topic>> fetchTopics() async {
  String userId = await getUserId() ?? "";
  final response =
      await http.get(Uri.parse('$apiUrl/files?type=info&userId=$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Topic.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load topics');
  }
}
