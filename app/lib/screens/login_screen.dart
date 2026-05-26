import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../services/api_service.dart';
import 'admin_panel_screen.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final loginController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  void login() async {

    if (loginController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            "Заполните все поля",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    var result =
    await ApiService.loginUser(

      login: loginController.text,

      password:
      passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result["success"] != true) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            result["message"],
          ),
        ),
      );

      return;
    }

    Map user =
    result["user"];

    if (user["role"] == "admin") {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
              AdminPanelScreen(
                userData: user,
              ),
        ),
      );

    } else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
              MainScreen(
                userData: result["user"],
              )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(
            25,
          ),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              // =====================
              // LOGO
              // =====================

              const Icon(

                Icons.menu_book,

                size: 100,

                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(

                "Электронная библиотека",

                style: TextStyle(

                  fontSize: 28,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // =====================
              // LOGIN
              // =====================

              TextField(

                controller:
                loginController,

                decoration:
                InputDecoration(

                  labelText: "Логин",

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius
                        .circular(
                      15,
                    ),
                  ),

                  prefixIcon:
                  const Icon(
                    Icons.person,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =====================
              // PASSWORD
              // =====================

              TextField(

                controller:
                passwordController,

                obscureText: true,

                decoration:
                InputDecoration(

                  labelText:
                  "Пароль",

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius
                        .circular(
                      15,
                    ),
                  ),

                  prefixIcon:
                  const Icon(
                    Icons.lock,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =====================
              // LOGIN BUTTON
              // =====================

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed:
                  isLoading
                      ? null
                      : login,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color:
                    Colors.white,
                  )

                      : const Text(

                    "Войти",

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // =====================
              // REGISTER
              // =====================

              TextButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const RegisterScreen(),
                    ),
                  );
                },

                child: const Text(
                  "Нет аккаунта? Регистрация",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}