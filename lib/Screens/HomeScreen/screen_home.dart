import 'package:chat_application_3/Screens/ChatRoom/chat_room.dart';
import 'package:chat_application_3/Screens/HomeScreen/Widgets/chat_tile.dart';
import 'package:chat_application_3/Screens/HomeScreen/Widgets/serach_tile.dart';
import 'package:chat_application_3/Services/chat_services.dart';
import 'package:chat_application_3/Services/user_services.dart';
import 'package:chat_application_3/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool _isVisible = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.03,
                right: 20,
                left: 20,
                bottom: MediaQuery.sizeOf(context).height * 0.04),
            child: _isVisible
                ? Row(
                    children: [
                      Expanded(
                          child: Material(
                        elevation: 10,
                        child: TextFormField(
                          onChanged: (value) async {
                            if (value.isNotEmpty) {
                              _searchList = await UserServices()
                                  .getAllUsersBySearchData(value);
                            }

                            setState(() {});
                          },
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = false;
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ))
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ChatApp",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = true;
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: _isVisible
                  ? ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(10),
                        child: SearchTile(
                          userData: _searchList[index].data(),
                          onTap: () async {
                            await ChatServices()
                                .createChatRoom(_searchList[index].data());
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                userInfo: _searchList[index].data(),
                              ),
                            ));
                          },
                        ),
                      ),
                      itemCount: _searchList.length,
                    )
                  : StreamBuilder(
                      stream:
                          ChatServices().getAllcontactsAlreadyStartChatting(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];

                                  return Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ChatTile(
                                          uid: ChatServices()
                                              .replacecurrentUserUid(data.id),
                                          chatData: data.data()));
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            } else {
                              return const Center(
                                child: Text("No Chat Available"),
                              );
                            }
                          } else {
                            return Text("No Data Found");
                          }
                        }
                      },
                    ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await UserServices().logout();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ScreenWrapper(),
          ));
        },
      ),
    );
  }
}
