import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Stream<QuerySnapshot> queryUser(username) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .snapshots();
  }

  //todo after signup call this
  Future<void> addUserToDb(username, email) async {
    final userMap = {
      'email': email, //email
      'name': username, //username
    };
    try {
      await FirebaseFirestore.instance.collection('users').add(userMap);
    } catch (error) {
      throw (error);
    }
  }

  Future<QuerySnapshot> getNameByEmail(email) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
  }

  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom);
  }

  Future<void> addMessage(messageBody, sender, chatRoomId) async {
    final map = {
      'message': messageBody,
      'sender': sender,
      'time': DateTime.now().millisecondsSinceEpoch
    };

    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(map);
  }

  Stream<QuerySnapshot> getAllMessage(chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Stream<QuerySnapshot> getChats(username) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where(
          'users',
          arrayContains: username,
        )
        .snapshots();
  }
}
