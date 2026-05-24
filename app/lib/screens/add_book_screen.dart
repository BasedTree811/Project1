import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
File? selectedPdf;
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

  void addBook() async {

    setState(() {
      isLoading = true;
    });
    void pickPdf() async {

      FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {

        selectedPdf = File(
          result.files.single.path!,
        );

        setState(() {});
      }
    }
    String pdfUrl = '';

    if (selectedPdf != null) {

      var uploadResult =
      await ApiService.uploadPdf(
        selectedPdf!,
      );

      if (uploadResult["success"] == true) {

        pdfUrl =
        uploadResult["file_path"];
      }
    }

    var result =
    await ApiService.addBook(

      title: titleController.text,

      author: authorController.text,

      genre: genreController.text,

      description:
      descriptionController.text,

      filePath: pdfUrl,
    );

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          result["message"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Добавление книги",
        ),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,

              decoration:
              const InputDecoration(
                labelText:
                "Название книги",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              authorController,

              decoration:
              const InputDecoration(
                labelText: "Автор",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              genreController,

              decoration:
              const InputDecoration(
                labelText: "Жанр",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              descriptionController,

              maxLines: 5,

              decoration:
              const InputDecoration(
                labelText:
                "Описание",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: pdfController,

              decoration:
              const InputDecoration(
                labelText:
                "Ссылка на PDF",
              ),
            ),

            const SizedBox(height: 30),

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