import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {

  final Map userData;

  const HistoryScreen({
    super.key,
    required this.userData,
  });

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {

  List history = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future loadHistory() async {



    var data =
    await ApiService.getHistory(

      userId:
      widget.userData["id_user"]
          .toString(),
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

      appBar: AppBar(
        title: const Text(
          "История чтения",
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : history.isEmpty

          ? const Center(
        child: Text(
          "История пуста",
        ),
      )

          : ListView.builder(

        itemCount:
        history.length,

        itemBuilder:
            (context, index) {

          var book =
          history[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              leading: const Icon(
                Icons.history,
              ),

              title: Text(
                book["title"] ?? "",
              ),

              subtitle: Text(
                book["author"] ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}