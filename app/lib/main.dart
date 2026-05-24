import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp
    extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:
      false,

      themeMode: ThemeMode.dark,

      darkTheme: ThemeData.dark().copyWith(

        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),

        elevatedButtonTheme:
        ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(
            minimumSize:
            const Size.fromHeight(
              55,
            ),
          ),
        ),
      ),

      home: const LoginScreen(),
    );
  }
}