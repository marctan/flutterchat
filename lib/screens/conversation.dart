import 'package:chatapp/const/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Conversation extends StatefulWidget {
  final chatRoomId;

  Conversation({this.chatRoomId});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  Stream<QuerySnapshot> allMessageStream;
  final messageController = TextEditingController();

  final dbService = serviceLocator<Database>();

  sendMessage(chatRoomId, String message) async {
    if (message.isNotEmpty) {
      final pref = await SharedPreferences.getInstance();
      await dbService.addMessage(
        message,
        pref.getString('myusername'),
        chatRoomId,
      );
      messageController.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    allMessageStream = dbService.getAllMessage(widget.chatRoomId);
  }

  Widget chatList() {
    return StreamBuilder<QuerySnapshot>(
      stream: allMessageStream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (_, index) {
              return MessageTile(
                snapshot.data.docs[index].get('message'),
                snapshot.data.docs[index].get('sender'),
              );
            },
            itemCount: snapshot.data.docs.length,
          );
        } else if (snapshot.error) {
          print(
            snapshot.error.toString(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Container(
          //alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: chatList(),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter Message',
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      sendMessage(
                        widget.chatRoomId,
                        messageController.text,
                      );
                    },
                    minWidth: 0,
                    height: 0,
                    child: Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class MessageTile extends StatelessWidget {
  final message;
  final sender;

  MessageTile(
    this.message,
    this.sender,
  );

  @override
  Widget build(BuildContext context) {
    final senderIsMe = sender == Constants.myUserName;

    return Container(
      padding: EdgeInsets.all(
        10,
      ),
      alignment: senderIsMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          color: senderIsMe ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
