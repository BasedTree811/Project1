import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PdfUploadField extends StatefulWidget {
  final TextEditingController controller;

  const PdfUploadField({
    super.key,
    required this.controller,
  });

  @override
  State<PdfUploadField> createState() => _PdfUploadFieldState();
}

class _PdfUploadFieldState extends State<PdfUploadField> {
  bool isUploading = false;
  String? selectedFileName;

  Future<void> pickAndUploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (file.bytes == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Не удалось прочитать файл"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      isUploading = true;
      selectedFileName = file.name;
    });

    final uploadResult = await ApiService.uploadPdf(
      pdfBytes: file.bytes!,
      fileName: file.name,
    );

    if (!mounted) return;

    setState(() => isUploading = false);

    if (uploadResult["success"] == true) {
      widget.controller.text = uploadResult["file_path"]?.toString() ?? "";
      setState(() {
        selectedFileName = file.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PDF загружен"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(uploadResult["message"]?.toString() ?? "Ошибка загрузки"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPdf = widget.controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: hasPdf ? "PDF файл загружен" : "PDF файл",
            labelStyle: TextStyle(color: Colors.grey.shade700),
            prefixIcon: Icon(
              hasPdf ? Icons.check_circle : Icons.picture_as_pdf,
              color: hasPdf ? Colors.green : Colors.deepPurple,
            ),
            hintText: "Выберите PDF файл",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: OutlinedButton.icon(
            onPressed: isUploading ? null : pickAndUploadPdf,
            icon: isUploading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.upload_file),
            label: Text(
              isUploading
                  ? "Загрузка..."
                  : selectedFileName ?? "Выбрать PDF файл",
              overflow: TextOverflow.ellipsis,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepPurple,
              side: const BorderSide(color: Colors.deepPurple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
