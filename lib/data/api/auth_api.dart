
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {

  final _auth = FirebaseAuth.instance;

  // IS LOGGED IN
  // return true or false base on user is logged in or not
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // LOGIN
  Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        return Future.error(e.message!);
      }
    }
  }
}