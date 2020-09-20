import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future<User> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (error) {
      throw (Exception(error));
    }
  }
}
