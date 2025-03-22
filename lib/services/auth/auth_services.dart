import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //instance
  final _auth = FirebaseAuth.instance;

  //get current user id
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  //login
  Future<UserCredential> loginEmailPassword(String email, password) async {
    //try login
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //register
  Future<UserCredential> registerEmailPassword(String email, password) async {
    //try to register
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //log out
  Future<void> logout() async {
    await _auth.signOut();
  }
}
