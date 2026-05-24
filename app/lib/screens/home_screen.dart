import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/api_service.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatefulWidget {

  final Map userData;

  const HomeScreen({
    super.key,
    required this.userData,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  List<Book> books = [];
  List<Book> filteredBooks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadBooks();
  }

  void loadBooks() async {

    books = await ApiService.getBooks();

    filteredBooks = books;

    setState(() {
      isLoading = false;
    });
  }

  void searchBooks(String query) {

    filteredBooks = books.where((book) {

      return book.title
          .toLowerCase()
          .contains(
        query.toLowerCase(),
      ) ||
          book.author
              .toLowerCase()
              .contains(
            query.toLowerCase(),
          );

    }).toList();

    setState(() {});
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

          : Column(
        children: [

          Padding(
            padding:
            const EdgeInsets.all(15),

            child: TextField(

              onChanged: searchBooks,

              decoration:
              InputDecoration(

                hintText:
                "Поиск книг...",

                prefixIcon:
                const Icon(
                  Icons.search,
                ),

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(

              itemCount:
              filteredBooks.length,

              itemBuilder:
                  (context, index) {

                Book book =
                filteredBooks[index];

                return Card(

                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  child: ListTile(

                    leading: const Icon(
                      Icons.book,
                      size: 40,
                    ),

                    title:
                    Text(book.title),

                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Text(
                          book.author,
                        ),

                        Text(
                          book.genre,
                        ),
                      ],
                    ),

                    trailing:
                    const Icon(
                      Icons
                          .arrow_forward_ios,
                    ),

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              BookDetailsScreen(
                                book: book,
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}