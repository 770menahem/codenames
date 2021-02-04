import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

import '../Const.dart';

class Guest extends StatelessWidget {
  final Function loading;
  final Function error;
  final AuthService auth;

  const Guest({Key key, this.loading, this.auth, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        loading(true);

        dynamic newUser = await auth.singInAnon();
        GameInfo().thisUser = newUser;

        if (newUser == null) {
          error('ההתחברות נכשלה נסה שוב');
          loading(false);
        }
      },
      color: Colors.pink,
      child: Text(
        'היכנס כאורח',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
