import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {
  final Map userData;

  const HistoryScreen({
    super.key,
    required this.userData,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future loadHistory() async {
    var data = await ApiService.getHistory(
      userId: widget.userData["id_user"].toString(),
    );

    setState(() {
      history = data;
      isLoading = false;
    });
    print(widget.userData);
    print(data);
    print(widget.userData);
    print(widget.userData["id_user"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // светлый фон

      appBar: AppBar(
        title: const Text(
          "История чтения",
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
          : history.isEmpty
          ? const Center(
        child: Text(
          "История пуста",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          var book = history[index];
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
                      Icons.history,
                      color: Colors.deepPurple,
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