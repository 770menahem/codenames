import 'package:firebase_auth/firebase_auth.dart';
import 'package:newkodenames/obj/MyUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFBUser(User user) {
    return user != null ? MyUser(uid: user.uid, name: user.displayName) : null;
  }

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFBUser);
  }

  String get name {
    return _auth.currentUser.displayName;
  }

  Future singInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      user.updateProfile(displayName: 'אורח');
      return _userFromFBUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;

      return _userFromFBUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      print(name);
      print(email);
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;

      user.updateProfile(displayName: name);

      print("\n\n\n" + user.displayName + "\n\n\n");

      return _userFromFBUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
