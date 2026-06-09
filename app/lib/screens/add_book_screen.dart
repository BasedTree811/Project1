import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() =>
      _AddBookScreenState();
}

class _AddBookScreenState
    extends State<AddBookScreen> {

  final titleController =
  TextEditingController();

  final authorController =
  TextEditingController();

  final genreController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final pdfController =
  TextEditingController();

  bool isLoading = false;

  Future addBook() async {

    if (titleController.text.isEmpty ||
        authorController.text.isEmpty ||
        genreController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        pdfController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Заполните все поля"),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    var result =
    await ApiService.addBook(

      title: titleController.text,

      author: authorController.text,

      genre: genreController.text,

      description:
      descriptionController.text,

      filePath: pdfController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result["success"] == true) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Книга добавлена"),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            result["message"]
                ?.toString() ??
                "Ошибка",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Добавить книгу"),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller:
              titleController,
              decoration:
              const InputDecoration(
                labelText:
                "Название",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              authorController,
              decoration:
              const InputDecoration(
                labelText:
                "Автор",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              genreController,
              decoration:
              const InputDecoration(
                labelText:
                "Жанр",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              descriptionController,
              maxLines: 4,
              decoration:
              const InputDecoration(
                labelText:
                "Описание",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              pdfController,
              decoration:
              const InputDecoration(
                labelText:
                "Ссылка на PDF",
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed:
                isLoading
                    ? null
                    : addBook,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                  "Добавить книгу",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}