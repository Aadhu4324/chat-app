import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final bool isme;
  final String message;
  const MessageTile({super.key, required this.isme, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
      padding: EdgeInsets.all(5),
      margin: isme
          ? EdgeInsets.only(right: MediaQuery.sizeOf(context).width / 3)
          : EdgeInsets.only(left: MediaQuery.sizeOf(context).width / 3),
      decoration: BoxDecoration(
          color: isme
              ? const Color.fromARGB(255, 10, 124, 224)
              : const Color.fromARGB(255, 210, 75, 120),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: isme ? Radius.circular(0) : Radius.circular(20),
              bottomRight: isme ? Radius.circular(20) : Radius.circular(0))),
      child: Center(
        child: Text(message, style: TextStyle(fontSize: 15.5,color: Colors.white),),
      ),
    ),
  );
  }
}