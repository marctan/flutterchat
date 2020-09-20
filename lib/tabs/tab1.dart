import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab 1'),
      ),
      body: Center(
        child: Text(
          'I am Tab 1',
        ),
      ),
    );
  }
}
