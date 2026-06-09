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

    String filePath =
        book["file_path"] ?? "";

    return Scaffold(

      appBar: AppBar(
        title: Text(
          book["title"] ?? "",
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(

                book["title"] ?? "",

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
              ),

              const SizedBox(height: 30),

              ElevatedButton(

                onPressed: () async {

                  var result =
                  await ApiService.addFavorite(

                    userId:
                    userData["id_user"]
                        .toString(),

                    bookId:
                    book["id_book"]
                        .toString(),
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context)
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

              const SizedBox(height: 20),

              if (filePath.isNotEmpty)

                SizedBox(

                  width: double.infinity,

                  child: ElevatedButton.icon(

                    icon: const Icon(
                      Icons.picture_as_pdf,
                    ),

                    label: const Text(
                      "Открыть PDF",
                    ),

                    onPressed: () {
                      openPdf(filePath);
                    },
                  ),
                )

              else

                const Text(
                  "PDF файл отсутствует",
                ),
            ],
          ),
        ),
      ),
    );
  }
}