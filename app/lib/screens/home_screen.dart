import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {

  final Map userData;

  const HomeScreen({
    super.key,
    required this.userData,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Book> books = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadBooks();
  }

  void loadBooks() async {

    books = await ApiService.getBooks();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Электронная библиотека",
        ),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : ListView.builder(

        itemCount: books.length,

        itemBuilder: (context, index) {

          Book book = books[index];

          return Card(

            margin: const EdgeInsets.all(10),

            child: ListTile(

              leading: const Icon(
                Icons.book,
                size: 40,
              ),

              title: Text(book.title),

              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(book.author),

                  Text(book.genre),
                ],
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          );
        },
      ),
    );
  }
}