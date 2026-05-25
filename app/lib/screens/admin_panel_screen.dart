import 'package:flutter/material.dart';

import 'add_book_screen.dart';
import 'login_screen.dart';

class AdminPanelScreen extends StatelessWidget {

  final Map userData;

  const AdminPanelScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Админ панель",
        ),

        actions: [

          IconButton(

            onPressed: () {

              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                  const LoginScreen(),
                ),

                    (route) => false,
              );
            },

            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.blue,

                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),

              child: Column(

                children: [

                  const Icon(

                    Icons.admin_panel_settings,

                    size: 80,

                    color: Colors.white,
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "Администратор",

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    userData["login"],

                    style: const TextStyle(

                      color: Colors.white70,

                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,
              height: 60,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  "Добавить книгу",
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const AddBookScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}