import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:newkodenames/screen/GameMenu.dart';
import 'package:provider/provider.dart';

import 'signin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            "שם קוד",
          ),
        ),
      ),
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'הי\nבואו\nנשמקד',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.w900,
              ),
            ),
            (user != null) ? GameMenu() : SignIn(),
          ],
        ),
      ),
    );
  }
}
