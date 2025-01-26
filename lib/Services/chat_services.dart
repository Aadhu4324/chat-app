import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ChatServices {
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Future<void> createChatRoom(Map<String, dynamic> chatInfo) async {
    String chatRoomId = generateChatRoomId(
        curretUserUid: _auth.currentUser!.uid, otherUseruid: chatInfo["Uid"]);
    final chatMap = {
      "Users": [_auth.currentUser!.uid, chatInfo['Uid']]
    };
    final snap = await _store.collection("ChatRom").doc(chatRoomId).get();
    if (snap.exists) {
    } else {
      _store.collection("ChatRoom").doc(chatRoomId).set(chatMap);
    }
  }

  Future<void> sentMessage(String message, String otherUserUid) async {
    String chatRoomId = generateChatRoomId(
        curretUserUid: _auth.currentUser!.uid, otherUseruid: otherUserUid);
    final messageInfoMap = {
      "Message": message,
      "sentBy": _auth.currentUser!.uid,
      "time": FieldValue.serverTimestamp()
    };
    final messageid = Uuid().v1();

    await _store
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("Chats")
        .doc(messageid)
        .set(messageInfoMap);
  }

  Future<void> lastMessage(String lastMessage, String otherUserUid) async {
    Map<String, dynamic> chatMap = {
      "lastMessage": lastMessage,
      "sendBy": _auth.currentUser!.uid,
      "ts": FieldValue.serverTimestamp()
    };
    String chatRoomId = generateChatRoomId(
        curretUserUid: _auth.currentUser!.uid, otherUseruid: otherUserUid);
    await _store.collection("ChatRoom").doc(chatRoomId).update(chatMap);
  }

  String generateChatRoomId(
      {required String curretUserUid, required String otherUseruid}) {
    if (curretUserUid.codeUnitAt(0) > otherUseruid.codeUnitAt(0)) {
      return curretUserUid + otherUseruid;
    } else {
      return otherUseruid + curretUserUid;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats(String otherUseruid) {
    String chatRoomId = generateChatRoomId(
        curretUserUid: _auth.currentUser!.uid, otherUseruid: otherUseruid);
    return _store
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("Chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  bool isme(String uid) {
    if (_auth.currentUser!.uid == uid) {
      return false;
    } else {
      return true;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllcontactsAlreadyStartChatting() {
    return _store
        .collection("ChatRoom").where("Users",arrayContains: _auth.currentUser!.uid).orderBy("ts",descending: true).snapshots();
  }
  String replacecurrentUserUid(String uid){
  return   uid.replaceAll(_auth.currentUser!.uid,"");
  } 
}
