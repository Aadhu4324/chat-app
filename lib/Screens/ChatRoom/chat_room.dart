import 'package:chat_application_3/Screens/ChatRoom/Widgets/message_enter_field.dart';
import 'package:chat_application_3/Screens/ChatRoom/Widgets/message_tile.dart';
import 'package:chat_application_3/Services/chat_services.dart';

import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  const ChatRoom({super.key, required this.userInfo});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.pink),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined)),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.35,
                  ),
                  Text(
                    widget.userInfo["Name"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(25),
                  child: StreamBuilder(
                      stream: ChatServices().getAllChats(widget.userInfo['Uid']),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  return MessageTile(
                                      isme: ChatServices().isme(data["sentBy"]),
                                      message: data["Message"]);
                                },
                                itemCount: snapshot.data!.docs.length,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      })),
            ),
            MessageEnterField(
              controller: _controller,
              onPressed: () {
                final message= _controller.text;
                ChatServices()
                    .sentMessage(message, widget.userInfo["Uid"])
                    .then(
                  (value) {
                    ChatServices()
                        .lastMessage(message, widget.userInfo["Uid"]);
                  },
                );
                _controller.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
