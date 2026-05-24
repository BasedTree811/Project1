import 'package:flutter/material.dart';

class HistoryScreen
    extends StatelessWidget {

  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "История чтения",
        ),
      ),

      body: ListView(

        children: const [

          ListTile(
            leading:
            Icon(Icons.history),

            title:
            Text("Гарри Поттер"),

            subtitle:
            Text("Прочитано"),
          ),

          ListTile(
            leading:
            Icon(Icons.history),

            title:
            Text("Война и мир"),

            subtitle:
            Text("Прочитано"),
          ),
        ],
      ),
    );
  }
}