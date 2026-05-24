import 'package:flutter/material.dart';

import '../services/api_service.dart';

class RegisterScreen
    extends StatefulWidget {

  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen>
  createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final surnameController =
  TextEditingController();

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final loginController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  void register() async {

    setState(() {
      isLoading = true;
    });

    var result =
    await ApiService.registerUser(

      surname:
      surnameController.text,

      name:
      nameController.text,

      email:
      emailController.text,

      login:
      loginController.text,

      password:
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          result["message"],
        ),
      ),
    );

    if(result["success"] == true) {

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Регистрация",
        ),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller:
              surnameController,

              decoration:
              const InputDecoration(
                labelText:
                "Фамилия",
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
              nameController,

              decoration:
              const InputDecoration(
                labelText: "Имя",
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
              emailController,

              decoration:
              const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
              loginController,

              decoration:
              const InputDecoration(
                labelText: "Логин",
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
              passwordController,

              obscureText: true,

              decoration:
              const InputDecoration(
                labelText: "Пароль",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed:
                isLoading
                    ? null
                    : register,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                  "Зарегистрироваться",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}