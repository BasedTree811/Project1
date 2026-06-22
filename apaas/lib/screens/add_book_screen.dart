import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/pdf_upload_field.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final genreController = TextEditingController();
  final descriptionController = TextEditingController();
  final pdfController = TextEditingController();

  bool isLoading = false;

  Future addBook() async {
    if (titleController.text.isEmpty ||
        authorController.text.isEmpty ||
        genreController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        pdfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Заполните все поля"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final result = await ApiService.addBook(
      title: titleController.text,
      author: authorController.text,
      genre: genreController.text,
      description: descriptionController.text,
      filePath: pdfController.text,
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (result["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Книга добавлена!"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result["message"]?.toString() ?? "Ошибка"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Светлый фон вместо стандартного
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        title: const Text(
          "Добавить книгу",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2. Карточка-обёртка для полей (визуальное выделение)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Поле "Название" с иконкой
                    _buildTextField(
                      controller: titleController,
                      label: 'Название',
                      icon: Icons.title,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Поле "Автор"
                    _buildTextField(
                      controller: authorController,
                      label: 'Автор',
                      icon: Icons.person,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Поле "Жанр"
                    _buildTextField(
                      controller: genreController,
                      label: 'Жанр',
                      icon: Icons.category,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Поле "Описание" (многострочное)
                    _buildTextField(
                      controller: descriptionController,
                      label: 'Описание',
                      icon: Icons.description,
                      maxLines: 4,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    PdfUploadField(controller: pdfController),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 3. Кнопка добавления — яркая, с тенью и анимацией нажатия
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: isLoading ? null : addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
                    : const Text("➕  Добавить книгу"),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Небольшая подсказка (дополнительный UX)
            Center(
              child: Text(
                'Заполните все поля и загрузите PDF',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод для красивого поля ввода
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: textInputAction,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}