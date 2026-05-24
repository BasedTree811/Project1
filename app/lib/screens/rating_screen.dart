import 'package:flutter/material.dart';

class RatingScreen
    extends StatelessWidget {

  const RatingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Рейтинг читателей",
        ),
      ),

      body: ListView(

        children: const [

          ListTile(

            leading: CircleAvatar(
              child: Text("1"),
            ),

            title:
            Text("Admin"),

            trailing:
            Text("150 баллов"),
          ),

          ListTile(

            leading: CircleAvatar(
              child: Text("2"),
            ),

            title:
            Text("User"),

            trailing:
            Text("95 баллов"),
          ),
        ],
      ),
    );
  }
}