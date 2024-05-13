import 'package:flutter/material.dart';
import '../models/auth.dart';
import 'login.dart';

void showSnack({required String text, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

Future<void> register(
    {required String name,
    required String password,
    required BuildContext context,
    required Function update}) async {
  if (name == "" || password == "") {
    showSnack(text: "Введите имя и пароль.", context: context);
    return;
  }
  String response = await registerUser(name, password);
  if (response == "Username already exists") {
    showSnack(text: "Имя пользователя уже занято.", context: context);
    return;
  }
  if (response == "Server error") {
    showSnack(text: "Ошибка.Попробуйте позже.", context: context);
    return;
  }
  saveUserId(response);
  update();
}

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.update});

  Function update;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                  child: Text('Добро пожаловать в ЭнергоКонтроль!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              const Text('Регистрация', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Имя',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => register(
                    name: nameController.text,
                    password: passwordController.text,
                    context: context,
                    update: update),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(88, 44), // Specific size
                ),
                child: const Text('Зарегистрироваться'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage(
                            update: update,
                          )));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(88, 44), // Specific size
                ),
                child: const Text('У меня уже есть аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
