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

                return Container(

                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(

                    borderRadius:
                    BorderRadius.circular(20),

                    gradient: LinearGradient(

                      colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade700,
                      ],
                    ),
                  ),

                  child: ListTile(

                    contentPadding:
                    const EdgeInsets.all(15),

                    leading: Container(

                      width: 60,
                      height: 60,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(15),
                      ),

                      child: const Icon(
                        Icons.menu_book,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),

                    title: Text(

                      book.title,

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            book.author,

                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),

                          Text(
                            book.genre,

                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              BookDetailsScreen(

                                book: book,
                                userData:
                                widget.userData,
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