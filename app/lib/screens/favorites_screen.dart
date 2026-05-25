import 'package:flutter/material.dart';

import '../services/api_service.dart';

class FavoritesScreen
    extends StatefulWidget {

  final Map userData;

  const FavoritesScreen({

    super.key,

    required this.userData,
  });

  @override
  State<FavoritesScreen>
  createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {

  List favorites = [];

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadFavorites();
  }

  Future<void> loadFavorites() async {

    var data =
    await ApiService.getFavorites(

      userId:
      widget.userData["id"]
          .toString(),
    );

    setState(() {

      favorites = data;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Избранное"),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : ListView.builder(

        itemCount:
        favorites.length,

        itemBuilder:
            (context, index) {

          var book =
          favorites[index];

          return Card(

            margin:
            const EdgeInsets.all(
                10),

            child: ListTile(

              title: Text(
                book["title"],
              ),

              subtitle: Text(
                book["author"],
              ),
            ),
          );
        },
      ),
    );
  }
}