import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<bool> signinUser(String email, String password) async {
    UserCredential? user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(String email, String password, String name) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (user.user != null) {
      _store.collection("Users").doc(user.user!.uid).set({
        "Name": name,
        "Uid": user.user!.uid,
        "E-mail": email,
        "createdAt": FieldValue.serverTimestamp()
      });
      return true;
    }
    return false;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllUsersBySearchData(String name) async {
    final _snap = await _store
        .collection("Users")
        .where("Uid", isNotEqualTo: _auth.currentUser!.uid)
        .get();
    return _snap.docs.where(
      (element) {
        String name2 = element["Name"];
        return name2.contains(name);
      },
    ).toList();
  }

  Future<Map<String, dynamic>> getUserDatabyUid(String uid) async {
    final data =
        await _store.collection("Users").where('Uid', isEqualTo: uid).get();

    return data.docs[0].data();
  }
}
