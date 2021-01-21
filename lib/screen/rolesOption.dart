import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/Database.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class RoleOption extends StatelessWidget {
  final DatabadeService databadeService = DatabadeService();

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => onTap("1234", "blueGroup"),
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
              btn("קפטן כחול", 0, Colors.blue, databadeService.addCaptain),
              btn("קפטן אדום", 0, Colors.red, gameRoom.setCaptainToRed),
              btn("מנחש כחול", 1, Colors.blue, gameRoom.addGesserToBlue),
              btn("מנחש אדום", 1, Colors.red, gameRoom.addGesserToRed),
            ],
          ),
        ),
      ),
    );
  }
}
