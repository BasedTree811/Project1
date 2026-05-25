import 'package:flutter/material.dart';

import '../services/api_service.dart';

class BookDetailsScreen extends StatelessWidget {

  final dynamic book;

  final Map userData;

  const BookDetailsScreen({

    super.key,

    required this.book,

    required this.userData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(book["title"]),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(

              book["title"],

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Автор: ${book["author"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Жанр: ${book["genre"]}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              book["description"] ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () async {

                var result =
                await ApiService
                    .addFavorite(

                  userId:
                  userData["id"]
                      .toString(),

                  bookId:
                  book["id"]
                      .toString(),
                );

                if (!context.mounted) {
                  return;
                }

                ScaffoldMessenger.of(
                    context)
                    .showSnackBar(

                  SnackBar(

                    content: Text(

                      result["message"] ??
                          "Добавлено в избранное",
                    ),
                  ),
                );
              },

              child: const Text(
                "В избранное",
              ),
            ),
          ],
        ),
      ),
    );
  }
}