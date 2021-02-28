import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/firebase/service/authService.dart';

class GameMenu extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnApp(
            Text("היכנס למשחק"),
            Colors.indigo[50],
            () {
              Navigator.pushNamed(context, '/joinroom');
            },
          ),
          btnApp(
            Text("צור משחק"),
            Colors.indigo[50],
            () {
              Navigator.pushNamed(context, "/newroom");
            },
          ),
          btnApp(
            Text("צור/הסר מילים"),
            Colors.indigo[50],
            () {
              Navigator.pushNamed(context, "/addWord");
            },
          ),
          btnApp(
            Text("התנתק"),
            Colors.indigo[50],
            () {
              _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
