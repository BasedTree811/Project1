import 'package:flutter/material.dart';

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
        title: const Text("Профиль"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Имя: ${userData["name"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Email: ${userData["email"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Логин: ${userData["login"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}