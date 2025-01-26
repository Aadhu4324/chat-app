import 'package:flutter/material.dart';

class MessageEnterField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  const MessageEnterField({super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                  elevation: 10,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          scrollPadding: EdgeInsets.all(10),
                          decoration: InputDecoration(
                              hintText: "Enter a Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )),
                        ),
                      ),
                      IconButton(
                         onPressed:onPressed ,
                          icon: Icon(Icons.send))
                    ],
                  )),
            );
  }
}