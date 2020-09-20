import 'package:chatapp/const/constants.dart';
import 'package:chatapp/screens/conversation.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final dbService = serviceLocator<Database>();
  Stream<QuerySnapshot> allChats;

  Widget chatsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: allChats,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (_, index) {
              final chatRoomId = snapshot.data.docs[index].data()['chatRoomId'];
              List users = chatRoomId.toString().split("_");
              var senderName;
              if( users.length > 1) {
                if(users[0] != Constants.myUserName) {
                  senderName = users[0];
                } else {
                  senderName = users[1];
                }
              }
              return ListTile(
                leading: Icon(Icons.chat_bubble),
                title: Text(
                  senderName
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return Conversation(
                          chatRoomId: chatRoomId,
                        );
                      },
                    ),
                  );
                },
              );
            },
            itemCount: snapshot.data.docs.length,
          );
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
        }
        return Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    allChats = dbService.getChats(Constants.myUserName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY STUFF"),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
              bottom: 10,
              left: 20,
            ),
            child: Text(
              "Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(
            50.0,
          ),
        ),
      ),
      body: chatsList(),
    );
  }
}
