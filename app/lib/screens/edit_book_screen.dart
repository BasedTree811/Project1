import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/api_service.dart';

class EditBookScreen
    extends StatefulWidget {

  final Book book;

  const EditBookScreen({
    super.key,
    required this.book,
  });

  @override
  State<EditBookScreen>
  createState() =>
      _EditBookScreenState();
}

class _EditBookScreenState
    extends State<EditBookScreen> {

  late TextEditingController
  titleController;

  late TextEditingController
  authorController;

  late TextEditingController
  genreController;

  late TextEditingController
  descriptionController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
          text: widget.book.title,
        );

    authorController =
        TextEditingController(
          text: widget.book.author,
        );

    genreController =
        TextEditingController(
          text: widget.book.genre,
        );

    descriptionController =
        TextEditingController(
          text: widget.book.description,
        );
  }

  void updateBook() async {

    await ApiService.updateBook(

      id: widget.book.id,

      title: titleController.text,

      author: authorController.text,

      genre: genreController.text,

      description:
      descriptionController.text,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content:
        Text("Книга обновлена"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Редактирование",
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller:
              titleController,
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              authorController,
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              genreController,
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
              descriptionController,
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed:
                updateBook,

                child: const Text(
                  "Сохранить",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}