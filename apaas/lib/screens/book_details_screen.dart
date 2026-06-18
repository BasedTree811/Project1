import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class BookDetailsScreen extends StatelessWidget {
  final dynamic book;
  final Map userData;

  const BookDetailsScreen({
    super.key,
    required this.book,
    required this.userData,
  });

  Future<void> openPdf(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Безопасное извлечение данных
    final title = book["title"]?.toString() ?? "Без названия";
    final author = book["author"]?.toString() ?? "Неизвестный автор";
    final genre = book["genre"]?.toString() ?? "Не указан";
    final description = book["description"]?.toString() ?? "Описание отсутствует";
    final filePath = book["file_path"]?.toString() ?? "";

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // единый фон

      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Основная карточка с информацией ---
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок книги
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Автор
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          "Автор: $author",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Жанр
                    Row(
                      children: [
                        const Icon(Icons.category, size: 20, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          "Жанр: $genre",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Разделитель
                    const Divider(color: Colors.grey, thickness: 1),

                    const SizedBox(height: 16),

                    // Описание с заголовком
                    const Text(
                      "Описание",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Кнопка "В избранное" (стилизованная под акцент) ---
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.favorite_border, size: 26),
                label: const Text(
                  "В избранное",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  final result = await ApiService.addFavorite(
                    userId: userData["id"]?.toString() ?? userData["id_user"]?.toString() ?? "",
                    bookId: book["id_book"]?.toString() ?? "",
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result["message"] ?? "Добавлено в избранное"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.pinkAccent.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- Кнопка "Открыть PDF" (если файл есть) ---
            if (filePath.isNotEmpty)
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf, size: 26),
                  label: const Text(
                    "Открыть PDF",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    await ApiService.addHistory(
                      userId: userData["id_user"]?.toString() ?? userData["id"]?.toString() ?? "",
                      bookId: book["id_book"]?.toString() ?? "",
                    );
                    openPdf(filePath);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    elevation: 6,
                    shadowColor: Colors.deepPurple.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            else
            // Если PDF отсутствует – показываем информативный блок
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.grey.shade700),
                    const SizedBox(width: 10),
                    Text(
                      "PDF файл отсутствует",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}