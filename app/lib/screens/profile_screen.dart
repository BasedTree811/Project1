import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'history_screen.dart';
import 'login_screen.dart';
import 'rating_screen.dart';

class ProfileScreen extends StatelessWidget {

  final Map userData;

  const ProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Профиль",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // =====================
            // AVATAR
            // =====================

            Center(

              child: Container(

                width: 120,
                height: 120,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  gradient: LinearGradient(

                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade800,
                    ],
                  ),
                ),

                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =====================
            // USER INFO
            // =====================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.grey.shade900,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    "Имя: ${userData["name"]}",

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "Email: ${userData["email"]}",

                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "Логин: ${userData["login"]}",

                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "Рейтинг: ${userData["rating"] ?? "0"}",

                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // =====================
            // BUTTONS
            // =====================

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.history,
                ),

                label: const Text(
                  "История чтения",
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const HistoryScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.leaderboard,
                ),

                label: const Text(
                  "Рейтинг читателей",
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const RatingScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.chat,
                ),

                label: const Text(
                  "Чат с библиотекарем",
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          ChatScreen(
                            userData: userData,
                          ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // =====================
            // LOGOUT
            // =====================

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  "Выйти",
                ),

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.red,
                ),

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
              ),
            ),
          ],
        ),
      ),
    );
  }
}