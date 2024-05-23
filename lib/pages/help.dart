import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Помощь"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Как мне сохранить документ чтобы не потерять его в будущем?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                  'Нажмите на звездочку рядом с документом и он будет добавлен в Ваши закладки.'),
              const SizedBox(height: 30.0),
              const Text(
                'Что мне делать если Я не уверен как трактовать правовой документ?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                  'Напишите нам на электронную почту или в телеграм, наши специалисты всегда готовы помочь!'),
              const SizedBox(height: 30.0),
              const Text(
                'Что делать если Я потерял документ и не добавлял его в закладки?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                  'Для поиска требуемого документа, пожалуйста, перейдите во вкладку "Поиск" и введите название документа.'),
              const SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 8, bottom: 8),
                        backgroundColor: Colors.grey,
                        primary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () => launchMailClient(),
                      child: const Text('Почта'),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 8, bottom: 8),
                        backgroundColor: Colors.lightBlue,
                        primary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () => launchTelegram(),
                      child: const Text('Телеграм'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Future<void> launchMailClient() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: "dmitrydavydovv@gmail.com",
    queryParameters: {'subject': '', 'body': ''},
  );
  launchUrl(emailLaunchUri);
}

Future<void> launchTelegram() async {
  final Uri url = Uri.parse('https://t.me/neod1m');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
