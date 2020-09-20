import 'package:chatapp/screens/conversation.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textValue = TextEditingController();

  final dbService = serviceLocator<Database>();
  String searchValue = "";

  openConversation(String friendUserName) async {
    final pref = await SharedPreferences.getInstance();
    final myusername = pref.getString("myusername");

    if (friendUserName != myusername) {
      List<String> users = [myusername, friendUserName];

      String chatRoomId = getChatRoomId(myusername, friendUserName);

      Map<String, dynamic> chatRoom = {
        "users": users,
        "chatRoomId": chatRoomId,
      };

      await dbService.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Conversation(
            chatRoomId: chatRoomId,
          ),
        ),
      );
    }
  }

  getChatRoomId(String a, String b) {
    // if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    //   return "$b\_$a";
    // } else {
    //   return "$a\_$b";
    // }

    if (a.hashCode <= b.hashCode) {
      return '$a\_$b';
    } else {
      return '$b\_$a';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search User'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textValue,
                    decoration: InputDecoration(
                      hintText: 'Enter username',
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    //final snapshot = await dbService.queryUser(textValue.text);
                    //provider.setUsers(snapshot.docs);
                    setState(() {
                      searchValue = textValue.text;
                    });
                  },
                  minWidth: 0,
                  height: 0,
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      String friendUserName;
                      return ListTile(
                        onTap: () async {
                          await openConversation(friendUserName);
                        },
                        title: Text(
                          friendUserName =
                              snapshot.data.docs[index].get('name'),
                        ),
                        subtitle: Text(
                          snapshot.data.docs[index].get('email'),
                        ),
                        trailing: Icon(
                          Icons.message,
                        ),
                      );
                    },
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data.docs.length,
                  );
                } else if (snapshot.error) {
                  print(snapshot.error);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              stream: dbService.queryUser(searchValue),
            ),
          )
        ],
      ),
    );
  }
}
