import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class Guest extends StatelessWidget {
  final Function loading;
  final Function error;
  final AuthService auth;

  const Guest({Key key, this.loading, this.auth, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return btnWidth(
      Text(
        'היכנס כאורח',
        style: TextStyle(color: Colors.white),
      ),
      Colors.pink,
      () async {
        loading(true);

        dynamic newUser = await auth.singInAnon();
        GameInfo().thisUser = newUser;

        if (newUser == null) {
          error('ההתחברות נכשלה נסה שוב');
          loading(false);
        }
      },
    );
  }
}
