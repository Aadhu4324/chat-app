import 'dart:developer';

import 'package:chat_application_3/Screens/ChatRoom/chat_room.dart';
import 'package:chat_application_3/Services/user_services.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final Map<String, dynamic> chatData;
  final String uid;
  const ChatTile({super.key, required this.chatData, required this.uid});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  Map<String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    getUserInfo(widget.uid);
  }

  getUserInfo(String uid) async {
    userData = await UserServices().getUserDatabyUid(uid);
    log(userData!["Name"].toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatRoom(userInfo: userData!),
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 39,
            backgroundColor: Colors.black,
            child: CircleAvatar(radius: 35, child: Icon(Icons.person)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userData == null
                  ? Text("Name")
                  : Text(
                      userData!["Name"],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              Text(
                widget.chatData['lastMessage'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Spacer(),
          Text("4:30PM")
        ],
      ),
    );
  }
}
