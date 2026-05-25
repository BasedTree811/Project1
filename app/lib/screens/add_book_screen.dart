import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AddBookScreen extends StatefulWidget {

  const AddBookScreen({
    super.key,
  });

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

  Uint8List? pdfBytes;

  String pdfName = "";

  bool isLoading = false;

  // =========================
  // PICK PDF
  // =========================

  Future pickPdf() async {

    FilePickerResult? result =
    await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: ['pdf'],

      withData: true,
    );

    if (result != null) {

      setState(() {

        pdfBytes =
            result.files.first.bytes;

        pdfName =
            result.files.first.name;
      });
    }
  }

  // =========================
  // ADD BOOK
  // =========================

  Future addBook() async {

    if (titleController.text.isEmpty ||
        authorController.text.isEmpty ||
        genreController.text.isEmpty ||
        descriptionController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            "Заполните все поля",
          ),
        ),
      );

      return;
    }

    if (pdfBytes == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            "Выберите PDF файл",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      // =====================
      // UPLOAD PDF
      // =====================

      var uploadResult =
      await ApiService.uploadPdfWeb(

        pdfBytes: pdfBytes!,
        fileName: pdfName,
      );

      if (!mounted) return;

      if (uploadResult["success"] != true) {

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(

            backgroundColor: Colors.red,

            content: Text(
              uploadResult["message"],
            ),
          ),
        );

        return;
      }

      String filePath =
      uploadResult["file_path"];

      // =====================
      // ADD BOOK
      // =====================

      var result =
      await ApiService.addBook(

        title: titleController.text,

        author: authorController.text,

        genre: genreController.text,

        description:
        descriptionController.text,

        filePath: filePath,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (result["success"] == true) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            backgroundColor: Colors.green,

            content: Text(
              "Книга добавлена",
            ),
          ),
        );

        Navigator.pop(context);

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(

            backgroundColor: Colors.red,

            content: Text(
              result["message"],
            ),
          ),
        );
      }

    } catch (e) {

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            "Ошибка: $e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Добавить книгу",
        ),
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

              maxLines: 4,

              decoration:
              const InputDecoration(
                labelText: "Описание",
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                onPressed: pickPdf,

                icon: const Icon(
                  Icons.upload_file,
                ),

                label: Text(

                  pdfName.isEmpty

                      ? "Выбрать PDF"

                      : pdfName,
                ),
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

                    ? const CircularProgressIndicator(
                  color:
                  Colors.white,
                )

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