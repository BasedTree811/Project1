import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BorrowingsScreen extends StatefulWidget {

  final String userId;

  const BorrowingsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<BorrowingsScreen> createState() =>
      _BorrowingsScreenState();
}

class _BorrowingsScreenState
    extends State<BorrowingsScreen> {

  List borrowings = [];

  bool isLoading = true;

  Future loadBorrowings() async {

    try {

      var response = await http.post(

        Uri.parse(
          "http://127.0.0.1/library_api/get_borrowings.php",
        ),

        body: {
          "id_user": widget.userId,
        },
      );

      borrowings =
          jsonDecode(response.body);

    } catch (e) {

      borrowings = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {

    super.initState();

    loadBorrowings();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Выданные книги",
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : borrowings.isEmpty

          ? const Center(
        child: Text(
          "Нет выданных книг",
        ),
      )

          : ListView.builder(

        itemCount:
        borrowings.length,

        itemBuilder:
            (context, index) {

          var book =
          borrowings[index];

          DateTime returnDate =
          DateTime.parse(
            book["return_date"],
          );

          int daysLeft =
              returnDate
                  .difference(
                DateTime.now(),
              )
                  .inDays;

          return Card(

            margin:
            const EdgeInsets.all(
              10,
            ),

            child: ListTile(

              title: Text(
                book["title"],
              ),

              subtitle: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Дата выдачи: ${book["borrow_date"]}",
                  ),

                  Text(
                    "Вернуть до: ${book["return_date"]}",
                  ),

                  Text(
                    "Осталось дней: $daysLeft",
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