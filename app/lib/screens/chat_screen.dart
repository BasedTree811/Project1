import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ChatScreen extends StatefulWidget {

  final Map userData;

  const ChatScreen({

    super.key,

    required this.userData,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {

  List messages = [];

  final TextEditingController
  controller =
  TextEditingController();

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadMessages();
  }

  Future<void> loadMessages() async {

    var data =
    await ApiService.getMessages();

    setState(() {

      messages = data;

      isLoading = false;
    });
  }

  Future<void> sendMessage() async {

    if (controller.text.isEmpty) {
      return;
    }

    await ApiService.sendMessage(

      user:
      widget.userData["login"],

      message: controller.text,
    );

    controller.clear();

    loadMessages();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Чат"),
      ),

      body: Column(

        children: [

          Expanded(

            child: isLoading

                ? const Center(
              child:
              CircularProgressIndicator(),
            )

                : ListView.builder(

              itemCount:
              messages.length,

              itemBuilder:
                  (context, index) {

                var message =
                messages[index];

                return ListTile(

                  title: Text(
                    message["user"],
                  ),

                  subtitle: Text(
                    message["message"],
                  ),
                );
              },
            ),
          ),

          Padding(

            padding:
            const EdgeInsets.all(10),

            child: Row(

              children: [

                Expanded(

                  child: TextField(

                    controller:
                    controller,

                    decoration:
                    const InputDecoration(

                      hintText:
                      "Введите сообщение",
                    ),
                  ),
                ),

                IconButton(

                  onPressed:
                  sendMessage,

                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}