import 'package:EnergyControl/models/auth.dart';
import 'package:EnergyControl/pages/home.dart';
import 'package:EnergyControl/pages/register.dart';
import 'package:flutter/material.dart';

const String apiUrl = "http://neodim.fun";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЭнергоКонтроль',
      theme: ThemeData.dark(useMaterial3: true),
      home: FutureBuilder<bool>(
        future: userIdExists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return HomePage(
                key: homePageKey,
                update: update,
              );
            } else {
              return RegisterPage(
                update: update,
              );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
