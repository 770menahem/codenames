import 'package:flutter/cupertino.dart';

class MyUser {
  final String uid;
  final String name;
  bool isOwner = false;

  MyUser({
    @required this.name,
    @required this.uid,
  });

  void makeOnner() {
    this.isOwner = true;
  }
}
