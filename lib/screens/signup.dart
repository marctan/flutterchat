import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  var username;
  var password;
  var email;
  var _isLoading = false;

  final authService = serviceLocator<Auth>();
  final dbService = serviceLocator<Database>();

  submitForm() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await authService.signUpWithEmailPassword(email, password);
      if (user != null) {
        await dbService.addUserToDb(username, email);
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Registered Successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: EdgeInsets.all(
          40,
        ),
        child: Form(
          key: formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) {
                          username = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (val) {
                          email = val;
                        },
                        validator: (val) {
                          if (val.isEmpty || !EmailValidator.validate(val)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (val) {
                          password = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),SizedBox(height: 30),
                _isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        width: MediaQuery.of(context).size.width * .5,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            submitForm();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
