import 'package:flutter/cupertino.dart';
import 'package:newkodenames/Const.dart';

class MyUser {
  final String uid;
  final String name;
  bool isOwner = false;
  Roles role = Roles.CAPTAIN_BLUE;

  MyUser({
    @required this.name,
    @required this.uid,
  });

  void makeOnner() {
    this.isOwner = true;
  }

  void giveRole(Roles role) {
    this.role = role;
  }
}
