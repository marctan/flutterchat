import 'package:chatapp/screens/search.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Search();
                  },
                ),
              );
            },
            child: Icon(Icons.add, color: Colors.white,),
          ),
        ],
        title: Text("MY STUFF"),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
              bottom: 10,
              left: 20,
            ),
            child: Text(
              "Friends",
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
      body: Center(
        child: Text('Friends'),
      ),
    );
  }
}
