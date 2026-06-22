import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'book_details_screen.dart';
import 'edit_book_screen.dart';

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
  List<Book> filteredBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    var data = await ApiService.getBooks();
    setState(() {
      books = data;
      filteredBooks = data;
      isLoading = false;
    });
  }

  void searchBooks(String query) {
    final results = books.where((book) {
      final title = book.title.toLowerCase();
      final author = book.author.toLowerCase();
      final genre = book.genre.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input) ||
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
      backgroundColor: Colors.grey.shade50, // светлый фон

      appBar: AppBar(
        title: const Text(
          "Электронная библиотека",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      )
          : Column(
        children: [
          // Поле поиска
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: searchBooks,
              decoration: InputDecoration(
                hintText: "Поиск книг...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),

          // Список книг
          Expanded(
            child: filteredBooks.isEmpty
                ? const Center(
              child: Text(
                "Ничего не найдено",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                final isAdmin = widget.userData["role"] == "admin";

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailsScreen(
                            book: {
                              "id_book": book.id,
                              "title": book.title,
                              "author": book.author,
                              "genre": book.genre,
                              "description": book.description,
                              "file_path": book.filePath,
                            },
                            userData: widget.userData,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Иконка книги
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.book,
                              color: Colors.deepPurple,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Информация о книге
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.author,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  book.genre,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade500,
                                    fontStyle: FontStyle.italic,
                                   ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Действия справа (админ или обычный пользователь)
                          if (isAdmin)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.deepPurple),
                                  onPressed: () async {
                                    final updated = await Navigator.push<bool>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditBookScreen(book: book),
                                      ),
                                    );
                                    if (updated == true) {
                                      loadBooks();
                                    }
                                  },
                                  splashRadius: 24,
                                ),
                                // Кнопка удаления
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () async {
                                    await ApiService.deleteBook(id: book.id);
                                    loadBooks();
                                  },
                                  splashRadius: 24,
                                ),
                              ],
                            )
                          else
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 18,
                            ),
                        ],
                      ),
                    ),
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