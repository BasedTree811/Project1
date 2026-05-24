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

  final controller =
  TextEditingController();

  List messages = [];

  @override
  void initState() {
    super.initState();

    loadMessages();
  }

  void loadMessages() async {

    messages =
    await ApiService.getMessages(
      widget.userData["id_user"],
    );

    setState(() {});
  }

  void sendMessage() async {

    if (controller.text.isEmpty) return;

    await ApiService.sendMessage(

      idUser:
      widget.userData["id_user"],

      message: controller.text,

      sender: "user",
    );

    controller.clear();

    loadMessages();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Чат с библиотекарем",
        ),
      ),

      body: Column(

        children: [

          Expanded(

            child: ListView.builder(

              itemCount:
              messages.length,

              itemBuilder:
                  (context, index) {

                var msg =
                messages[index];

                bool isUser =
                    msg["sender"] ==
                        "user";

                return Align(

                  alignment: isUser

                      ? Alignment
                      .centerRight

                      : Alignment
                      .centerLeft,

                  child: Container(

                    margin:
                    const EdgeInsets
                        .all(10),

                    padding:
                    const EdgeInsets
                        .all(15),

                    decoration:
                    BoxDecoration(

                      color: isUser
                          ? Colors.blue
                          : Colors.grey
                          .shade300,

                      borderRadius:
                      BorderRadius
                          .circular(15),
                    ),

                    child: Text(

                      msg["message"],

                      style: TextStyle(

                        color: isUser
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(

            padding:
            const EdgeInsets.all(
              10,
            ),

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