import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final Map userData;

  const HomeScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Электронная библиотека"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Добро пожаловать, ${userData["name"]}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text("Каталог книг"),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Избранное"),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text("Рейтинг"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}