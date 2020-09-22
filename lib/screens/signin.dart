import 'package:chatapp/const/constants.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  final authService = serviceLocator<Auth>();

  final dbService = serviceLocator<Database>();

  final formKey = GlobalKey<FormState>();

  var showPassword = true;

  togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(
                  40,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty || !EmailValidator.validate(val)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        controller: userNameController,
                        decoration: InputDecoration(
                          labelText: 'email',
                        ),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                            obscureText: showPassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Login(formKey,
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

class Login extends StatefulWidget {
  const Login(
    this.formKey, {
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
  final GlobalKey<FormState> formKey;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isLoading
            ? CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (!widget.formKey.currentState.validate()) {
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });
                    var user;
                    try {
                      user = await widget.authService.signInWithEmailPassword(
                        widget.userNameController.text,
                        widget.passwordController.text,
                      );
                      if (user != null) {
                        //save preference
                        final pref = await SharedPreferences.getInstance();
                        final snapshot = await widget.dbService
                            .getNameByEmail(widget.userNameController.text);
                        pref.setString('email', user.email);
                        pref.setString('uid', user.uid);
                        pref.setString(
                            'myusername', snapshot.docs[0].get('name'));
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
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
              ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return SignUp();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
