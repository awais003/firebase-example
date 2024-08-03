
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

  // RESET PASSWORD
  Future<void> resetPassword(String email) async  {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        return Future.error(e.message!);
      }
    }
  }

  // SIGNUP
  Future<void> signup(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        return Future.error(e.message!);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // VERIFY PHONE NUMBER
  Future<void> verifyPhoneNumber(String phoneNumber, {Function(String verificationId)? onCodeSent,
    Function(String error)? onError}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (onError != null) {
          onError(e.message!);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (onCodeSent != null) {
          onCodeSent(verificationId);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (onError != null) {
          onError("Code retrieval timeout");
        }
      },
    );
  }

  // VERIFY OTP
  Future<void> verifyOtp(String verificationId, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId,
        smsCode: code);
    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        return Future.error(e.message!);
      }
    }
  }

}