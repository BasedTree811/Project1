import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/api_service.dart';

class BookDetailsScreen extends StatelessWidget {

  final Book book;
  final Map userData;

  const BookDetailsScreen({
    super.key,
    required this.book,
    required this.userData,
  });

  Future addFavorite(
      BuildContext context,
      ) async {

    var result = await ApiService.addFavorite(

      idUser: userData["id_user"],
      idBook: book.id,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(book.title),
      ),

      floatingActionButton:
      FloatingActionButton(

        onPressed: () {
          addFavorite(context);
        },

        child: const Icon(
          Icons.favorite,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Center(
              child: Container(

                width: 140,
                height: 180,

                decoration: BoxDecoration(
                  color: Colors.blue.shade100,

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: const Icon(
                  Icons.menu_book,
                  size: 90,
                ),
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

            const SizedBox(height: 15),

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
                height: 1.5,
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