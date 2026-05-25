import 'package:flutter/material.dart';

import '../services/api_service.dart';

import 'book_details_screen.dart';

class HomeScreen
    extends StatefulWidget {

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

  List books = [];

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

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Библиотека"),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : ListView.builder(

        itemCount: books.length,

        itemBuilder:
            (context, index) {

          var book = books[index];

          return Card(

            margin:
            const EdgeInsets.all(
                10),

            child: ListTile(

              title: Text(
                book["title"],
              ),

              subtitle: Text(
                book["author"],
              ),

              trailing: const Icon(
                Icons.arrow_forward,
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                        BookDetailsScreen(

                          book: book,

                          userData:
                          widget
                              .userData,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}