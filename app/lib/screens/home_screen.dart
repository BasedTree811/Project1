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

  Future<void> loadBooks() async {

    var data =
    await ApiService.getBooks();

    setState(() {

      books = data;

      filteredBooks = data;

      isLoading = false;
    });
  }

  void searchBooks(String query) {

    final results = books.where((book) {

      final title =
      book.title.toLowerCase();

      final author =
      book.author.toLowerCase();

      final genre =
      book.genre.toLowerCase();

      final input =
      query.toLowerCase();

      return
        title.contains(input) ||
            author.contains(input) ||
            genre.contains(input);

    }).toList();

    setState(() {

      filteredBooks = results;
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
        child:
        CircularProgressIndicator(),
      )

          : Column(

        children: [

          Padding(

            padding:
            const EdgeInsets.all(10),

            child: TextField(

              onChanged: searchBooks,

              decoration:
              InputDecoration(

                hintText:
                "Поиск книг...",

                prefixIcon:
                const Icon(Icons.search),

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(12),
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

                final book =
                filteredBooks[index];

                return Card(

                  margin:
                  const EdgeInsets.all(10),

                  child: ListTile(
                    trailing:
                    widget.userData["role"] == "admin"

                        ? Row(

                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        IconButton(

                          icon: const Icon(
                            Icons.edit,
                          ),

                          onPressed: () {

                          },
                        ),

                        IconButton(

                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () async {

                            await ApiService.deleteBook(
                              id: book.id,
                            );

                            loadBooks();
                          },
                        ),
                      ],
                    )

                        : const Icon(
                      Icons.arrow_forward_ios,
                    ),

                    title:
                    Text(book.title),

                    subtitle: Text(
                      "${book.author}\n${book.genre}",
                    ),

                    isThreeLine: true,




                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              BookDetailsScreen(

                                book: {
                                  "id_book":
                                  book.id,

                                  "title":
                                  book.title,

                                  "author":
                                  book.author,

                                  "genre":
                                  book.genre,

                                  "description":
                                  book.description,

                                  "file_path":
                                  book.filePath,
                                },

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