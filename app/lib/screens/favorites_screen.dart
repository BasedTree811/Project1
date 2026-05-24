import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/api_service.dart';

class FavoritesScreen extends StatefulWidget {

  final Map userData;

  const FavoritesScreen({
    super.key,
    required this.userData,
  });

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {

  List<Book> books = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadFavorites();
  }

  void loadFavorites() async {

    books = await ApiService.getFavorites(
      widget.userData["id_user"],
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Избранное",
        ),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : books.isEmpty

          ? const Center(
        child: Text(
          "Избранных книг нет",
        ),
      )

          : ListView.builder(

        itemCount: books.length,

        itemBuilder:
            (context, index) {

          Book book = books[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),

              title:
              Text(book.title),

              subtitle:
              Text(book.author),
            ),
          );
        },
      ),
    );
  }
}