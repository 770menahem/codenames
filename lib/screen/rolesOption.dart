import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:newkodenames/obj/Room.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class RoleOption extends StatelessWidget {
  final Room room = Room();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final bCap = Provider.of<Room>(context).hasBlueCaptain;
    final rCap = Provider.of<Room>(context).hasRedCaptain;

    Container btn(String txt, int imgIndex, Color color, Function onTap) {
      return Container(
          width: 150.0,
          margin: EdgeInsets.all(10.0),
          child: FlatButton(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(img[imgIndex]),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(txt),
              ],
            ),
            color: color,
            onPressed: () {
              try {
                onTap(user);
                Navigator.pushNamed(context, '/game');
              } catch (e) {
                print(e);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ));
    }

    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.blue[800], Colors.red],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 350.0, 70.0));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red,
              Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "בחר תפקיד",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!bCap)
                    btn("קפטן כחול", 0, Colors.blue, room.setCaptainToBlue),
                  if (!rCap)
                    btn("קפטן אדום", 0, Colors.red, room.setCaptainToRed),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn("מנחש כחול", 1, Colors.blue, room.addGesserToBlue),
                  btn("מנחש אדום", 1, Colors.red, room.addGesserToRed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
