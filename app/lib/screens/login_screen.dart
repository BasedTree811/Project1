import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void login() async {

    try {

      setState(() {
        isLoading = true;
      });

      var result = await ApiService.loginUser(
        login: loginController.text,
        password: passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      print(result);

      if (result["success"] == true) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(
              userData: result["user"],
            ),
          ),
        );

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"]),
          ),
        );
      }

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Ошибка подключения к серверу",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Авторизация"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 30),

            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                labelText: "Логин",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Пароль",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: isLoading ? null : login,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Войти"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}