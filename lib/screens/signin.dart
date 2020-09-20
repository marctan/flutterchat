import 'package:chatapp/const/constants.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget {
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final authService = serviceLocator<Auth>();
  final dbService = serviceLocator<Database>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: 'email'),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              Login(
                  authService: authService,
                  userNameController: userNameController,
                  passwordController: passwordController,
                  dbService: dbService),
            ],
          ),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key key,
    @required this.authService,
    @required this.userNameController,
    @required this.passwordController,
    @required this.dbService,
  }) : super(key: key);

  final Auth authService;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Database dbService;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Sign In'),
      onPressed: () async {
        var user;
        try {
          user = await authService.signInWithEmailPassword(
            userNameController.text,
            passwordController.text,
          );
          if (user != null) {
            //save preference
            final pref = await SharedPreferences.getInstance();
            final snapshot =
                await dbService.getNameByEmail(userNameController.text);
            pref.setString('email', user.email);
            pref.setString('uid', user.uid);
            pref.setString('myusername', snapshot.docs[0].get('name'));
            Constants.myUserName = snapshot.docs[0].get('name');
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                return Home();
              },
            ),
          );
        } catch (e) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString(),),
            ),
          );
        }
      },
    );
  }
}
