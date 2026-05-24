import 'package:flutter/material.dart';

import 'add_book_screen.dart';

class AdminScreen extends StatelessWidget {

  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Админ панель",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

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