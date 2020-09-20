import 'package:chatapp/screens/chat.dart';
import 'package:chatapp/screens/friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D5673),
      appBar: AppBar(
        toolbarHeight: 120,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MY STUFF',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildListTile(
            Feather.users,
            'FRIENDS',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Friends();
                  },
                ),
              );
            },
          ),
          _buildListTile(
            SimpleLineIcons.like,
            'LIKES',
          ),
          _buildListTile(
            SimpleLineIcons.star,
            'FOLLOWING',
          ),
          _buildListTile(
            Zocial.bitbucket,
            'BUCKET LIST',
          ),
          _buildListTile(
            MaterialIcons.chat_bubble_outline,
            'CHAT',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Chat();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  ListTile _buildListTile(leading, title, [Function ontap]) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        leading,
        color: Color(
          0xFF3C8AB0,
        ),
        size: 40,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        MaterialIcons.keyboard_arrow_right,
        color: Colors.white,
      ),
    );
  }
}
