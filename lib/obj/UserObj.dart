import 'package:flutter/cupertino.dart';

import '../Const.dart';

class UserObj {
  String name;
  int group;
  Roles role;
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
  UserObj(group: 0, name: "קפטן", role: Roles.CAPTAIN_BLUE),
  UserObj(group: 0, name: "שחקן", role: Roles.GUESSER_BLUE),
];

final List<UserObj> group2 = [
  UserObj(group: 1, name: "קפטן", role: Roles.CAPTAIN_RED),
  UserObj(group: 1, name: "שחקן", role: Roles.GUESSER_RED),
];

final Map<int, List<UserObj>> users = {0: group1, 1: group2};
