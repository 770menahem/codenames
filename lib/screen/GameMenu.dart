import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';

class GameMenu extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton(
            color: Colors.indigo[50],
            onPressed: () {
              Navigator.pushNamed(context, '/joinroom');
            },
            child: Text("היכנס למשחק"),
          ),
          FlatButton(
            color: Colors.indigo[50],
            onPressed: () {
              Navigator.pushNamed(context, "/newroom");
            },
            child: Text("צור משחק"),
          ),
          FlatButton(
            color: Colors.indigo[50],
            onPressed: () {
              Navigator.pushNamed(context, "/addWord");
            },
            child: Text("צור/הסר מילים"),
          ),
          FlatButton(
            color: Colors.indigo[50],
            onPressed: () {
              _auth.signOut();
            },
            child: Text("התנתק"),
          ),
        ],
      ),
    );
  }
}
