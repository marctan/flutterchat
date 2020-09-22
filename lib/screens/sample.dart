import 'package:flutter/material.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: deviceHeight * .5,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('Button 1'),
                onPressed: () {},
              ),
            ),
            Container(
              height: deviceHeight * .5,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('Button 2'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
