import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RatingScreen extends StatefulWidget {

  const RatingScreen({
    super.key,
  });

  @override
  State<RatingScreen> createState() =>
      _RatingScreenState();
}

class _RatingScreenState
    extends State<RatingScreen> {

  List users = [];

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadRating();
  }

  Future loadRating() async {

    var data =
    await ApiService.getRating();

    setState(() {

      users = data;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Рейтинг читателей",
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : ListView.builder(

        itemCount:
        users.length,

        itemBuilder:
            (context, index) {

          var user =
          users[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              leading: CircleAvatar(

                child: Text(
                  "${index + 1}",
                ),
              ),

              title: Text(
                user["name"] ?? "",
              ),

              subtitle: Text(
                user["login"] ?? "",
              ),

              trailing: Text(

                "${user["rating"]}",

                style:
                const TextStyle(

                  fontSize: 20,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}