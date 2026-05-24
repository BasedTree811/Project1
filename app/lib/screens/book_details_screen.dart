import 'package:flutter/material.dart';

import '../models/book.dart';

class BookDetailsScreen extends StatelessWidget {

  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(book.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Center(
              child: Icon(
                Icons.menu_book,
                size: 120,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              book.title,

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Автор: ${book.author}",

              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Жанр: ${book.genre}",

              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Описание",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book.description,

              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                onPressed: () {},

                icon: const Icon(Icons.book),

                label: const Text(
                  "Читать книгу",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}