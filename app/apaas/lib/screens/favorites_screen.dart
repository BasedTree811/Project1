import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FavoritesScreen extends StatefulWidget {
  final Map userData;

  const FavoritesScreen({
    super.key,
    required this.userData,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    var data = await ApiService.getFavorites(
      userId: widget.userData["id_user"].toString(),
    );

    setState(() {
      favorites = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // светлый фон

      appBar: AppBar(
        title: const Text(
          "Избранное",
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
          : favorites.isEmpty
          ? const Center(
        child: Text(
          "Избранное пусто",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          var book = favorites[index];
          final title = book["title"]?.toString() ?? "Без названия";
          final author = book["author"]?.toString() ?? "Неизвестный автор";

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Иконка книги в кружке
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Текст
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
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
                          author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}