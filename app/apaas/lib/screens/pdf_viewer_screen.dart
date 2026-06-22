import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerScreen extends StatefulWidget {
  final String url;
  final String title;

  const PdfViewerScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool isOpening = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _openPdf();
  }

  Future<void> _openPdf() async {
    final uri = Uri.parse(widget.url);

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!mounted) return;

      if (opened) {
        Navigator.pop(context);
      } else {
        setState(() {
          isOpening = false;
          errorMessage = "Не удалось открыть PDF";
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isOpening = false;
        errorMessage = "Не удалось открыть PDF";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: isOpening
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.deepPurple),
                  SizedBox(height: 16),
                  Text("Открываем PDF..."),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage ?? "Ошибка",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isOpening = true;
                          errorMessage = null;
                        });
                        _openPdf();
                      },
                      child: const Text("Попробовать снова"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
