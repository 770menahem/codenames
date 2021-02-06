import 'package:flutter/cupertino.dart';

import '../Const.dart';

class UserObj {
  String name;
  int group;
  String role;
  bool isOwner;

  UserObj({
    this.isOwner = false,
    @required this.group,
    @required this.name,
    @required this.role,
  });

  get owner => this.isOwner;
  void makeOwner() => this.isOwner = true;
}

final List<UserObj> group1 = [
  UserObj(group: 0, name: "קפטן", role: captain),
  UserObj(group: 0, name: "שחקן", role: "gasser"),
];

final List<UserObj> group2 = [
  UserObj(group: 1, name: "קפטן", role: captain),
  UserObj(group: 1, name: "שחקן", role: "gasser"),
];

final Map<int, List<UserObj>> users = {0: group1, 1: group2};
