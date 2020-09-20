import 'package:chatapp/screens/signin.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/user_provider.dart';
import 'package:chatapp/tabs/tab1.dart';
import 'package:chatapp/tabs/tab2.dart';
import 'package:chatapp/tabs/tab3.dart';
import 'package:chatapp/tabs/tab4.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Users(),
        )
      ],
      child: MaterialApp(
        title: 'ChatApp',
        home: SignIn(),
        theme: ThemeData(
          primaryColor: Color(0xFF2B465A),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _tabs = [Tab1(), Tab2(), Tab3(), Tab4()];
  var _currentIndex = 0;
  setTabPage(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        onTap: (index) => setTabPage(index),
        items: [
          BottomNavigationBarItem(
            title: Text('tab 1'),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('tab 2'),
            icon: Icon(
              Icons.menu,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('tab 3'),
            icon: Icon(
              Icons.folder_open,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('tab 4'),
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
