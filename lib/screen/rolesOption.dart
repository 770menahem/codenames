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
              } catch (e) {
                print(e);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "תפקיד",
          ),
        ),
      ),
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
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              btn("קפטן כחול", 0, Colors.blue, room.setCaptainToBlue),
              btn("קפטן אדום", 0, Colors.red, room.setCaptainToRed),
              btn("מנחש כחול", 1, Colors.blue, room.addGesserToBlue),
              btn("מנחש אדום", 1, Colors.red, room.addGesserToRed),
            ],
          ),
        ),
      ),
    );
  }
}
